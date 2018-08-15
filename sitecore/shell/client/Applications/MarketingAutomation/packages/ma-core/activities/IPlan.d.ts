import { Injector } from '@angular/core';
interface IPlan {
    injector: Injector;
    extractParams(activityData: any): any;
    extractChildren(activityData: any): Array<any>;
    getClass(activityData: any): any;
}
export default IPlan;
