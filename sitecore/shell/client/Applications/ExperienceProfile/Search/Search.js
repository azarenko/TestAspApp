define(["sitecore", "../Common/DataProviderHelper.js", "/-/speak/v1/experienceprofile/CintelUtl.js"], function (sc, providerHelper, cintelUtil) {
    var textProperty = "text";
    var isVisibleProperty = "isVisible";

    var contactsPath = "/contacts";
    var baseUrl = "/sitecore/api/ao/v1" + contactsPath + "/";
    var searchFilters = {
        channelFilters: null,
        outcomeFilters: null,
        goalFilters: null
    };

    var app = sc.Definitions.App.extend({
        _pageSize: 0,
        initialized: function () {
            var self = this;
            self._pageSize = self.SearchDataProvider.get('pageSize');
            var searchTable = "search";

            providerHelper.setupHeaders([
                { urlKey: contactsPath + "/" + searchTable + "?", headerValue: "default" }
            ]);

            providerHelper.initProvider(self.SearchDataProvider, "ContactSearchResults", baseUrl + searchTable, self.SearchMessageBar);
            providerHelper.subscribeAccordionHeader(self.SearchDataProvider, self.ResultsAccordion);
            providerHelper.subscribeSorting(self.SearchDataProvider, self.SearchResults);
            providerHelper.setDefaultSorting(self.SearchDataProvider, "visitCount", true);

            var searchText = decodeURIComponent(cintelUtil.getQueryParam(textProperty));
            self.SearchTextBox.set(textProperty, searchText);
            self.setDefaultDate();
            self.toggleFiltersVisibility();
            self.findContacts();
            self.expandTreeview();
            cintelUtil.removeBreadCrumbLastLink(self.Breadcrumb);
            self.SearchResults.on("change:items", cintelUtil.removeMailLink, self.SearchResults);
            self.on('loadMoreData', self.loadMoreData, self);
        },
        expandNode: function (node, elem) {
            var itemUri = node.data.itemUri;

            this.pendingRequests++;
            elem.set("isBusy", true);

            var self = this;

            var database = new _sc.Definitions.Data.Database(itemUri.getDatabaseUri());
            database.getChildren(itemUri.getItemId(), function (items, totalCount, result) {

                if (result.statusCode === 401) {
                    _sc.Helpers.session.unauthorized();
                    return;
                }

                var res = [], filteredItems;

                filteredItems = items;
                if (!elem.get("showHiddenItems")) {
                    filteredItems = _.filter(items, function (item) {
                        return item.__Hidden !== "1";
                    });
                }

                if (elem.get("templates")) {
                    var templateList = self.model.get("templates");
                    filteredItems = _.filter(filteredItems, function (item) {
                        return templateList.indexOf(item.$templateId, 0) != -1;
                    });
                }

                self.appendLoadedChildren(node, filteredItems, res, elem);
                if (node.childList)
                    for (var counter = 0; counter < node.childList.length; counter++) {
                        self.expandNode(node.childList[counter], elem);
                    }

                self.pendingRequests--;
                if (self.pendingRequests <= 0) {
                    self.pendingRequests = 0;
                    elem.set("isBusy", false);
                }

                if (elem.get("pathToLoad") && elem.get("pathToLoad").length > 0) {
                    self.loadKeyPath(elem);
                }
            },
                {
                    fields: ["__Hidden"],
                    language: elem.get("contentLanguage")
                }
            );
        },
        appendLoadedChildren: function (parentNode, childrenNodes, destArray, elem) {
            var self = this;
            _.each(childrenNodes, function (item) {
                var newNode = {};
                newNode.rawItem = item;
                newNode.title = item.$displayName;
                newNode.key = item.itemId;
                if (elem.get("showSitecoreIcons")) {
                    self.appendLanguageParameter(item);
                    newNode.icon = item.$icon;
                }
                newNode.itemUri = item.itemUri;
                newNode.path = item.$path;
                newNode.select = elem.get("selectMode") === 3 ? parentNode.isSelected() : false;
                newNode.isFolder = item.$hasChildren;
                newNode.isLazy = item.$hasChildren;
                destArray.push(newNode);
            }, this);
            parentNode.setLazyNodeStatus(DTNodeStatus_Ok);
            parentNode.addChild(destArray);
        },
        appendLanguageParameter: function (item) {
            if (item.$icon.indexOf(".ashx") > 0) {
                item.$icon += "&la=" + this.model.get("contentLanguage");
                item.$mediaurl += "&la=" + this.model.get("contentLanguage");
            }
        },
        loadKeyPath: function (elem) {
            var separator = "/",
                pathParts,
                currentNodeId,
                path = elem.get("pathToLoad"),
                tree = this.widget.apply(this.$el, ["getTree"]),
                node;

            pathParts = path.split(separator);
            if (pathParts.length === 0) {
                return false;
            }

            currentNodeId = pathParts.shift();
            if (!currentNodeId) {
                return false;
            }

            node = tree.getNodeByKey(currentNodeId);
            if (!node) {
                elem.set("pathToLoad", "");
                return false;
            }

            this.model.set("pathToLoad", pathParts.join(separator));

            if (pathParts.length === 0) {
                elem.set("selectedItemId", currentNodeId);
                node.activate(true);
                node.select(true);
            }
        },
        setDefaultDate: function () {
            var defaultDate = new Date();
            var fromDate = new Date(defaultDate.getFullYear(), defaultDate.getMonth(), defaultDate.getDate());

            fromDate.setDate(fromDate.getDate() - 30);
            fromDate = fromDate.getFullYear().toString() +
                this.getMonth(fromDate.getMonth()) +
                this.getDate(fromDate.getDate());

            defaultDate = new Date();
            var toDate = new Date(defaultDate.getFullYear(), defaultDate.getMonth(), defaultDate.getDate());
            toDate = toDate.getFullYear().toString() +
                this.getMonth(toDate.getMonth()) +
                this.getDate(toDate.getDate());

            this.FromDatePick.set("date", fromDate);
            this.ToDatePick.set("date", toDate);
        },
        getMonth: function (month) {
            var result;
            if ((month + 1).toString().length === 2)
                result = month + 1;
            else
                result = "0" + (month + 1);
            return result;
        },
        getDate: function (date) {
            var result;
            if (date.toString().length === 2)
                result = date;
            else
                result = "0" + (date);
            return result;
        },
        findContacts: function () {
            var match = this.SearchTextBox.get(textProperty) || "*";

            if (!this.ResultsBorder.get(isVisibleProperty)) {
                this.ResultsBorder.viewModel.show();
            }

            history.pushState(null, null, "search?text=" + encodeURIComponent(match));

            providerHelper.addQueryParameter(this.SearchDataProvider, "Match", encodeURIComponent(match));
            providerHelper.addQueryParameter(this.SearchDataProvider, "FromDate", encodeURIComponent(this.FromDatePick.get("formattedDate")));
            providerHelper.addQueryParameter(this.SearchDataProvider, "ToDate", encodeURIComponent(this.ToDatePick.get("formattedDate")));
            this.setChannelFilters();
            this.setOutcomeFilters();
            this.setGoalFilters();
            providerHelper.loadListDataWithFilters(this.SearchDataProvider, 0, JSON.stringify(searchFilters));
        },
        setChannelFilters: function () {
            var channelFilterIDs = this.ChannelsTreeview.get("checkedItemIds");
            var searchChannelFilters;
            if (channelFilterIDs != null && channelFilterIDs != "") {
                channelFilterIDs = channelFilterIDs.toString();
                channelFilterIDs = channelFilterIDs.split('|').join(',').replace(/{/g, "{\"ItemId\": \"").replace(/}/g, "\"}");
                searchChannelFilters = this.applyFilterFormatter("CHANNEL_FILTERS", channelFilterIDs);
            }
            else { searchChannelFilters = null; }
            searchFilters.channelFilters = searchChannelFilters;
        },
        setOutcomeFilters: function () {
            var outcomeFilterIDs = this.OutcomeTreeview.get("checkedItemIds");
            var searchOutcomeFilters;
            if (outcomeFilterIDs != null && outcomeFilterIDs != "") {
                outcomeFilterIDs = outcomeFilterIDs.toString();
                outcomeFilterIDs = outcomeFilterIDs.split('|').join(',').replace(/{/g, "{\"ItemId\": \"").replace(/}/g, "\"}");
                searchOutcomeFilters = this.applyFilterFormatter("OUTCOME_FILTERS", outcomeFilterIDs);
            }
            else { searchOutcomeFilters = null; }
            searchFilters.outcomeFilters = searchOutcomeFilters;
        },
        setGoalFilters: function () {
            var goalFilterIDs = this.GoalsTreeview.get("checkedItemIds");
            var searchGoalFilters;
            if (goalFilterIDs != null && goalFilterIDs != "") {
                goalFilterIDs = goalFilterIDs.toString();
                goalFilterIDs = goalFilterIDs.split('|').join(',').replace(/{/g, "{\"ItemId\": \"").replace(/}/g, "\"}");
                searchGoalFilters = this.applyFilterFormatter("GOAL_FILTERS", goalFilterIDs);
            }
            else { searchGoalFilters = null; }
            searchFilters.goalFilters = searchGoalFilters;
        },
        loadMoreData: function () {
            this.setChannelFilters();
            this.setOutcomeFilters();
            this.setGoalFilters();
            providerHelper.loadListDataWithFilters(this.SearchDataProvider, 1, JSON.stringify(searchFilters));
        },
        toggleFiltersVisibility: function () {
            this.LeftContentBorder.toggle();
            if (this.LeftContentBorder.attributes.isVisible) {
                $("div[data-sc-id='LeftContentBorder']").addClass("col-md-3");

                $("div[data-sc-id='RightContentBorder']").removeClass("col-md-12");
                $("div[data-sc-id='RightContentBorder']").addClass("col-md-9");
            }
            else {
                $("div[data-sc-id='LeftContentBorder']").removeClass("col-md-3");

                $("div[data-sc-id='RightContentBorder']").removeClass("col-md-9");
                $("div[data-sc-id='RightContentBorder']").addClass("col-md-12");
            }
        },
        applyFilterFormatter: function (filterName, filterIds) {
            var jsonFormatterString = '{"name": "<FILTER_NAME>", "SearchItems": [<FILTER_IDs>]}';
            var filterJson = jsonFormatterString.replace("<FILTER_NAME>", filterName);
            filterJson = filterJson.replace("<FILTER_IDs>", filterIds);
            return JSON.parse(filterJson);
        },
        expandTreeview: function () {
            var self = this;
            var channelsRootItem = self.getRootItemBySelector(self.ChannelsTreeview);
            var outcomesRootitem = self.getRootItemBySelector(self.OutcomeTreeview);
            var goalsRootItem = self.getRootItemBySelector(self.GoalsTreeview);
            $.when(
                    $.ajax(self.visitTreeview(channelsRootItem, self.ChannelsTreeview))
                )
                .then(function () {
                    self.collapseTree(channelsRootItem);
                    $.when(
                            $.ajax(self.visitTreeview(outcomesRootitem, self.OutcomeTreeview))
                        )
                        .then(function () {
                            self.collapseTree(outcomesRootitem);
                            $.when(
                                    $.ajax(self.visitTreeview(goalsRootItem, self.GoalsTreeview))
                                )
                                .then(function () {
                                    self.collapseTree(goalsRootItem);
                                });
                        });
                });
        },
        getRootItemBySelector: function (object) {
            var selector = object.attributes.type;
            var elem = $('.' + selector);
            var rootItem = elem.dynatree("getRoot");
            return rootItem;
        },
        visitTreeview: function (rootNode, elem) {
            var self = this;
            rootNode.visit(function (node) {
                self.expandNode(node, elem);
            });
        },
        collapseTree: function (rootItem) {
            setTimeout(function () {
                rootItem.childList[0].visit(function (node) {
                    if (node.data.isFolder)
                        node.expand(false);
                });
                rootItem.childList[0].expand(false);
            }, 1000);
        },
    });
    return app;
});