@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Orders Consumption View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@UI: {
 headerInfo: {
 typeName: 'Order',
 typeNamePlural: 'Orders',
 title.value: 'Orderid'
 }
}
define root view entity ZC_SHA_ORDERS
provider contract transactional_query
 as projection on ZI_SHA_ORDERS
{

  @UI.facet: [ {
    id: 'idOrders',
    type: #IDENTIFICATION_REFERENCE,
    label: 'Order Info',
    position: 10
    },
    {
   id: 'idTransaction',
   type: #LINEITEM_REFERENCE,
   label: 'Order Items',
   position: 20,
   targetElement: '_orderItems'
   }]
     @UI.identification: [ {position: 10} ]
    @UI.lineItem: [ { position: 10} ]
  @UI.selectionField: [{ position: 10 }]
  @EndUserText.label: 'Order ID'
    key Orderid,
    @UI.identification: [ {position: 20} ]
    @EndUserText.label: 'Customer ID'
     @UI.selectionField: [{ position: 20 }]
    @Consumption.valueHelpDefinition: [{entity: { element: 'Customerid', name: 'ZI_SHA_CUSTOMER' } }]
    Customerid,
     @UI.identification: [ {position: 30} ]
    @EndUserText.label: 'Order Date'
    Orderdate,
    @Consumption.valueHelpDefinition: [{ entity: {element: 'Currency', name: 'I_CurrencyStdVH' } }]
    Curr,
    @Semantics.amount.currencyCode: 'Curr'
     @UI.identification: [ {position: 40} ]
     @UI.lineItem: [ { position: 20} ]
    @EndUserText.label: 'Order Amount'
    Amount,
     @UI.identification: [ {position: 50} ]
     @UI.selectionField: [{ position: 30 }]
     @UI.lineItem: [ { position: 30} ]
    @EndUserText.label: 'Order Status'
    @Consumption.valueHelpDefinition: [{ entity: {element: 'Status', name: 'ZI_SHA_ORDERSTATUS' } }]
    Status,
    @UI.identification: [ {position: 60} ]
    Comments,
    @UI.identification: [ {position: 70} ]
    Createdby,
    @UI.identification: [ {position: 80} ]
    Createdat,
    @UI.identification: [ {position: 90} ]
    Lastchangedby,
    @UI.identification: [ {position: 100} ]
    Changedat,
    
    /* Associations */
    _customers : redirected to ZC_SHA_CUSTOMER,
    _orderItems : redirected to composition child ZC_SHA_ORDER_ITEMS
}
