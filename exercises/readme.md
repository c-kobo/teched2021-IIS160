# Exercises

## Setting Up Dev Environment

go to the SAP [BTP Trial page](https://account.hanatrial.ondemand.com/)

Clone Github Repo
```abap
https://github.com/SAP-samples/teched2022-DT181.git
```
## Exercise 1 Generate app

App Generation: 
- managetravels
- sap.fe.cap
- 1.108.0
- add js code assist libs (adds @sapui5/ts-types)

While generating: [show FPM Explorer]()

Configure Page
- show Main.view.xml and controller
  - **sap.fe.core.PageController**: Base controller class for your custom page used inside an SAP Fiori elements application.
  Provides preconfigured (controller) extensions that will ensure you have the basic functionalities required to use the building blocks.
- show manifest.json 
  - **sap.fe.core.fpm**: fpm component wrapper for custom pages
- show Component.js     
  - **sap.fe.core.AppComponent**: extended in own app to ensure that all the necessary services (routing, edit flow etc.) needed for the building blocks and templates to work properly are started

Preview App
- popup blocker: show guided answers extension by SAP

## Exercise 2: Using Fiori Elements Building Blocks on a Custom Page

The available Fiori elements floorplans
for OData V4 cover most business scenarios that customers encounter with SAP. In fact, SAP uses these SAP Fiori elements floorplans to create roughly 80% of new SAP S/4HANA apps.\
If these floorplans do not meet your needs, the flexible programming model provided by SAP Fiori elements
allows to assemble your custom design by combining the available building blocks with SAPUI5 controls,
and leverage controller extensions in order to fine-tune the behaviour of your app.\
For our scenario, we want to mimic the behaviour of the list report and combine it with some SAPUI5 controls and add some app specific behaviours.

## Exercise 2.1 Guided Development: Adding Filter Bar Building Block

Add Selection fields:
- to_Agency_AgencyID
- to_Customer_CustomerID
- TravelStatus_code

Add to aggregation mvc:View/Page/content

Show annotations.cds

Show macro in Main.view.xml

Preview App

## Exercise 2.2 Adding Table Building Block

Add to annotations.cds

```js
,
    UI.LineItem  : [
        {
            $Type : 'UI.DataField',
            Value : TravelID,
        },
        {
            $Type : 'UI.DataField',
            Value : TravelStatus_code,
            Criticality : TravelStatus.criticality,
        },
        {
            $Type : 'UI.DataField',
            Value : BeginDate,
        },
        {
            $Type : 'UI.DataField',
            Value : EndDate,
        },
        {
            $Type : 'UI.DataField',
            Value : to_Agency_AgencyID,
        },
        {
            $Type : 'UI.DataField',
            Value : to_Customer_CustomerID,
        },
        {
            $Type : 'UI.DataField',
            Value : TotalPrice,
        },
        {
            $Type : 'UI.DataFieldForAction',
            Label : '{i18n>AcceptTravel}',
            Action : 'TravelService.acceptTravel',
        },
        {
            $Type : 'UI.DataFieldForAction',
            Label : '{i18n>RejectTravel}',
            Action : 'TravelService.rejectTravel',
        },
    ]
``` 

Open **Usage with Filter Bar** in the [Flexible Programming Model Explorer](https://ui5.sap.com/test-resources/sap/fe/core/fpmExplorer/index.html#/buildingBlocks/table/tableFilterBar)

Explain FB <-> TB semantic link

Add to main.view.xml
```js
<macros:Table metaPath="@com.sap.vocabularies.UI.v1.LineItem" readOnly="true" id="LineItemTable" filterBar="FilterBar" />
```
## Exercise 2.3 Page Map: Add Object Page and Switch to Flexible Column Layout

Add object page

Switch to FCL

Configure OP

- TypeName + TypeNamePlural + i18n
- Title: Description
- Description Type: Property TravelID 
- Editable Header Content False
- FlexEnabled false

App Preview

# Exercise 3 - Improve Page Layout and add UI5 Freestyle Controls

We will now improve the page layout and add features like a dynamic page title with snapped header content showing the filter status as it is known from the standard Listreport floorplan.\
In order to adopt a custom design proposal, we will then add a tile slider showing open travels with a high total price.
## Exercise 3.1 - Adopt Dynamic Page Layout to the Main Page

Open the [filter bar sample](https://ui5.sap.com/test-resources/sap/fe/core/fpmExplorer/index.html#/buildingBlocks/filterBar/filterBarDefault)

Show snapped header + code

**Main.view.xml**:\
Add a declaration to the **sap.f** library to the header:
```xml
xmlns:f="sap.f"
```

Replace the whole **\<Page\>** section with the adopted code snippet:
```xml
    <f:DynamicPage id="FilterBarDefault" class="sapUiResponsiveContentPadding">
        <f:title>
            <f:DynamicPageTitle id="_IDGenDynamicPageTitle1">
                <f:heading>
                    <Title id="_IDGenTitle1" text="Travel" level="H2" />
                </f:heading>
                <f:snappedContent>
                    <Panel headerText="{i18n>FilterStatus}">
                        <Text text="{fbConditions>/filtersTextInfo}" class="sapUiTinyMargin" />
                    </Panel>
                </f:snappedContent>
            </f:DynamicPageTitle>
        </f:title>
        <f:header>
            <f:DynamicPageHeader id="_IDGenDynamicPageHeader1" pinnable="true">
                <VBox id="_IDGenVBox1">
                    <macros:FilterBar 
                        metaPath="@com.sap.vocabularies.UI.v1.SelectionFields" 
                        id="FilterBar" 
                        filterChanged=".handlers.onFiltersChanged" />
                </VBox>
            </f:DynamicPageHeader>
        </f:header>
        <f:content>
            <macros:Table 
            id="myTable" 
            filterBar="FilterBar" 
            metaPath="@com.sap.vocabularies.UI.v1.LineItem" />
        </f:content>
    </f:DynamicPage>
```
**Explain FPM Filter Status Sample Code**:

- **onAfterRendering** creates a JSONModel with property **filtersTextInfo**

- **onFiltersChanged**, property **filterTextInfo** is set every time the filter has been changed

Open file **Main.controller.js**

Add 
```js 
'sap/ui/model/json/JSONModel'
``` 
Add 
```js
JSONModel
``` 

Replace function **onAfterRendering** with the following code snippet:
```js
             onAfterRendering: function (oEvent) {
				var oView = this.getView();
				var mFBConditions = new JSONModel({
					filtersTextInfo: oView.byId("FilterBar").getActiveFiltersText()
				});
				oView.setModel(mFBConditions, "fbConditions");
			},
```

Add the following wrapped handler function **onFiltersChanged** as shown in the screenshot.
```js
            handlers: {
				onFiltersChanged: function (oEvent) {
					var oSource = oEvent.getSource();
					var mFBConditions = oSource.getModel("fbConditions");
					mFBConditions.setProperty("/filtersTextInfo", oSource.getActiveFiltersText());
				}             
			}
```
**Preview App**

## Exercise 3.3 - Add Generic Tile Slider

The target design of the app sketches an overview on open travels with a high total price in form of a tile slider in the custom page snapped header area. While this could be as well achieved by defining multiple tab views with a selection variant on a standard list report (and it is recommended to always evaluate what can be achieved with the standard means Fiori elements offers), customers might prefer an alternative design approach to meet their requirements, which can be achieved with the Flexible Programming Model.

Open the [Custom Page Sample](https://ui5.sap.com/test-resources/sap/fe/core/fpmExplorer/index.html#/customElements/customElementsOverview/customPageContent)

**Show Custom Page View and nav handler in controller**

**add text keys to i18n**


```js
HighestPrice=Open Travels Highest Total Price (Thousands)

FilterStatus=Table Filter Status
```

Switch to file **Main.view.xml**. Replace the code in **\<f:snappedContent\>** with the following:

```xml
<Panel id='pn1' headerText='{i18n>HighestPrice}'>
    <VBox id='vb1'>
        <HeaderContainer scrollStep="200" showDividers="false" id="container1" content="{
            path:'/Travel', 
            parameters : {
                $filter : 'TravelStatus_code eq \'O\' and IsActiveEntity eq false or SiblingEntity/IsActiveEntity eq null',
                $orderby : 'TotalPrice desc'
            }
        }">
            <GenericTile id='gt1' header="Travel {TravelID}" subheader="{Description}" press=".handlers.onPressed" class="sapUiTinyMarginTop tileLayout">
                <TileContent id='tc1' unit="{CurrencyCode_code}" footer="{to_Customer/LastName}">
                    <NumericContent id='nc1' withMargin="false" value="{TotalPrice}" valueColor="Good" scale="k" />
                </TileContent>
            </GenericTile>
        </HeaderContainer>
    </VBox>
</Panel>
<Panel id='pn2' headerText="{i18n>FilterStatus}">
    <Text id='filterInfo1' text="{fbConditions>/filtersTextInfo}" class="sapUiTinyMargin" />
</Panel>
```
**Add handler function to main controller**

```js
,
onPressed: function (oEvent) {
    var oContext = oEvent.getSource().getBindingContext();
    this.routing.navigate(oContext);
}
```
# Exercise 4 - Page Map: Configuring the Object Page Layout 

**Page Map: add actions to OP Header and define labels**

## Exercise 4.2 - Adding Group and Form Sections

**Add group section Travel**

**Add form sub sections**:

|     Sub Section             |     Property                
|-----------------------------|-----------------------------
|     Travel                  |  
|                             |     TravelID
|                             |     to_Agency_AgencyID
|                             |     to_Customer_CustomerID
|                             |     TravelStatus_Code
|     Prices                  |     
|                             |     BookingFee                            
|                             |     TotalPrice
|     Dates                   |
|                             |     BeginDate
|                             |     EndDate
|     Sustainability          |
|                             |     GoGreen
|                             |     GreenFee
|                             |     TreesPlanted

**Preview app: select tile, click Accept**\
**select annother tile, edit, click green flight fee ->value updated via side effect**

## Exercise 4.3 - Adding a Table Section My Itinerary

**Value source: to_Booking**

**Add Basic columns**:
- **to_Carrier.AirlinePicUrl**
- **BookingID**
- **to_Customer_CustomerID**
- **to_Carrier_AirlineID**
- **ConnectionID**
- **FlightDate**
- **FlightPrice**
- **BookingStatus_code**

**Navigate to annotation**

**Preview App**

# Exercise 5 - Page Map: Add Micro Chart Table Column

The micro chart shall show the Customer VIP Status per booking, based on all cumulated bookings for the corresponding airline.

Calculation done in /srv/travel-service.js#286

**Add chart column**

For the **Chart Type**, select **Radial**.

For **Value** select property **BookedFlights**.

For **Target Value** select **VIPCustomerBookings**.

Drag column **BookedFlights** below **AirlinePicUrl**.

Set criticality property **EligibleForPrime** via **BookedFlights** Property Pane

**Nav to chart annotation**

**Preview App**

# Exercise 6 - Flexible Programming Model: Extending the Object Page with a Custom Section and Building Blocks

In this exercise, we will combine UI5 freestyle controls with Fiori elements building blocks in a custom section.\
With the **table building block**, we get the same behaviour and looks of the replaced table section.

## Exercise 6.1 Remove existing Section via Page Map

**Delete OP section My Itinerary**

## Exercise 6.2 Adding a Custom Section via Page Map

**Add Custom Section My Itinerary**

Set **Generate Event Handler (Controller)** to **true**

## Exercise 6.3 Replace Generated XML Fragment Content

open file **CustomSection.fragment.xml**

**Replace content with**

 ```js
<core:FragmentDefinition
  xmlns:core='sap.ui.core'
  xmlns='sap.m'
  xmlns:l='sap.ui.layout'
  xmlns:macros='sap.fe.macros'
>
 <VBox core:require="{handler: 'sap/fe/cap/managetravels/ext/fragment/CustomSection'}">  
  <MessageStrip
    text='All bookings for travel {TravelID} got confirmed by the agency.'
    showIcon='true'
    class='sapUiSmallMarginBottom'>
  </MessageStrip>     
  <l:Grid hSpacing='1' containerQuery='true'
    defaultSpan='L12 M12 S12'>
   <l:content>
   <macros:Table metaPath='to_Booking/@com.sap.vocabularies.UI.v1.LineItem'
      id='bookingTable'/>
   </l:content>
  </l:Grid>
 </VBox>
</core:FragmentDefinition>
```

## Exercise 6.4 Testing the Table Building Block

**test edit state: choose different Flight Number**

# Exercise 7 - Guided Development: Adding Building Block Chart

The chart building block to be added to the custom section will show aggregated **bookings per customer for all airlines**, complementing the **Customer VIP Status**
scenario.\

File **db/Schema.cds** contains view **BookedFlights** and an association to it in entity **Travel** which we will use as data source for the chart.

In order for the chart to retrieve data, the service requires **oData V4 aggregate transformation capabilities**.\
In file **app/capabilities.cds** you can find the corresponding **aggregation capabilities annotations**.

**explain Aggregation annotation and AggregatedProperties expression**

## Exercise 7.1 - Use Guided Development to Add Building Block Chart

**open guided dev for Chart Building Block**

**Entity: BookedFlights**

**Chart Qualifier: BookedFlights**

**First Dimensions Entity Property: to_Customer_CustomerID**

**Add new dimension: AirlineID, dimension role Series**

**Measures Entity Property: CountFlights**

Ex. 7 Backend handler: The aggregation result for the current Travel's bookings is enriched with aggregated bookings data for all other airlines

**Step 2:

**Set Target Fragment**

**Building Block ID: myChart**

**Entity: Travel**

**Nav Path: to_BookedFlights**

**Chart Qualifier: to_BookedFlights/UI.Chart#BookedFlights**

**Aggregation Path: l:Grid/l:content**

**Selection Change Function**: **handler.onChartSelectionChanged**

**Chart Personalization**: select **Type** and **Item**

**Check and insert snippet, exit guide**

Change the **default span** of the grid control to

```js
defaultSpan='L6 M6 S12'
```

**Switch the order of lines **macros:Chart** and **macros:Table****

**Preview App**

## Exercise 7.3: Implementing the Chart's Selection Change Handler

The **chart building block API** allows implementing a **selection change handler** which is triggered when a chart segment is selected.\
We will use the event to show additional information in a small popover.\

 Drag and drop file **Popover.fragment.xml** (37) to folder **app/managetravels/webapp/ext/fragment** 

 **Add the Popover fragment as a dependent control between l:Grid and l_content.**

```js
  <l:dependents>
    <core:Fragment fragmentName="sap.fe.cap.managetravels.ext.fragment.Popover" type="XML"/>			
  </l:dependents>	
```

## Exercise 7.4 Testing the Chart's Event Handler

**choose one preferred airline for customer, show updated charts**

# Exercise 8 - Page Map: Adding a Controller Extension

In this exercise we will learn how to change the **edit flow** of an app by implementing a controller extension for the object page with support of the Page Map.\
In order to promote the new **green flight offering**, we will intercept the **save action** by overriding function **onBeforeSave** of the\
**edit flow API**, and execute some custom code in order to check whether Trees-4-Tickets has been selected for the travel.\
Additionally, we will make usage of the **form element building block** in order to display a form in a save dialog.

For further details, the Flexible Programming Model Explorer provides detailed [guidance](https://ui5.sap.com/test-resources/sap/fe/core/fpmExplorer/index.html#/controllerExtensions/controllerExtensionsOverview/guidanceControllerExtensions) on how to register and implement a controller extension.

## Exercise 8.1 - Using the Page Map to Add a Controller Extension

**Page Map OP: click controller extension icon**

The Page Map supports the creation of controller extensions overriding all object page controllers globally, or only specific object page instances.\
We will create a specific controller extension for our travel object page.

Insert **ObjectPageExtension** as **Controller Name** 

**show extension in app/manifest.json**.\
show the ID is constructed by using the pattern **YourApplicationID::ComponentID**

In the controller file, below function **onInit()** add the following code which overrides the **editFlow API** function **onBeforeSave**:

```js
,
editFlow: {
	onBeforeSave: function() {
			//Check on green flights
			if (!this.getView().getBindingContext().getProperty('GoGreen')){                        	
				return new Promise(async function(fnResolve, fnReject) {
					var mSettings = {
						id: "myFragment",
						name: "sap.fe.cap.managetravels.ext.fragment.Trees4Tickets",
						controller: this.base.getView().getController(),
						contextPath: "/Travel",
						initialBindingContext: this.getView().getBindingContext()
					}
					var oApproveDialog = await this.base.getExtensionAPI().loadFragment(mSettings);
					oApproveDialog.setBindingContext(this.getView().getBindingContext());
					let buttons = oApproveDialog.getButtons();
					let saveButton = buttons.find(obj => obj.sId === "myFragment--Save");
					saveButton.attachPress(function() {
										oApproveDialog.close();
										oApproveDialog.destroy();										
										fnResolve();	}.bind(this));

					let cancelButton = buttons.find(obj => obj.sId === "myFragment--Cancel");
					cancelButton.attachPress(function() {
										oApproveDialog.close();	
										oApproveDialog.destroy();									
										fnReject();	}.bind(this));
						oApproveDialog.open();
				}.bind(this));
			}						
	}
}
```

**explain onBeforeSave expects a promise resolved (continue save) or rejected (cancel save)**

[FPM Explorer: examples on overriding the edit flow API](https://sapui5.hana.ondemand.com/test-resources/sap/fe/core/fpmExplorer/index.html#/controllerExtensions/controllerExtensionsOverview/basicExtensibility)

## Exercise 8.2 Move XML Fragment to App Folder

Drag and drop file **Trees4Tickets.fragment.xml** to folder **app/managetravels/webapp/ext/fragment**

**Explain xml fragment dialog**

**Explain form element building block**.

- with property **metaPath** pointing to a property of the current binding context, we can show the property as a form field, having the same behaviour as a standard field.
- property **visible** shows and hides the form elements depending on the property path value. We are using boolean property **GoGreen** for that purpose, which is set when the checkbox is selected.

**Preview App**

# Done!
