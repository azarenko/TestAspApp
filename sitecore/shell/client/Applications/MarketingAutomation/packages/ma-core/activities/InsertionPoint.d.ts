import ItemBase from './items/ItemBase';
export default class InsertionPoint {
    item: ItemBase;
    index: number;
    x: number;
    y: number;
    forDecisionPointOnly: boolean;
    constructor(item: ItemBase, index: number, x: number, y: number, forDecisionPointOnly?: boolean);
    readonly id: string;
}
