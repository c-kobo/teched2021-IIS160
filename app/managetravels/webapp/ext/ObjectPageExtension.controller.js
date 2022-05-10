sap.ui.define(["sap/ui/core/mvc/ControllerExtension"], function (ControllerExtension) {
  var __exports = ControllerExtension.extend("sap.fe.cap.managetravels.ext.ObjectPageExtension", {
    override: {
      editFlow: {
        onBeforeSave: function () {
          //Check on green flights
          console.log("test");

          if (!this.getView().getBindingContext().getProperty('GoGreen')) {
            return new Promise(async (resolve, reject) => {
              var mSettings = {
                id: "myFragment",
                name: "sap.fe.cap.managetravels.ext.fragment.Trees4Tickets",
                controller: Object,
                contextPath: "",
                initialBindingContext: this.getView().getBindingContext()
              }; //"this as any" -> this doesn't have access to the fe core ExtensionAPI

              var oApproveDialog = await this.base.getExtensionAPI().loadFragment(mSettings);
              let buttons = oApproveDialog.getButtons();
              let saveButton = buttons.find(obj => obj.getId() === "myFragment--Save");
              saveButton.attachPress(function () {
                oApproveDialog.close();
                oApproveDialog.destroy();
                return resolve(null);
              });
              let cancelButton = buttons.find(obj => obj.getId() === "myFragment--Cancel");
              cancelButton.attachPress(function () {
                oApproveDialog.close();
                oApproveDialog.destroy();
                return reject();
              }.bind(this));
              oApproveDialog.open();
            });
          }
        }
      }
    }
  });

  return __exports;
});
//# sourceMappingURL=ObjectPageExtension.controller.js.map