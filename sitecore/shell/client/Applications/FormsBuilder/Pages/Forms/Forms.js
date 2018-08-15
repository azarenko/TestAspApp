(function(speak) {
    speak.pageCode(["bclImageHelper", "/-/speak/v1/formsbuilder/assets/formservices.js"],
        function(imageHelper, formServices) {
            var performanceTabGuid = "{9A4A7E57-5266-426A-93CE-85BDC0C95374}";
            var formDesignerUrl = "/sitecore/client/Applications/FormsBuilder/Pages/FormDesigner";
            var dateFormatter = speak.globalize.dateFormatter({ date: "medium" });

            var currentState = {
                ContextToggleIsOpen: ""
            };

            var tabIsSelectable = function(item) {
                return item && item["IsHidden"] !== "1" && item["IsDisabled"] !== "1";
            };

            var debouncedSetSelectedItems = _.debounce(function() {
                    this.setSelectedItems.apply(this, arguments);
                },
                100);

            var isArraysEqual = function(arr1, arr2) {
                if (arr1.length !== arr2.length)
                    return false;

                for (var i = 0; i < arr1.length; i++) {
                    if (arr1[i] !== arr2[i])
                        return false;
                }

                return true;
            };

            return {
                initialized: function() {
                    this.defineProperty("SelectedItems", []);

                    this.on({
                            "forms:Edit": this.editForm,
                            "forms:Rename": this.renameForm,
                            "forms:Delete": this.deleteForm,
                            "forms:ExportData": this.exportFormData,
                            "DeleteConfirmationDialog:ButtonClick": this.confirmDeleteFormClicked,
                            "forms:ToggleSelection": this.toggleFormsSelection,
                            "change:SelectedItems": this.selectedItemsChanged
                        },
                        this);

                    this.SortDropList.on("change:SelectedValues", this.setSortOption, this);

                    this.DeleteFormsSubAppRenderer.on("deleteforms:ProceedDelete", this.proceedDeleteForms, this);

                    this.DataSource.on("change:Items", this.dataSourceItemsChanged, this);
                    this.DataSource.on("change:IsBusy", this.updateListEndlessScroll, this);
                    this.DataSource.off("change:PageIndex");

                    this.ListControl.on("change:SelectedItem change:CheckedItems", debouncedSetSelectedItems, this);
                    this.ListControl.on("change:Items", this.updateActionsState, this);

                    this.LanguageListControl.on("change:SelectedItem", this.selectedLanguageChanged, this);
                    this.LanguageDropDownButton.on("change:IsOpen", this.languageDropDownIsOpenChanged, this);

                    this.InfoTabControl.isSelectable = tabIsSelectable;
                    this.InfoTabControl.on({
                            "loaded:Overview": this.fillOverviewTab,
                            "loaded:Performance": this.fillPerformanceTab,
                            "change:SelectedValue": this.tabsSwitched
                        },
                        this);
                    this.tabsSwitched();
                    this.ContextToggle.on("change:IsOpen", this.updatePerformanceAppIsActive, this);

                    this.SaveFormSubAppRenderer.on("saveform:NameChanged", this.renameFormNameChanged, this);

                    var dropdownEl = this.ActionControl.el.querySelector('.dropdown-menu');
                    dropdownEl.classList.toggle("sc-placement-top", true);

                    this.SortDropList.el.removeAttribute("multiple");
                    this.setSortOption();

                    var languages = [];
                    formServices.getLanguages()
                        .then(function(data) {
                            if (data && data.length) {
                                languages = data;
                            }
                        })
                        .done(function() {
                            languages.unshift({
                                text: this.LanguageText.Text,
                                displayName: this.LanguageText.Text,
                                name: "-"
                            });

                            var selectedValue = this.LanguageListControl.UserProfileState.SelectedValue;
                            if (!selectedValue) {
                                this.LanguageListControl.SelectedValue = this.UserContentLanguage.Text;
                            }

                            this.LanguageListControl.DynamicData = languages;
                            this.languagesLoaded = true;
                        }.bind(this));
                },

                selectedLanguageChanged: function() {
                    if (this.LanguageListControl.SelectedItem) {
                        this.LanguageDropDownButton.Text = this.LanguageListControl.SelectedItem.displayName;
                        this.LanguageDropDownButton.Tooltip = this.LanguageListControl.SelectedItem.text;

                        var selectedValue = this.LanguageListControl.SelectedValue !== "-"
                            ? this.LanguageListControl.SelectedValue
                            : "";
                        this.DataSource.LanguageName = selectedValue;
                        this.CreateSubAppRenderer.CreateFormDataSource.LanguageName = selectedValue;
                        this.DataSource.loadData();
                        this.CreateSubAppRenderer.CreateFormDataSource.loadData();
                    }

                    this.LanguageDropDownButton.IsOpen = false;
                },

                languageDropDownIsOpenChanged: function() {
                    if (this.LanguageDropDownButton.IsOpen) {
                        this.LanguageListControl.trigger("change:MaxRows");
                    }
                },

                setSortOption: function() {
                    this.DataSource.set("Sorting", this.SortDropList.SelectedValues[0], !this.languagesLoaded);
                    this.SortDropButton.Text = this.SortDropList.SelectedItems[0].Text;
                    $(this.SortDropButton.el).attr("title", this.SortDropButton.Text);
                    this.SortDropButton.IsOpen = false;
                },

                setSelectedItems: function() {
                    var selectedItems = this.ListControl.SelectedItem
                        ? [this.ListControl.SelectedItem]
                        : this.ListControl.CheckedItems;

                    if (!isArraysEqual(this.SelectedItems, selectedItems)) {
                        this.SelectedItems = selectedItems;
                    }
                },

                selectedItemsChanged: function() {
                    this.updateActionsState();
                    this.updateContextPane();
                },

                updateActionsState: function() {
                    var hasItems = this.ListControl.Items && this.ListControl.Items.length,
                        isSingleActionDisabled = !(hasItems && this.SelectedItems.length === 1);

                    this.ActionControl.getAction("Edit").IsDisabled = isSingleActionDisabled;
                    this.ActionControl.getAction("Rename").IsDisabled = isSingleActionDisabled;
                    this.ActionControl.getAction("ExportData").IsDisabled = isSingleActionDisabled;
                    this.ActionControl.getAction("Delete").IsDisabled = !(hasItems && this.SelectedItems.length);

                    var toggleSelection = this.ActionControl.getAction("ToggleSelection");
                    var isAllChecked = hasItems && this.ListControl.isAllChecked();
                    toggleSelection.Text = isAllChecked ? this.DeselectAll.Text : this.SelectAll.Text;
                    toggleSelection.Tooltip = isAllChecked ? this.DeselectAll.Tooltip : this.SelectAll.Tooltip;
                    toggleSelection.IsDisabled = !hasItems;
                },

                updateContextPane: function() {
                    var numberOfSelectedItems = this.SelectedItems.length;
                    if (!numberOfSelectedItems) {
                        return;
                    }

                    this.ContextDetails.HeaderTitle = numberOfSelectedItems > 1
                        ? speak.Helpers.string.format(this.NumberOfFormsSelectedText.Text, numberOfSelectedItems)
                        : this.SelectedItems[0].$displayName;

                    this.fillOverviewTab();
                    this.fillPerformanceTab();
                },

                updateListEndlessScroll: function(canEnable) {
                    this.ListControl.IsEndlessScrollEnabled =
                        canEnable && !this.DataSource.IsBusy && this.DataSource.HasMoreData;
                },

                dataSourceItemsChanged: function() {
                    if (this.DataSource.HasData) {
                        var options = {
                            sc_formmode: "edit"
                        };

                        var baseUrl = speak.Helpers.url.addQueryParameters(formDesignerUrl, options);
                        this.DataSource.Items.forEach(function(item) {
                            item.$url = speak.Helpers.url
                                .addQueryParameters(baseUrl, { formId: item.$itemId, lang: item.$language });
                            item.$uniqueItemId = item.$itemId + item.$version + item.$language;
                        });
                    }

                    this.DataSource.PageIndex += 1;
                    this.DataSource.HasMoreData = this.DataSource.PageIndex * this.DataSource.PageSize <
                        this.DataSource.TotalItemsCount;

                    this.updateListEndlessScroll(true);

                    this.ListControl.DynamicData = this.DataSource.Items;

                    if (this.ListControl.IsEndlessScrollEnabled) {
                        setTimeout(function() {
                                if (!this.ListControl.HasScroll) {
                                    this.DataSource.next();
                                }
                            }.bind(this),
                            0);
                    }

                    if (this.ContextToggle.IsEnabled) {
                        currentState.ContextToggleIsOpen = this.ContextToggle.IsOpen;
                    }

                    this.ContextToggle.IsEnabled = this.DataSource.HasData;
                    this.ContextToggle.IsOpen = !this.DataSource.HasData ? false : currentState.ContextToggleIsOpen;
                },

                fillOverviewTab: function() {
                    var numberOfSelectedItems = this.SelectedItems.length,
                        isSingleSelection = numberOfSelectedItems === 1,
                        imageContainer;

                    if (!this.OverviewApp || !numberOfSelectedItems) {
                        return;
                    }

                    this.OverviewApp.OverviewGridBorder.IsVisible = isSingleSelection;
                    this.OverviewApp.LinksBorder.IsVisible = isSingleSelection;

                    for (var i = 0; i < 3; i++) {
                        imageContainer = this.OverviewApp["OverviewImage" + i];
                        if (numberOfSelectedItems > i) {
                            imageContainer.ImageUrl = this
                                .getImage(this.SelectedItems[i].__Thumbnail,
                                    this.SelectedItems[i]["$database"],
                                    imageContainer.Width,
                                    null);
                            imageContainer.IsVisible = true;
                        } else {
                            imageContainer.IsVisible = false;
                        }
                    }

                    if (numberOfSelectedItems > 3) {
                        this.OverviewApp.OverviewImage1.IsVisible = false;
                        this.OverviewApp.OverviewImage2.IsVisible = false;
                        this.OverviewApp.OverviewImage3.IsVisible = true;
                    } else {
                        this.OverviewApp.OverviewImage3.IsVisible = false;
                    }

                    if (isSingleSelection) {
                        this.OverviewApp.CreatedByValue.Text = this.SelectedItems[0].__Createdby;

                        var isoDate = speak.utils.date.parseISO(this.SelectedItems[0].__Created);
                        this.OverviewApp.CreatedDateValue.Text = isoDate ? dateFormatter(isoDate) : "";

                        isoDate = speak.utils.date.parseISO(this.SelectedItems[0].__Updated);
                        this.OverviewApp.UpdatedDateValue.Text = isoDate ? dateFormatter(isoDate) : "";

                        formServices.getFormDetails(this.SelectedItems[0].$itemId)
                            .then(this.populateLinksList.bind(this))
                            .fail(function() {
                                this.populateLinksList([]);
                            }.bind(this));
                    }
                },

                populateLinksList: function(links) {
                    this.OverviewApp.LinksListControl.IsSelectionRequired = false;
                    this.OverviewApp.LinksListControl.reset(links);
                    this.OverviewApp.LinksListControl.SelectedValue = "";
                },

                copyToClipboard: function() {
                    var clickedItem = this.OverviewApp.LinksListControl.ClickedItem;
                    if (!clickedItem) {
                        return;
                    }

                    this.OverviewApp.LinksListControl.IsSelectionRequired = true;

                    var $temp = $("<input>");
                    $("body").append($temp);
                    $temp.val(clickedItem.id).select();
                    document.execCommand("copy");
                    $temp.remove();

                    this.showCopiedMessage(this.OverviewApp.LinksListControl.Items.indexOf(clickedItem));
                },

                showCopiedMessage: function(clickedIndex) {
                    this.OverviewApp.LinksListControl.SelectedValue = "";

                    var $tags = $(this.OverviewApp.LinksListControl.el)
                        .find('.sc-listcontrol-tile .sc-linklist-copiedtag');
                    $tags.css('opacity', '0').text(this.OverviewApp.CopiedTagText.Text);
                    $tags.eq(clickedIndex).stop().fadeTo(100, 1).delay(2000).fadeTo(100, 0);
                },

                fillPerformanceTab: function() {
                    var isSingleSelection = this.SelectedItems.length === 1,
                        performanceTab = this.InfoTabControl.getByValue(performanceTabGuid),
                        isTabEnabled = performanceTab.IsDisabled !== "1";

                    var shouldDisableTab = !isSingleSelection &&
                        (this.PerformanceApp ? this.PerformanceApp.FormPerformance.IsAnalyticsEnabled : true);
                    performanceTab.IsDisabled = shouldDisableTab ? "1" : "";

                    if (this.InfoTabControl.SelectedValue === performanceTabGuid &&
                        isTabEnabled &&
                        shouldDisableTab) {
                        this.InfoTabControl.select(this.InfoTabControl.getDefaultSelection());
                    }

                    if (!this.PerformanceApp)
                        return;

                    this.PerformanceApp.FormPerformance.FormId = isSingleSelection ? this.SelectedItems[0].$itemId : "";
                    this.updatePerformanceAppIsActive();
                },

                getImage: function(imageValue, database, width, height) {
                    if (!imageValue || !database) {
                        return undefined;
                    }

                    var mediaid = imageHelper.getId(imageValue);
                    if (!mediaid) {
                        return undefined;
                    }

                    var url = "/sitecore/shell/~/media/" +
                        speak.Helpers.id.toShortId(mediaid) +
                        ".ashx?h=" +
                        height +
                        "&w=" +
                        width +
                        "&db=" +
                        database;
                    return url;
                },

                editForm: function() {
                    if (this.SelectedItems.length !== 1)
                        return;

                    window.location.href = this.SelectedItems[0].$url;
                },

                renameFormSuccess: function(renameOptions) {
                    this.removeOldMessage("RenameForm");

                    var dialogOptions = {
                        success: true
                    };

                    this.SaveFormSubAppRenderer.actionCompleted(dialogOptions);

                    this.MessageBar.add({
                        MessageId: "RenameForm",
                        Type: "notification",
                        Text: this.RenameFormSuccessMessage.Text,
                        IsClosable: true,
                        IsTemporary: true
                    });

                    this.renameOptions.form.$itemName = renameOptions.newName;
                    this.renameOptions.form.$displayName = renameOptions.newName;

                    this.updateContextPane();
                    this.ListControl.trigger("itemsChanged", this.ListControl.Items);
                },

                renameFormError: function(response) {
                    this.removeOldMessage("RenameForm");

                    var messageText = response && response.responseJSON && response.responseJSON.message
                        ? response.responseJSON.message
                        : response.statusText;

                    var options = {
                        success: false,
                        message: messageText
                    };

                    this.SaveFormSubAppRenderer.actionCompleted(options);
                },

                renameFormNameChanged: function(newName) {
                    this.renameOptions.newName = newName;

                    formServices.renameForm(this.renameOptions.form.$itemId, newName)
                        .then(this.renameFormSuccess.bind(this, this.renameOptions))
                        .fail(this.renameFormError.bind(this));
                },

                renameForm: function() {
                    if (this.SelectedItems.length !== 1) {
                        return;
                    }

                    var formItem = this.SelectedItems[0];
                    this.renameOptions = { form: formItem };

                    this.SaveFormSubAppRenderer.show(formItem.$itemName, this.RenameDialogText.Text);
                },

                deleteForm: function() {
                    var items = this.SelectedItems.slice(0);
                    if (items.length > 1) {
                        var addIdx = 0,
                            lang = speak.Context.current().language;
                        items.slice(0)
                            .forEach(function(item, idx) {
                                if (item.$language === lang) {
                                    items.splice(idx, 1);
                                    items.splice(addIdx, 0, item);
                                    addIdx++;
                                }
                            });
                    }

                    this.itemsForDeletion = _.uniq(items, function(p) { return p.$itemId; });
                    var dialogText;

                    switch (this.itemsForDeletion.length) {
                    case 0:
                        return;
                    case 1:
                        dialogText = this.DeleteSingleConfirmMessage.Text;
                        dialogText = speak.Helpers.string.format(dialogText, this.itemsForDeletion[0].$displayName);
                        break;
                    default:
                        dialogText = this.DeleteMultipleConfirmMessage.Text;
                        dialogText = speak.Helpers.string.format(dialogText, this.itemsForDeletion.length);
                        break;
                    }

                    this.DeleteConfirmationDialog.Message = dialogText;
                    this.DeleteConfirmationDialog.show();
                },

                confirmDeleteFormClicked: function(buttonControlId) {
                    if (buttonControlId[0] !== "ok")
                        return;

                    this.deleteForms(this.itemsForDeletion);
                },

                proceedDeleteForms: function(items) {
                    this.deleteForms(items);
                },

                deleteForms: function(items) {
                    var itemIds = _.pluck(items, "$itemId");

                    if (!itemIds.length)
                        return;

                    formServices.deleteForms(itemIds)
                        .then(this.deleteFormCompleted.bind(this, items))
                        .fail(this.deleteFormError.bind(this));
                },

                deleteFormCompleted: function(items, deleteStatus) {
                    var messageId = "DeleteForm";
                    this.removeOldMessage(messageId);

                    var itemStatusValues = _.values(deleteStatus);
                    var deleteComplete = itemStatusValues.every(function(value) {
                        return value === "success";
                    });
                    var hasDeletedItems = itemStatusValues.length && deleteComplete;

                    if (!deleteComplete) {
                        var options = {
                            items: items,
                            itemsStatus: deleteStatus
                        };
                        this.DeleteFormsSubAppRenderer.show(options);
                        return;
                    }

                    // deletion is complete
                    setTimeout(function() {
                            this.DataSource.loadData();
                            this.CreateSubAppRenderer.CreateFormDataSource.loadData();
                        }.bind(this),
                        500);

                    if (hasDeletedItems) {
                        this.MessageBar.add({
                            MessageId: messageId,
                            Type: "notification",
                            Text: this.DeleteSuccessText.Text,
                            IsClosable: true
                        });
                    } else {
                        this.deleteFormError();
                    }
                },

                deleteFormError: function(xhr) {
                    if (xhr && xhr.status === 401) {
                        speak.module("bclSession").unauthorized();
                        return;
                    }

                    var messageId = "DeleteForm";
                    this.removeOldMessage(messageId);

                    this.MessageBar.add({
                        MessageId: messageId,
                        Type: "error",
                        Text: this.DeleteErrorText.Text,
                        IsClosable: false
                    });
                },

                exportFormData: function(e) {
                    var options;
                    if (e && e.exportOptions) {
                        options = e.exportOptions;
                    } else {
                        if (this.SelectedItems.length !== 1) {
                            return;
                        }

                        options = {
                            formId: this.SelectedItems[0].$itemId
                        };
                    }

                    this.ExportDataSubAppRenderer.show(options);
                },

                toggleFormsSelection: function() {
                    this.ListControl.toggleAll();
                },

                removeOldMessage: function(messageId) {
                    var oldMessages = this.MessageBar.where({ MessageId: messageId });
                    oldMessages.forEach(function(message) {
                            this.MessageBar.remove(message);
                        },
                        this);
                },

                updatePerformanceAppIsActive: function() {
                    if (this.PerformanceApp) {
                        this.PerformanceApp.FormPerformance
                            .IsActive = this.ContextToggle.IsOpen &&
                            this.InfoTabControl.SelectedValue === performanceTabGuid;
                    }
                },

                tabsSwitched: function() {
                    this.updatePerformanceAppIsActive();
                }
            };
        });
})(Sitecore.Speak);