﻿define([
    "sitecore",
    "/-/speak/v1/ecm/ReportingBlockBase.js",
    "/-/speak/v1/ecm/ChartHelper.js"
], function (sitecore, ReportingBlockBase, ChartHelper) {
    var view = ReportingBlockBase.view.extend({
        initialize: function () {
            this._super();
            this.initTabs();
        },

        initTabs: function () {
            if (this.children.Tabs) {
                this.tabContents = this.getTabContents();
                this.bindTabs();
                this.showTab(this.children.Tabs.get('selectedTabIndex'));
            }
        },

        getTabContents: function () {
            var tabContents = {};
            _.each(this.children, _.bind(function (child, key) {
                if (key.indexOf('TabContent') >= 0) {
                    tabContents[key] = child;
                }
            }, this));
            return tabContents;
        },

        hideTabContents: function () {
            _.each(this.tabContents, function (tabContent) {
                tabContent.set('isVisible', false);
            });
        },

        bindTabs: function () {
            this.children.Tabs.on('change:selectedTabIndex', function () {
                this.showTab(this.children.Tabs.get('selectedTabIndex'));
            }, this);
        },

        showTab: function (index) {
            this.hideTabContents();
            var tabContent = this.tabContents['TabContent' + index];
            if (tabContent) {
                tabContent.set('isVisible', true);
                ChartHelper.updateCharts(this.children);
            }
        }
    });

    return { model: ReportingBlockBase.model, view: view };
});