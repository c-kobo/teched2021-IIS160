import Chart from "sap/chart/Chart";
//import ExtensionAPI from "sap/fe/templates/ObjectPage/ExtensionAPI";
import Event from "sap/ui/base/Event";
import Control from "sap/ui/core/Control";
//import View from "sap/ui/core/mvc/View";
import JSONModel from "sap/ui/model/json/JSONModel";

//"this" should be typed ObjectPage/ExtensionAPI, but the latter doesn't contain editFlow
// export const onChartSelectionChanged = function(this: ExtensionAPI, oEvent: Event) {
export const onChartSelectionChanged = function(this: any, oEvent: Event) {
    if (oEvent.getParameter("selected")) {
        this.editFlow.getView().setModel(
            new JSONModel(oEvent.getParameter("data")[0].data),"popup");
          // get Popover from xml fragment dependents
          const _oPopover = ((oEvent.getSource() as Chart).getParent() as Control).getDependents()[0];
          if (_oPopover) {
          // open popover at selected chart segment
            (_oPopover as any).openBy(
              oEvent.getParameter("data")[0].target
            );
          }        
    }
}


  