import ItemBase from './ItemBase';
export default class FinalItem extends ItemBase {
    setVisual(domElement: HTMLElement): void;
    readonly isFinal: boolean;
}
