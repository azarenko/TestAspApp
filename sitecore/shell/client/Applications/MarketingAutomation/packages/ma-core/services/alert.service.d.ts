import { InjectionToken } from '@angular/core';
import { AlertType } from './alert.model';
export interface IAlertService {
    error(message: any): void;
    warning(message: any): void;
    info(message: any): void;
    success(message: any): void;
    clearAlerts(): void;
    alert(type: AlertType, message: string, dismissible: boolean): any;
}
export declare const ALERT_SERVICE: InjectionToken<IAlertService>;
