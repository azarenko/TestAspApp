﻿require.config({
    paths: {
        activeTestState: "/sitecore/shell/client/Sitecore/ContentTesting/ActiveTestState"
    }
});

define(["sitecore", "/-/speak/v1/ExperienceEditor/ExperienceEditor.js",
      "/-/speak/v1/contenttesting/RequestUtil.js",
      "activeTestState"],
    function (Sitecore, ExperienceEditor, RequestUtil, ActiveTestState) {
        // IE9 bug-fix
        Sitecore.ExperienceEditor = Sitecore.ExperienceEditor || {};
        Sitecore.ExperienceEditor.Hooks = Sitecore.ExperienceEditor.Hooks || [];

        var optimizationTabId = "TestingStrip_ribbon_tab";
        var testSummaryRetryLimit = 30;
        var testSummaryRetryCounter = 0;

        function removeCtElements() {
            var statusChunkElement = $("[data-sc-id='StatusChunk']");
            statusChunkElement.remove();

            var pageReportChunkElement = $("[data-sc-id='PageReports']");
            pageReportChunkElement.remove();

            var listsChunkElement = $("[data-sc-id='Lists']");
            listsChunkElement.remove();

            var createChunkElement = $("[data-sc-id='Create']");
            createChunkElement.remove();

            var el = $("#" + optimizationTabId);
            var indicatorExists = el.find("div.optimization-indicator").length > 0;

            if (indicatorExists) {
                el.find("div.optimization-indicator").remove();
            }
        }

        function setTestIndicator(hasTest) {
            var el = $("#" + optimizationTabId);
            var indicatorExists = el.find("div.optimization-indicator").length > 0;

            if (!hasTest) {
                el.find("div.optimization-indicator").remove();
            } else if (!indicatorExists) {
                el.prepend("<div class='optimization-indicator'></div>");
            }
        }

        function updateOptimizationTab(context) {
            var isEnabled;
            var hasTest = false;
            if (ActiveTestState) {
                hasTest = ActiveTestState.hasActiveTest(context);
            }

            ExperienceEditor.PipelinesUtil.generateRequestProcessor("Optimization.IsContentTestingEnabledRequest", function (response) {
                isEnabled = response.responseValue.value;
            }, context.currentContext).execute(context);

            if (!isEnabled) {
                removeCtElements();
                return;
            }

            setTestIndicator(hasTest);
        }

        function renderTestSummary(context) {
            var topwindow = window;
            while (topwindow.location.href !== topwindow.parent.location.href) {
                topwindow = topwindow.parent;
            }

            if (topwindow.scIsDialogsInitialized) {
                var testId;

                ExperienceEditor.PipelinesUtil.generateRequestProcessor("Optimization.GetTestSummaryTestId", function (response) {
                    testId = response.responseValue.value;
                }, context.currentContext).execute(context);

                if (testId != undefined && testId !== "") {
                    var testSummaryUrl = "/sitecore/client/Applications/ContentTesting/Dialogs/TestSummary?frameHeight=594&renderUrl=" + encodeURIComponent("/sitecore/shell/client/Applications/ContentTesting/Angular/dist/index.aspx#test-summary?testId=") + testId;

                    topwindow.initModalDialog(function () {
                        ExperienceEditor.Dialogs.showModalDialog(testSummaryUrl, "", null);
                    });
                }
            } else if (testSummaryRetryCounter < testSummaryRetryLimit) {
                testSummaryRetryCounter++;
                window.setTimeout(renderTestSummary, 1000);
            }
        }

        Sitecore.ExperienceEditor.Hooks.push({
            execute: function (context) {
                var layout = window.top.document.getElementById("scLayout");
                if (layout) {
                    layout.onchange = function () { updateOptimizationTab(context); };
                }

                updateOptimizationTab(context);
                renderTestSummary(context);
            }
        });
    });