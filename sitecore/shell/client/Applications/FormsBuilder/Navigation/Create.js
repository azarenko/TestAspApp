(function(speak) {
    speak.pageCode(["itemJS", "css!/-/speak/v1/formsbuilder/navigation/create.css"],
        function(itemJS) {
            var blankFormId = "{AC27A304-1EED-487B-965E-C993C561C6A7}";
            var formDesignerUrl = "/sitecore/client/Applications/FormsBuilder/Pages/FormDesigner";

            return {
                initialized: function() {
                    this.defineProperty("BlankFormItem", null);
                    this.on({
                            "change:BlankFormItem": this.appendBlankForm,
                            "formItemClick": this.formItemClick
                        },
                        this);

                    this.CreateFormDataSource.on("change:Items", this.dataSourceItemsChanged, this);
                    this.CreateFormDataSource.on("change:IsBusy", this.updateListEndlessScroll, this);
                    this.CreateFormDataSource.off("change:PageIndex");

                    this.CreatePopover.$targetEl.on('show.bs.popover',
                        function() {
                            setTimeout(function() {
                                    this.CreateFormListControl.trigger("change:MaxRows");
                                    this.requestDataForEndlessScroll();
                                }.bind(this),
                                0);
                        }.bind(this));

                    this.loadBlankForm();
                },

                formItemClick: function(data) {
                    var item = data.sender.ClickedItem;
                    if (!item)
                        return;

                    window.location.href = item.$url;
                },

                updateListEndlessScroll: function(canEnable) {
                    this.CreateFormListControl.IsEndlessScrollEnabled = canEnable &&
                        !this.CreateFormDataSource.IsBusy &&
                        this.CreateFormDataSource.HasMoreData;
                },

                updateItemProperties: function(item) {
                    if (blankFormId === item.$itemId) {
                        item.$language = this.CreateFormDataSource.LanguageName || speak.Context.current().language;
                        item.$url = speak.Helpers.url.addQueryParameters(formDesignerUrl,
                            { sc_formmode: "new", lang: item.$language });
                    } else {
                        item.$url = speak.Helpers.url.addQueryParameters(formDesignerUrl,
                            { sc_formmode: "copy", formId: item.$itemId, lang: item.$language });
                    }

                    item.$uniqueItemId = item.$itemId + item.$version + item.$language;
                },

                dataSourceItemsChanged: function() {
                    var items = this.CreateFormDataSource.Items;
                    if (speak.utils.is.an.object(this.BlankFormItem)) {
                        items = [this.BlankFormItem].concat(items);
                    }

                    items.forEach(this.updateItemProperties.bind(this));

                    this.CreateFormDataSource.PageIndex += 1;
                    this.CreateFormDataSource.HasMoreData =
                        this.CreateFormDataSource.PageIndex * this.CreateFormDataSource.PageSize <
                        this.CreateFormDataSource.TotalItemsCount;

                    this.updateListEndlessScroll(true);

                    this.CreateFormListControl.DynamicData = items;

                    this.requestDataForEndlessScroll();
                },

                requestDataForEndlessScroll: function() {
                    if (this.CreateFormListControl.el.clientHeight &&
                        this.CreateFormListControl.IsEndlessScrollEnabled) {
                        setTimeout(function() {
                                if (!this.CreateFormListControl.HasScroll) {
                                    this.CreateFormDataSource.next();
                                }
                            }.bind(this),
                            0);
                    }
                },

                appendBlankForm: function() {
                    if (speak.utils.is.an.object(this.BlankFormItem)) {
                        this.updateItemProperties(this.BlankFormItem);

                        var items = [this.BlankFormItem];
                        if (this.CreateFormListControl.Items.length) {
                            items = items.concat(this.CreateFormListControl.Items.splice(
                                this.BlankFormItem.$itemId === this.CreateFormListControl.Items[0].$itemId ? 1 : 0));
                        }

                        this.CreateFormListControl.DynamicData = items;
                    }
                },

                loadBlankForm: function() {
                    var options = {
                        language: speak.Context.current().language
                    };
                    itemJS.fetch(blankFormId,
                        options,
                        function(item, result) {
                            if (result.statusCode === 401) {
                                speak.module("bclSession").unauthorized();
                                return;
                            }

                            if (item != null) {
                                item["__Thumbnail"] = item.$mediaurl;
                                this.BlankFormItem = item;
                            }
                        }.bind(this));
                }
            };
        },
        "CreateSubAppRenderer");
})(Sitecore.Speak);