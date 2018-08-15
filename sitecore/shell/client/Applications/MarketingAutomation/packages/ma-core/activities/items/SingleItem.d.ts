import ItemBase from './ItemBase';
import { TranslateService } from '@ngx-translate/core';
import IPlan from '../IPlan';
export default class SingleItem extends ItemBase {
    protected translate: TranslateService;
    constructor(itemData: any, root: IPlan, parent: ItemBase);
    setVisual(domElement: HTMLElement): void;
}
