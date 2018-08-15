import ItemBase from './ItemBase';
import IPlan from '../IPlan';
export default class SequenceItem extends ItemBase {
    constructor(itemData: any, root: IPlan, parent?: ItemBase);
    readonly hasVisual: boolean;
    readonly hasDecisionPoint: boolean;
    computeChildrenOffsets(): void;
    getConnectors(resultArray: any): void;
    getInserts(resultArray: any): void;
}
