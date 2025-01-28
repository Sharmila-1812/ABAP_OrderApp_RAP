@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Order Status type'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@ObjectModel.resultSet.sizeCategory: #XS
define view entity ZI_SHA_ORDERSTATUS 
 as select from DDCDS_CUSTOMER_DOMAIN_VALUE_T(p_domain_name: 'ZORD_STATUS' )
{
key domain_name,
key value_position,
@Semantics.language: true
key language,
value_low,
@Semantics.text: true
text
}


//as select from zord_status
//{
//    key status as Status,
//    statustext as Statustext
//}
