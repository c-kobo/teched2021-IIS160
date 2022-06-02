using TravelService as service from '../../srv/travel-service';
using from '../../db/schema';

annotate service.Travel with @(
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : TravelID,
        },
        {
            $Type : 'UI.DataField',
            Value : TravelStatus_code,
            Criticality : TravelStatus.criticality,
            ![@UI.Importance] : #High,
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
            Value : BookingFee,
        },
        {
            $Type : 'UI.DataField',
            Value : to_Agency_AgencyID,
            ![@UI.Importance] : #High,
        },
        {
            $Type : 'UI.DataField',
            Value : to_Customer_CustomerID,
            ![@UI.Importance] : #High,
        },
        {
            $Type : 'UI.DataField',
            Value : TotalPrice,
            ![@UI.Importance] : #High,
        },
        {
            $Type : 'UI.DataField',
            Value : createdAt,
        },
        {
            $Type : 'UI.DataField',
            Value : createdBy,
        },
        {
            $Type : 'UI.DataField',
            Value : LastChangedAt,
        },
        {
            $Type : 'UI.DataField',
            Value : LastChangedBy,
        },
    ]
);
annotate service.Travel with @(
    UI.FieldGroup #GeneratedGroup1 : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : TravelID,
            },
            {
                $Type : 'UI.DataField',
                Value : Description,
            },
            {
                $Type : 'UI.DataField',
                Value : TravelStatus_code,
            },
            {
                $Type : 'UI.DataField',
                Value : GoGreen,
            },
            {
                $Type : 'UI.DataField',
                Value : TreesPlanted,
            },
            {
                $Type : 'UI.DataField',
                Value : to_Agency_AgencyID,
            },
            {
                $Type : 'UI.DataField',
                Value : to_Customer_CustomerID,
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.CollectionFacet',
            Label : 'Overview',
            ID : 'Overview',
            Facets : [
            {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : 'General Information',
            Target : '@UI.FieldGroup#GeneratedGroup1',
        },
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Dates',
                    ID : 'Dates',
                    Target : '@UI.FieldGroup#Dates',
                },
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Prices',
                    ID : 'Prices',
                    Target : '@UI.FieldGroup#Prices',
                },
                ],
        },
    ]
);
annotate service.Travel with {
    to_Agency @Common.Text : to_Agency.Name
};
annotate service.Travel with @(
    UI.SelectionFields : [
        to_Agency_AgencyID,
        to_Customer_CustomerID,
        TravelStatus_code,
    ]
);
annotate service.Travel with {
    to_Agency @(Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'TravelAgency',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : to_Agency_AgencyID,
                    ValueListProperty : 'AgencyID',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'PhoneNumber',
                },
            ],
        },
        Common.ValueListWithFixedValues : true
)};
annotate service.Travel with @(
    UI.FieldGroup #Dates : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : createdAt,
            },    {
                $Type : 'UI.DataField',
                Value : createdBy,
            },    {
                $Type : 'UI.DataField',
                Value : LastChangedAt,
            },    {
                $Type : 'UI.DataField',
                Value : LastChangedBy,
            },    {
                $Type : 'UI.DataField',
                Value : BeginDate,
            },    {
                $Type : 'UI.DataField',
                Value : EndDate,
            },],
    }
);
annotate service.Travel with @(
    UI.FieldGroup #Prices : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : BookingFee,
            },    {
                $Type : 'UI.DataField',
                Value : TotalPrice,
            },    {
                $Type : 'UI.DataField',
                Value : CurrencyCode_code,
            },    {
                $Type : 'UI.DataField',
                Value : GreenFee,
            },],
    }
);
annotate service.Travel with @(
    UI.Identification : [
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'TravelService.acceptTravel',
            Label : 'acceptTravel',
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'TravelService.rejectTravel',
            Label : 'rejectTravel',
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'TravelService.deductDiscount',
            Label : 'Deduct Discount',
        },
    ]
);
annotate service.Booking with @(
    UI.LineItem #MyBookings : [
        {
            $Type : 'UI.DataField',
            Value : BookingID,
        },{
            $Type : 'UI.DataField',
            Value : BookingDate,
        },{
            $Type : 'UI.DataField',
            Value : BookingStatus_code,
        },{
            $Type : 'UI.DataField',
            Value : ConnectionID,
        },{
            $Type : 'UI.DataField',
            Value : FlightDate,
        },{
            $Type : 'UI.DataField',
            Value : FlightPrice,
        },{
            $Type : 'UI.DataField',
            Value : to_Carrier_AirlineID,
        },{
            $Type : 'UI.DataField',
            Value : to_Customer_CustomerID,
        },
        {
            $Type : 'UI.DataFieldForAnnotation',
            Target : '@UI.Chart#BookedFlights',
            Label : 'BookedFlights',
            ![@UI.Importance] : #High,
        },]
);
annotate service.Booking with @(
    UI.DataPoint #BookedFlights : {
        Value : BookedFlights,
        TargetValue : to_Carrier.VIPCustomerBookings,
        Criticality : EligibleForPrime,
    },
    UI.Chart #BookedFlights : {
        ChartType : #Donut,
        Measures : [
            BookedFlights,
        ],
        MeasureAttributes : [
            {
                DataPoint : '@UI.DataPoint#BookedFlights',
                Role : #Axis1,
                Measure : BookedFlights,
            },
        ],
    }
);


annotate TravelService.BookedFlights with @(
  Aggregation.ApplySupported: {
    $Type : 'Aggregation.ApplySupportedType',
    Transformations : [
        'aggregate',
        'groupby'
    ],
    Rollup : #None,
    GroupableProperties : [
        to_Customer_CustomerID, AirlineID
    ],
    AggregatableProperties : [
        {
            $Type : 'Aggregation.AggregatablePropertyType',
            Property : BookingUUID 
        },
    ],
  },
  Analytics.AggregatedProperties : [{
    Name : 'CountFlights',
    AggregationMethod : 'countdistinct',
    AggregatableProperty : BookingUUID,
    ![@Common.Label] : 'Booked Flights per Airline',
  }]);

annotate TravelService.BookedFlights with @(
  UI : {
    Chart          : {
    $Type     : 'UI.ChartDefinitionType',
    Title     : 'Total Bookings for Customer',
    Description   : 'Chart Description',
    ChartType     : #Column,
    Measures    : [CountFlights],
    Dimensions    : [to_Customer_CustomerID, AirlineID],
    MeasureAttributes : [{
      $Type : 'UI.ChartMeasureAttributeType',
      Measure : CountFlights,
      Role  : #Axis1
    }],    
    DimensionAttributes : [
      {
      $Type   : 'UI.ChartDimensionAttributeType',
      Dimension : to_Customer_CustomerID,
      Role  : #Category
    },   
    {
      $Type   : 'UI.ChartDimensionAttributeType',
      Dimension : AirlineID,
      Role  : #Series
    }
    ]
    }      
  } 
);
