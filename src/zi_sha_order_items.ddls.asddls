@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Order Items Interface View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_SHA_ORDER_ITEMS as select from zsha_order_items
association to parent ZI_SHA_ORDERS as _orders on $projection.Orderid = _orders.Orderid
{
    key orderitemid as Orderitemid,
    orderid as Orderid,
    productname as Productname,
    unitfield as Unitfield,
    @Semantics.quantity.unitOfMeasure: 'Unitfield'
    quantity as Quantity,
    cukyfield as Cukyfield,
    @Semantics.amount.currencyCode: 'Cukyfield'
    unitprice as Unitprice,
    @Semantics.amount.currencyCode: 'Cukyfield'
    totalprice as Totalprice,
    createdby as Createdby,
    createdat as Createdat,
    lastchangedby as Lastchangedby,
    changedat as Changedat,
    _orders
}
