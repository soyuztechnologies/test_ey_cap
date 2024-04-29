using CatalogService as service from '../../srv/CatalogService';

annotate service.POs with @(

    UI.SelectionFields:[
        PO_ID,
        PARTNER_GUID.COMPANY_NAME,
        PARTNER_GUID.ADDRESS_GUID.COUNTRY,
        GROSS_AMOUNT,
        CURRENCY_code
    ],
    UI.LineItem:[
        {
            $Type : 'UI.DataField',
            Value : PO_ID,
        },
        {
            $Type : 'UI.DataField',
            Value : PARTNER_GUID.COMPANY_NAME,
        },
        {
            $Type : 'UI.DataField',
            Value : PARTNER_GUID.ADDRESS_GUID.COUNTRY,
        },
        {
            $Type : 'UI.DataField',
            Value : GROSS_AMOUNT,
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'CatalogService.boost',
            Label: 'Boost',
            Inline: true
        },
        {
            $Type : 'UI.DataField',
            Value : OverallStatus,
            Criticality: Criticality
        },
    ],
    UI.HeaderInfo:{
        TypeName: 'Purchase Order',
        TypeNamePlural: 'Purchase Orders',
        Title : {Value : PO_ID},
        Description: {Value : PARTNER_GUID.COMPANY_NAME},
        ImageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/3/34/EY_logo_2019.svg/1200px-EY_logo_2019.svg.png'
    },
    UI.Facets: [
        {
            $Type : 'UI.CollectionFacet',
            Label: 'More Info',
            Facets : [
                {
                    $Type : 'UI.ReferenceFacet',
                    Target : '@UI.Identification',
                    Label: 'Details'
                },
                {
                    $Type : 'UI.ReferenceFacet',
                    Target : '@UI.FieldGroup#Spiderman',
                    Label: 'Pricing'
                },
                {
                    $Type : 'UI.ReferenceFacet',
                    Target : '@UI.FieldGroup#Superman',
                    Label: 'Status'
                },
            ],
        },
        {
            $Type : 'UI.ReferenceFacet',
            Target : 'Items/@UI.LineItem',
            Label: 'PO Items'
        },
    ],
    UI.Identification: [
        {
            $Type : 'UI.DataField',
            Value : PO_ID,
        },
        {
            $Type : 'UI.DataField',
            Value : PARTNER_GUID_NODE_KEY,
        },
        {
            $Type : 'UI.DataField',
            Value : LIFECYCLE_STATUS,
        },
    ],
    UI.FieldGroup #Spiderman:{
        Data : [
            {
                $Type : 'UI.DataField',
                Value : GROSS_AMOUNT,
            },
            {
                $Type : 'UI.DataField',
                Value : NET_AMOUNT,
            },
            {
                $Type : 'UI.DataField',
                Value : TAX_AMOUNT,
            },
        ],
    },
    UI.FieldGroup #Superman:{
        Data : [
            {
                $Type : 'UI.DataField',
                Value : CURRENCY_code,
            },
            {
                $Type : 'UI.DataField',
                Value : OVERALL_STATUS,
            },
        ],
    }

);

annotate service.POItems with @(
    UI.LineItem: [
        {
            $Type : 'UI.DataField',
            Value : PO_ITEM_POS,
        },
        {
            $Type : 'UI.DataField',
            Value : PRODUCT_GUID_NODE_KEY,
        },
        {
            $Type : 'UI.DataField',
            Value : GROSS_AMOUNT,
        },
        {
            $Type : 'UI.DataField',
            Value : CURRENCY_code,
        },
    ],
    UI.HeaderInfo:{
        TypeName: 'PO Item',
        TypeNamePlural: 'PO Items',
        Title : {Value : PO_ITEM_POS},
        Description: {Value: PRODUCT_GUID.DESCRIPTION}
    },
    UI.Facets: [{
        $Type : 'UI.ReferenceFacet',
        Target : '@UI.Identification',
        Label: 'Line Details'
    },],
    UI.Identification:[
        {
            $Type : 'UI.DataField',
            Value : PO_ITEM_POS,
        },{
            $Type : 'UI.DataField',
            Value : PRODUCT_GUID_NODE_KEY,
        },{
            $Type : 'UI.DataField',
            Value : GROSS_AMOUNT,
        },{
            $Type : 'UI.DataField',
            Value : NET_AMOUNT,
        },{
            $Type : 'UI.DataField',
            Value : TAX_AMOUNT,
        },{
            $Type : 'UI.DataField',
            Value : CURRENCY_code,
        }
    ]
);

annotate service.POs with {
    PARTNER_GUID @(
        Common.Text: PARTNER_GUID.COMPANY_NAME,
        ValueList.entity: service.BusinessPartnerSet
    )    
};

annotate service.POItems with {
    PRODUCT_GUID @(
        Common.Text: PRODUCT_GUID.DESCRIPTION,
        ValueList.entity: service.ProductSet
    )
};

@cds.odata.valuelist
annotate service.BusinessPartnerSet with @(
    UI.Identification:[{
        $Type : 'UI.DataField',
        Value: COMPANY_NAME
    }]
);

@cds.odata.valuelist
annotate service.ProductSet with @(
    UI.Identification:[{
        $Type : 'UI.DataField',
        Value: DESCRIPTION
    }]
);
