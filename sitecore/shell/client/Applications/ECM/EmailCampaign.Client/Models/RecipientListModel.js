﻿define([
        defaults: {
            selectedLists: new backbone.Collection([])
        },
            this.attachEventHandlers();

        onChangeListType: function () {
            this.set('selectedLists', RecipientsService.lists[this.get('listType')]);
        }
    });
});