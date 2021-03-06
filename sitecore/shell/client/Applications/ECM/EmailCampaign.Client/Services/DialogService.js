﻿define(['sitecore', 'jquery'], function (sitecore, $) {
  var DialogRenderingTypes = {
      alert: '{6F26F209-5DF3-4BA2-BBEE-D4A76B1010B7}',
      defaultSettings: '{33E6267B-0112-468D-9717-5E8EBFD0ACB9}',
      confirm: '{620AC309-7AAD-4D7E-8AE2-F7163AB0A45F}',
      prompt: '{42245841-8BC6-4879-9E61-06C6DFB5FF43}',
      addAttachment: '{26D93861-13E8-4416-8319-0D03094A19CB}',
      attachments: '{A15BAF11-07C0-494A-B6E5-FFA92085A995}',
      previewRecipients: '{C17EAA2B-CEBC-4A9B-8DF4-400F5B2774D0}',
      personalizationToken: '{E20CE5D9-3766-4711-BD25-B0F907E60F7C}',
      createRegularMessage: '{C70377E9-BC2A-4685-8766-C845A941B7F9}',
      createAutomatedMessage: '{42B80D20-5148-4291-BA75-ACA39A99592D}',
      addEmptyList: '{BDC2AB0C-9FC6-41F4-B821-214A8F156A91}',
      addFromExistingList: '{BCBFAB6D-15A7-4509-9D55-E570B301355E}',
      pageEditor: '{8B5A7135-0135-4944-A69F-23D9CD388FE6}',
      messageActivateConfirmation: '{AF46BCDC-AAB7-49C0-91D8-FE48D7CDC94A}',
      messageDispatchConfirmation: '{0EAF272C-EF39-4155-A4E1-B8CF8FFF2F46}',
      messageManualWinnerSelectConfirmation: '{125864A1-E4AF-4A6A-87D5-A3534894FE02}',
      emailPreview: '{BA1B94A2-2651-4495-BEC3-075A781713F8}',
      // List Manager
      selectList: '{43D7456E-C098-4F42-8805-7D905BA283D9}',
      importWizard: '{664BD429-0733-4E60-A41C-1D1F434DC96B}'
    },

    insertRendering = _.bind(
      sitecore.Definitions.App.prototype.insertRendering,
      { insertMarkups: sitecore.Definitions.App.prototype.insertMarkups }
    ),

    dialogs = {},

    getCreateDialog = function (type, id) {
      id = id || type;
      var defer = $.Deferred();
      dialogs[type] = dialogs[type] || {};
      if (dialogs[type][id]) {
        if ($.isFunction(dialogs[type][id].promise) && $.isFunction(dialogs[type][id].resolve)) {
          defer = dialogs[type][id];
        } else {
          defer.resolve(dialogs[type][id]);
        }
      } else {
        dialogs[type][id] = defer;
        if (DialogRenderingTypes[type]) {
          insertRendering(DialogRenderingTypes[type], { $el: $("body") }, function(dialog) {
            if (dialog) {
              dialogs[type][id] = dialog;
              defer.resolve(dialog);
            } else {
              defer.reject();
            }
          });
        } else {
          defer.reject();
        }
      }
      return defer.promise();
    };

  var DialogService = {
    get: getCreateDialog,
    show: function(type, id, params) {
      if (typeof id === "object" && !params) {
        params = id;
        id = null;
      }
      params = params || {};
      getCreateDialog(type, id)
        .done(function (dialog) {
          dialog.showDialog(params);
        });
    },
    remove: function(type, id) {
        id = id || type;
        if (dialogs[type] && dialogs[type][id]) {
            var dialog = dialogs[type][id];
            dialog.ScopedEl.remove();
            dialogs[type][id] = null;
            if ($.type(dialog.destroy) === 'function') {
                dialog.destroy();
            }
        }
    },

    /*
     * Select list dialog belongs to ListManager, since there is no access to source code of it
     *   it need to removed differently from other dialogs (need to detach listCreated event handler)
     */
    removeSelectListDialog: function (id) {
        var type = 'selectList';
        id = id || type;
        if (dialogs[type] && dialogs[type][id]) {
            var dialog = dialogs[type][id];
            sitecore.off("listManager:listCreated", dialog.DialogListsDataSource.refreshAfterListCreated);
            DialogService.remove('selectList');
        }
    }
  }
  
  /* test-code */
  DialogService._dialogs = dialogs;
  /* end-test-code */

  return DialogService;
});