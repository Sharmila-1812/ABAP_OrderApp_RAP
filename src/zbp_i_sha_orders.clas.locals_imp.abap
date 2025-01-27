CLASS lhc_zi_sha_order_items DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS detOrderAmount FOR DETERMINE ON SAVE
      IMPORTING keys FOR ZI_SHA_ORDER_ITEMS~detOrderAmount.

ENDCLASS.

CLASS lhc_zi_sha_order_items IMPLEMENTATION.

  METHOD detOrderAmount.
   READ ENTITIES OF zi_sha_orders
      ENTITY zi_sha_order_items
      FIELDS (  Totalprice Cukyfield )
      WITH VALUE #( ( %key-Orderitemid = keys[ 1 ]-%key-Orderitemid  ) )
      RESULT DATA(result_items).

      READ ENTITIES OF zi_sha_orders
     ENTITY zi_sha_order_items BY \_orders
     FIELDS ( Amount Curr )
     WITH VALUE #( ( %key-Orderitemid = result_items[ 1 ]-%key-Orderitemid  ) )
     RESULT DATA(result_amount).
*
 IF sy-subrc = 0.

      LOOP AT result_items INTO DATA(items_amt).
            IF ( result_amount[ 1 ]-Curr  = result_items[ 1 ]-Cukyfield  ).
              result_amount[ 1 ]-Amount = result_amount[ 1 ]-Amount - items_amt-Totalprice.
            ENDIF.
      ENDLOOP.
    ELSE.
      result_amount[ 1 ]-Amount = result_amount[ 1 ]-Amount.
    ENDIF.

     MODIFY ENTITIES OF zi_sha_orders
    ENTITY zi_sha_orders
*       UPDATE FIELDS ( Balance )
*    WITH VALUE #( FOR key IN keys
*    ( %key-AccUuid = key-AccUuid
*    Balance = lt_account_u[ 1 ]-Balance ) )
    UPDATE FROM  VALUE #( (  %key-Orderid = result_amount[ 1 ]-Orderid
    Amount = result_amount[ 1 ]-Amount
    %control-Amount = if_abap_behv=>mk-on ) )
    FAILED DATA(failed)
    REPORTED DATA(reported1).

  ENDMETHOD.

ENDCLASS.

CLASS lhc_ZI_SHA_ORDERS DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zi_sha_orders RESULT result.
    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR zi_sha_orders RESULT result.

ENDCLASS.

CLASS lhc_ZI_SHA_ORDERS IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_instance_features.
   READ ENTITIES OF zi_sha_orders IN LOCAL MODE
   ENTITY zi_sha_orders BY \_orderItems
       FIELDS ( Orderitemid )
       WITH VALUE #( ( %key-Orderid = keys[ 1 ]-%key-Orderid ) )
       RESULT DATA(Orders).

    DATA: lv_count TYPE i.
*          modify_create TYPE string.

    lv_count = lines( Orders ).

   DATA(modify_create) = COND #( WHEN lv_count EQ 5
    THEN  if_abap_behv=>fc-o-disabled
    ELSE if_abap_behv=>fc-o-enabled ).

    result = VALUE #( ( %tky = keys[ 1 ]-%tky
    %features-%assoc-_orderItems = modify_create ) ).
  ENDMETHOD.

ENDCLASS.
