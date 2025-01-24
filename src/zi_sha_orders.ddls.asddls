@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Orders Interface View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZI_SHA_ORDERS as select from zsha_orders
composition[1..*] of ZI_SHA_ORDER_ITEMS as _orderItems 
association to ZI_SHA_CUSTOMER as _customers on $projection.Customerid = _customers.Customerid
association [1] to ZI_SHA_ORDERSTATUS as _order on $projection.Status = _order.Status
{
    key orderid as Orderid,
    customerid as Customerid,
    orderdate as Orderdate,
    curr as Curr,
    @Semantics.amount.currencyCode: 'Curr'
    amount as Amount,
    status as Status,
    comments as Comments,
    createdby as Createdby,
    createdat as Createdat,
    lastchangedby as Lastchangedby,
    changedat as Changedat,
    _orderItems,_customers,_order
}
