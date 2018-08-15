import ItemBase from './ItemBase';
export default class PlanItem extends ItemBase {
    initParams(itemData: any): void;
    initChildren(itemData: any): void;
    readonly hasVisual: boolean;
    computeChildrenOffsets(): void;
}
