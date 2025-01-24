CLASS lhc_ZI_SHA_CUSTOMER DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zi_sha_customer RESULT result.

ENDCLASS.

CLASS lhc_ZI_SHA_CUSTOMER IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

ENDCLASS.
