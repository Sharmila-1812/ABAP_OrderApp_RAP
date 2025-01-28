@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Order Items Consumption View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@UI: {
 headerInfo: {
 typeName: 'Order Item List',
 typeNamePlural: 'Order Items',
 title.value: 'Productname'
}
}
define view entity ZC_SHA_ORDER_ITEMS
  //provider contract transactional_query
  as projection on ZI_SHA_ORDER_ITEMS
{
      @UI.facet: [ {
          id: 'idOrderItems',
          type: #IDENTIFICATION_REFERENCE,
          label: 'Order Items',
          position: 10
          } ]
      @UI.identification: [ {position: 10} ]
      @UI.lineItem: [ { position: 10} ]
      @UI.selectionField: [{ position: 10 }]
      @EndUserText.label: 'Order Item ID'
  key Orderitemid,
      @UI.identification: [ {position: 20} ]
      @EndUserText.label: 'Order ID'
      Orderid,
      @UI.identification: [ {position: 30} ]
      @UI.lineItem: [ { position: 20} ]
      @UI.selectionField: [{ position: 20 }]
      @EndUserText.label: 'Product Name'
      Productname,
      Unitfield,
      @Semantics.quantity.unitOfMeasure: 'Unitfield'
      @UI.identification: [ {position: 40} ]
      @UI.lineItem: [ { position: 30} ]
      @EndUserText.label: 'Quantity'
      Quantity,
      Cukyfield,
      @Semantics.amount.currencyCode: 'Cukyfield'
      Unitprice,
      @Semantics.amount.currencyCode: 'Cukyfield'
      @UI.identification: [ {position: 50} ]
      @UI.lineItem: [ { position: 40} ]
      @EndUserText.label: 'Total Amount'
      Totalprice,
      @UI.identification: [ {position: 60} ]
      Createdby,
      @UI.identification: [ {position: 70} ]
      Createdat,
      @UI.identification: [ {position: 80} ]
      Lastchangedby,
      @UI.identification: [ {position: 90} ]
      Changedat,
      /* Associations */
      _orders : redirected to parent ZC_SHA_ORDERS
}
