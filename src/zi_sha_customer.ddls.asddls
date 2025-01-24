@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Customer Interface View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZI_SHA_CUSTOMER as select from zsha_customer
association[1..*] to ZI_SHA_ORDERS as _orders on $projection.Customerid = _orders.Customerid
association [1] to I_CountryVH as _country on $projection.Country = _country.Country
{
    key customerid as Customerid,
    name as Name,
    city as City,
   country as Country,
    email as Email,
    _orders,
    _country
}
