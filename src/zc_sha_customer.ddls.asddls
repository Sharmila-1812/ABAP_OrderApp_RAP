@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Customer Consumption View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@UI: {
 headerInfo: {
 typeName: 'Customer',
 typeNamePlural: 'Customers'
}
}
define root view entity ZC_SHA_CUSTOMER
provider contract transactional_query
 as projection on ZI_SHA_CUSTOMER
{
    @UI.facet: [ {
       id: 'idCustomer',
       type: #IDENTIFICATION_REFERENCE,
       label: 'Customers',
       position: 10
       }]
       @UI.identification: [ {position: 10} ]
  @EndUserText.label: 'Customer ID'
    key Customerid,
    @UI.identification: [ {position: 20} ]
    @UI.lineItem: [ { position: 10} ]
  @UI.selectionField: [{ position: 10 }]
  @EndUserText.label: 'Customer Name'
    Name,
    @UI.identification: [ {position: 30} ]
  @EndUserText.label: 'City'
    City,
    @UI.identification: [ {position: 40} ]
    @UI.lineItem: [ { position: 20} ]
  @UI.selectionField: [{ position: 20 }]
  @EndUserText.label: 'Country'
  @Consumption.valueHelpDefinition: [{ entity: {element: 'Country', name: 'I_CountryVH' } }]
    Country,
    @UI.identification: [ {position: 50} ]
  @EndUserText.label: 'Email ID'
    Email
//    _orders : redirected to ZC_SHA_ORDERS
    }
