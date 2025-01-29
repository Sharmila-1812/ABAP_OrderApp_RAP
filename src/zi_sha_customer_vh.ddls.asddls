@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Customer Value help'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
//@ObjectModel.resultSet.sizeCategory: #XS
define view entity ZI_SHA_CUSTOMER_VH as select from zsha_customer
{
 
 @ObjectModel.text.element: [ 'Name' ]
@UI.textArrangement: #TEXT_FIRST
    key customerid,
    name as Name,
    email as Email
}
