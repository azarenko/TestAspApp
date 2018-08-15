import { NgModuleFactory, Type } from '@angular/core';
import { EditorBase } from '../editors/editor-base';
import ItemBase from '../activities/items/ItemBase';
export interface ActivityDefinition {
    id: string;
    activity: Type<ItemBase>;
    editorComponenet: Type<EditorBase>;
    editorModuleFactory: NgModuleFactory<any>;
}
export interface PluginConfig {
    activityDefinitions: Array<ActivityDefinition>;
}
