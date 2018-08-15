export declare enum AlertType {
    error = 0,
    warning = 1,
    info = 2,
    confirmation = 3,
}
export declare class AlertModel {
    dismissible: boolean;
    message: string;
    type: string;
    constructor(type: AlertType, dismissible: boolean, message: string);
}
