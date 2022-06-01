using TravelService as service from '../../srv/travel-service';
using from '../../db/schema';

annotate service.Travel with @(
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : TravelID,
            Label : '{i18n>TravelID}',
        },
        {
            $Type : 'UI.DataField',
            Value : TravelStatus_code,
            Criticality : TravelStatus.criticality,
            Label : '{i18n>TravelStatus}',
        },
        {
            $Type : 'UI.DataField',
            Value : BeginDate,
            Label : '{i18n>BeginDate}',
        },
        {
            $Type : 'UI.DataField',
            Value : EndDate,
            Label : '{i18n>EndDate}',
        },
        {
            $Type : 'UI.DataField',
            Value : BookingFee,
            Label : '{i18n>BookingFee}',
        },
        {
            $Type : 'UI.DataField',
            Value : to_Agency_AgencyID,
            Label : '{i18n>AgencyID}',
        },
        {
            $Type : 'UI.DataField',
            Value : to_Customer_CustomerID,
            Label : '{i18n>CustomerID}',
        },
        {
            $Type : 'UI.DataField',
            Value : TotalPrice,
            Label : '{i18n>TotalPrice}',
        },
        {
            $Type : 'UI.DataField',
            Value : createdAt,
            Label : '{i18n>CreatedAt}',
        },
        {
            $Type : 'UI.DataField',
            Value : createdBy,
            Label : '{i18n>UserID}',
        },
        {
            $Type : 'UI.DataField',
            Value : LastChangedAt,
            Label : '{i18n>ChangedAt}',
        },
        {
            $Type : 'UI.DataField',
            Value : LastChangedBy,
            Label : '{i18n>UserID}',
        },
    ]
);
annotate service.Travel with @(
    UI.FieldGroup #GeneratedGroup1 : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : createdBy,
                Label : '{i18n>UserID}',
            },
            {
                $Type : 'UI.DataField',
                Value : LastChangedBy,
                Label : '{i18n>UserID}',
            },
            {
                $Type : 'UI.DataField',
                Value : TravelID,
                Label : '{i18n>TravelID}',
            },
            {
                $Type : 'UI.DataField',
                Value : Description,
                Label : '{i18n>Description}',
            },
            {
                $Type : 'UI.DataField',
                Value : TravelStatus_code,
                Label : '{i18n>TravelStatus}',
            },
            {
                $Type : 'UI.DataField',
                Value : GoGreen,
                Label : '{i18n>GoGreen}',
            },
            {
                $Type : 'UI.DataField',
                Value : TreesPlanted,
                Label : '{i18n>TreesPlanted}',
            },
            {
                $Type : 'UI.DataField',
                Value : to_Agency_AgencyID,
                Label : '{i18n>AgencyID}',
            },
            {
                $Type : 'UI.DataField',
                Value : to_Customer_CustomerID,
                Label : '{i18n>CustomerID}',
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.CollectionFacet',
            Label : '{i18n>Overview}',
            ID : 'i18nOverview',
            Facets : [
            {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : '{i18n>GeneralInformation}',
            Target : '@UI.FieldGroup#GeneratedGroup1',
        },
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : '{i18n>Dates}',
                    ID : 'Dates',
                    Target : '@UI.FieldGroup#Dates',
                },
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : '{i18n>Prices}',
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
        Common.ValueListWithFixedValues : false
)};
annotate service.Travel with @(
    UI.HeaderInfo : {
        TypeName : '{i18n>Travel}',
        TypeNamePlural : '{i18n>Travels}',
        Title : {
            $Type : 'UI.DataField',
            Value : TravelID,
        },
        Description : {
            $Type : 'UI.DataField',
            Value : Description,
        },
    }
);
annotate service.Travel with @(
    UI.Identification : [
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'TravelService.acceptTravel',
            Label : '{i18n>Accepttravel}',
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'TravelService.rejectTravel',
            Label : '{i18n>Rejecttravel}',
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'TravelService.deductDiscount',
            Label : '{i18n>Deductdiscount}',
        },
    ]
);
annotate service.Travel with {
    to_Agency @Common.Label : '{i18n>AgencyID}'
};
annotate service.Travel with {
    to_Customer @Common.Label : '{i18n>CustomerID}'
};
annotate service.Travel with {
    TravelStatus @Common.Label : '{i18n>TravelStatus}'
};
annotate service.Travel with @(
    UI.FieldGroup #Dates : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : createdAt,
                Label : '{i18n>CreatedAt}',
            },    {
                $Type : 'UI.DataField',
                Value : LastChangedAt,
                Label : '{i18n>ChangedAt}',
            },    {
                $Type : 'UI.DataField',
                Value : BeginDate,
                Label : '{i18n>BeginDate}',
            },    {
                $Type : 'UI.DataField',
                Value : EndDate,
                Label : '{i18n>EndDate}',
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
                Label : '{i18n>BookingFee}',
            },    {
                $Type : 'UI.DataField',
                Value : TotalPrice,
                Label : '{i18n>TotalPrice}',
            },    {
                $Type : 'UI.DataField',
                Value : CurrencyCode_code,
                Label : '{i18n>Currency}',
            },    {
                $Type : 'UI.DataField',
                Value : GreenFee,
                Label : '{i18n>GreenFee}',
            },],
    }
);
annotate service.Travel with {
    Description @UI.MultiLineText : true
};
annotate service.Booking with @(
    UI.LineItem #MyBookings : [
        {
            $Type : 'UI.DataField',
            Value : BookingID,
            Label : '{i18n>BookingID}',
        },
        {
            $Type : 'UI.DataFieldForAnnotation',
            Target : '@UI.Chart#BookedFlights',
            Label : 'VIP Customer',
        },
        {
            $Type : 'UI.DataField',
            Value : BookingStatus_code,
            Label : '{i18n>BookingStatus}',
        },{
            $Type : 'UI.DataField',
            Value : BookingDate,
            Label : '{i18n>BookingDate}',
        },{
            $Type : 'UI.DataField',
            Value : ConnectionID,
            Label : '{i18n>ConnectionID}',
        },{
            $Type : 'UI.DataField',
            Value : FlightDate,
            Label : '{i18n>FlightDate}',
        },{
            $Type : 'UI.DataField',
            Value : FlightPrice,
            Label : '{i18n>FlightPrice}',
        },{
            $Type : 'UI.DataField',
            Value : to_Carrier_AirlineID,
            Label : '{i18n>AirlineID}',
        },{
            $Type : 'UI.DataField',
            Value : to_Customer_CustomerID,
            Label : '{i18n>CustomerID}',
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
