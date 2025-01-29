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
 title.value: 'StatusDesc'
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
       }
//{id:'Header1', purpose: #HEADER,
//type:#DATAPOINT_REFERENCE,
//targetQualifier:'HD', position: 60
//}
]

      @UI.identification: [ {position: 10} ]
      @UI.lineItem: [{ type: #FOR_ACTION, dataAction: 'setCompleted' , label: 'Set as completed' },
      { type: #FOR_ACTION, dataAction: 'setCancelled' , label: 'Set as cancelled' }]
//     @UI.selectionField: [{ position: 10 } ]
      @EndUserText.label: 'Order ID'
  key Orderid,
      @UI.identification: [ {position: 20} ]
    //  @UI.lineItem: [ { position: 10} ]
      @EndUserText.label: 'Customer ID'
      @UI.selectionField: [{ position: 20 }]
      @ObjectModel.text.element: [ 'CustomerName' ]
@UI.textArrangement: #TEXT_FIRST
      @Consumption.valueHelpDefinition: [{entity: { element: 'customerid', name: 'ZI_SHA_CUSTOMER_VH' } }]
      Customerid,
       @UI.lineItem: [ { position: 10} ]
        @EndUserText.label: 'Customer Name'
      CustomerName,
        
      @UI.identification: [ {position: 30} ]
      @EndUserText.label: 'Order Date'
      @UI.lineItem: [ { position: 40} ]
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
      @ObjectModel.text.element: [ 'StatusDesc' ]
@UI.textArrangement: #TEXT_FIRST
      @Consumption.valueHelpDefinition: [{ entity: {element: 'value_low', name: 'ZI_SHA_ORDERSTATUS' } }]
    //  @ObjectModel.text.association: '_order' 
      Status,
      StatusDesc,
//      @UI.identification: [ {position: 60} ]
//      @EndUserText.label: 'Status Desc'
//      //@UI.dataPoint:{ title:'Order Status', qualifier: 'HD' }
//      StatusDesc,
      @UI.identification: [ {position: 70} ]
      @EndUserText.label: 'Comments'
      Comments,
      @UI.identification: [ {position: 80} ]
      Createdby,
      @UI.identification: [ {position: 90} ]
      Createdat,
      @UI.identification: [ {position: 100} ]
      Lastchangedby,
      @UI.identification: [ {position: 110} ]
      Changedat,

      /* Associations */
      _customers,// : redirected to ZC_SHA_CUSTOMER,
      _orderItems : redirected to composition child ZC_SHA_ORDER_ITEMS,
      _order
}
