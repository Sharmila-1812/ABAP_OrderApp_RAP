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
association to ZI_SHA_CUSTOMER_VH as _customers on $projection.Customerid = _customers.customerid
association[0..1] to ZI_SHA_ORDERSTATUS as _order on $projection.Status = _order.value_low
{
    key orderid as Orderid,
    @ObjectModel.text.association: '_customers' 
    customerid as Customerid,
    _customers.Name as CustomerName,
    orderdate as Orderdate,
    curr as Curr,
    @Semantics.amount.currencyCode: 'Curr'
    amount as Amount, 
    @ObjectModel.text.association: '_order' 
    status as Status,
    _order.text as StatusDesc,
    comments as Comments,
    @Semantics.user.createdBy: true
    createdby as Createdby,
    @Semantics.systemDateTime.createdAt: true
    createdat as Createdat,
    @Semantics.user.lastChangedBy: true
    lastchangedby as Lastchangedby,
    @Semantics.systemDateTime.lastChangedAt: true
    changedat as Changedat,
    _orderItems,_customers,_order
}
