sap.ui.define(["sap/ui/model/json/JSONModel"], function (JSONModel) {
  //"this" should be typed ObjectPage/ExtensionAPI, but the latter doesn't contain editFlow
  // export const onChartSelectionChanged = function(this: ExtensionAPI, oEvent: Event) {
  const onChartSelectionChanged = function (oEvent) {
    if (oEvent.getParameter("selected")) {
      this.editFlow.getView().setModel(new JSONModel(oEvent.getParameter("data")[0].data), "popup"); // get Popover from xml fragment dependents

      const _oPopover = oEvent.getSource().getParent().getDependents()[0];

      if (_oPopover) {
        // open popover at selected chart segment
        _oPopover.openBy(oEvent.getParameter("data")[0].target);
      }
    }
  };

  var __exports = {
    __esModule: true
  };
  __exports.onChartSelectionChanged = onChartSelectionChanged;
  return __exports;
});
//# sourceMappingURL=CustomSection.js.map