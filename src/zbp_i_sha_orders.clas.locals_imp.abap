CLASS lhc_zi_sha_order_items DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS detOrderAmount FOR DETERMINE ON SAVE
      IMPORTING keys FOR zi_sha_order_items~detOrderAmount.
    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR zi_sha_order_items RESULT result.
    METHODS detorderamountdelete FOR DETERMINE ON MODIFY
      IMPORTING keys FOR zi_sha_order_items~detorderamountdelete.
*    METHODS detorderamount1 FOR DETERMINE ON SAVE
*      IMPORTING keys FOR zi_sha_order_items~detorderamount1.

ENDCLASS.

CLASS lhc_zi_sha_order_items IMPLEMENTATION.

  METHOD detOrderAmount.

    READ ENTITIES OF zi_sha_orders "IN LOCAL MODE
       ENTITY zi_sha_order_items
       FIELDS (  Totalprice Cukyfield )
       WITH VALUE #( ( %key-Orderitemid = keys[ 1 ]-%key-Orderitemid  ) )
       RESULT DATA(result_items).

          READ ENTITIES OF zi_sha_orders "in  LOCAL MODE
   ENTITY zi_sha_order_items BY \_orders
   FIELDS ( Amount Curr )
   WITH VALUE #( ( %key-Orderitemid = result_items[ 1 ]-%key-Orderitemid  ) )
   RESULT DATA(result_amount).


    IF sy-subrc = 0.

      LOOP AT result_items INTO DATA(items_amt).
        "IF ( result_amount[ 1 ]-Curr  = result_items[ 1 ]-Cukyfield  ).

        result_amount[ 1 ]-Amount = result_amount[ 1 ]-Amount + items_amt-Totalprice.
        result_amount[ 1 ]-Curr = result_items[ 1 ]-Cukyfield.
        "ENDIF.
      ENDLOOP.
    ELSE.
      result_amount[ 1 ]-Amount = result_amount[ 1 ]-Amount.
    ENDIF.

    MODIFY ENTITIES OF zi_sha_orders" IN LOCAL MODE
   ENTITY zi_sha_orders
   UPDATE FIELDS ( Amount Curr )


   WITH VALUE #( (  %key-Orderid = result_amount[ 1 ]-Orderid
   Amount = result_amount[ 1 ]-Amount
   Curr = result_amount[ 1 ]-Curr
 " %control-Amount = if_abap_behv=>mk-on
 " %control-Curr = if_abap_behv=>mk-on
 ) )
   FAILED DATA(failed)
   REPORTED DATA(reported1).

 ENDMETHOD.

  METHOD get_instance_features.
    LOOP AT keys INTO DATA(key).
      READ ENTITIES OF zi_sha_orders IN LOCAL MODE
       ENTITY zi_sha_order_items BY \_orders
     FIELDS ( Status )
     WITH VALUE #( ( %key-Orderitemid = key-Orderitemid ) )
     RESULT DATA(Status).

*      DATA(lv_feature_control) = if_abap_behv=>fc-o-enabled.
*      IF  status[ 1 ]-Status = 'CMP' OR status[ 1 ]-Status = 'CAN'.
*        lv_feature_control = if_abap_behv=>fc-o-disabled.
*      ENDIF.

      If status[ 1 ]-Status = 'CMP' OR status[ 1 ]-Status = 'CAN'.
       DATA(lv_feature) = if_abap_behv=>fc-o-disabled.
      ELSE.
      lv_feature = if_abap_behv=>fc-o-enabled.
      ENDIF.


    ENDLOOP.
    result = VALUE #( ( %tky = key-%tky
           %features-%delete = lv_feature
           %features-%update = lv_feature
            ) ).

  ENDMETHOD.

 " METHOD detOrderAmount1.

*READ ENTITIES OF zi_sha_orders
*        ENTITY zi_sha_order_items
*        FIELDS ( Orderid Totalprice Cukyfield )
*        WITH CORRESPONDING #( keys )
*        RESULT DATA(deleted_items).
*
*    " Check if there are deleted items
*    IF deleted_items IS NOT INITIAL.
*
*        " Read the related order amount
*        READ ENTITIES OF zi_sha_orders
*            ENTITY zi_sha_orders
*            FIELDS ( Amount Curr )
*            WITH VALUE #( FOR item IN deleted_items ( %key-Orderid = item-Orderid ) )
*            RESULT DATA(order_amounts).
*
*        " Ensure order_amounts table is not empty
*        LOOP AT deleted_items INTO DATA(del_item).
*            READ TABLE order_amounts WITH KEY %key-Orderid = del_item-Orderid INTO DATA(order_amt).
*            IF sy-subrc = 0.
*
*                " Subtract deleted item price from total order amount
*                order_amt-Amount = order_amt-Amount - del_item-Totalprice.
*                order_amt-Curr = del_item-Cukyfield.
*
*                " Modify the updated Amount in the parent order
*                MODIFY ENTITIES OF zi_sha_orders
*                    ENTITY zi_sha_orders
*                    UPDATE FIELDS ( Amount Curr )
*                    WITH VALUE #( ( %key-Orderid = order_amt-%key-Orderid
*                                    Amount = order_amt-Amount
*                                    Curr = order_amt-Curr ) ).
*            ENDIF.
*        ENDLOOP.
*    ENDIF.


*   READ ENTITIES OF zi_sha_orders "IN LOCAL MODE
*       ENTITY zi_sha_order_items
*       FIELDS (  Totalprice Cukyfield )
*       WITH VALUE #( ( %key-Orderitemid = keys[ 1 ]-%key-Orderitemid  ) )
*       RESULT DATA(result_items).
*
*  READ ENTITIES OF zi_sha_orders "in  LOCAL MODE
*   ENTITY zi_sha_order_items BY \_orders
*   FIELDS ( Amount Curr )
*   WITH VALUE #( ( %key-Orderitemid = result_items[ 1 ]-%key-Orderitemid  ) )
*   RESULT DATA(result_amount).
**
*    IF sy-subrc = 0.
*
*      LOOP AT result_items INTO DATA(items_amt).
*        "IF ( result_amount[ 1 ]-Curr  = result_items[ 1 ]-Cukyfield  ).
*
*        result_amount[ 1 ]-Amount = result_amount[ 1 ]-Amount - items_amt-Totalprice.
*        result_amount[ 1 ]-Curr = result_items[ 1 ]-Cukyfield.
*        "ENDIF.
*      ENDLOOP.
*    ELSE.
*      result_amount[ 1 ]-Amount = result_amount[ 1 ]-Amount.
*    ENDIF.
*
*    MODIFY ENTITIES OF zi_sha_orders" IN LOCAL MODE
*   ENTITY zi_sha_orders
*   UPDATE FIELDS ( Amount Curr )
*   WITH VALUE #( (  %key-Orderid = result_amount[ 1 ]-Orderid
*   Amount = result_amount[ 1 ]-Amount
*   Curr = result_amount[ 1 ]-Curr ) )
*   FAILED DATA(failed)
*   REPORTED DATA(reported1).
" ENDMETHOD.

  METHOD detOrderAmountDelete.
  READ ENTITIES OF zi_sha_orders
        ENTITY zi_sha_order_items
        FIELDS ( Orderid Totalprice Cukyfield )
        WITH VALUE #( ( %key-Orderitemid = keys[ 1 ]-%key-Orderitemid  ) )
        RESULT DATA(deleted_items).

    " Check if there are deleted items
    IF deleted_items IS not INITIAL.

        " Read the related order amount
        READ ENTITIES OF zi_sha_orders
            ENTITY zi_sha_orders
            FIELDS ( Amount Curr )
            WITH VALUE #( FOR item IN deleted_items ( %key-Orderid = item-Orderid ) )
            RESULT DATA(order_amounts).

        " Ensure order_amounts table is not empty
        LOOP AT deleted_items INTO DATA(del_item).
            READ TABLE order_amounts WITH KEY %key-Orderid = del_item-Orderid INTO DATA(order_amt).
            IF sy-subrc = 0.

                " Subtract deleted item price from total order amount
                order_amt-Amount = order_amt-Amount - del_item-Totalprice.
                order_amt-Curr = del_item-Cukyfield.

                " Modify the updated Amount in the parent order
                MODIFY ENTITIES OF zi_sha_orders
                    ENTITY zi_sha_orders
                    UPDATE FIELDS ( Amount Curr )
                    WITH VALUE #( ( %key-Orderid = order_amt-%key-Orderid
                                    Amount = order_amt-Amount
                                    Curr = order_amt-Curr ) ).
            ENDIF.
        ENDLOOP.
    ENDIF.


  ENDMETHOD.

ENDCLASS.

CLASS lhc_ZI_SHA_ORDERS DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zi_sha_orders RESULT result.
    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR zi_sha_orders RESULT result.
    METHODS setcompleted FOR MODIFY
      IMPORTING keys FOR ACTION zi_sha_orders~setcompleted.
    METHODS setcancelled FOR MODIFY
      IMPORTING keys FOR ACTION zi_sha_orders~setcancelled.
    METHODS detstatus FOR DETERMINE ON SAVE
      IMPORTING keys FOR zi_sha_orders~detstatus.


ENDCLASS.

CLASS lhc_ZI_SHA_ORDERS IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_instance_features.
    LOOP AT keys INTO DATA(key).
      READ ENTITIES OF zi_sha_orders IN LOCAL MODE
      ENTITY zi_sha_orders BY \_orderItems
          FIELDS ( Orderitemid  )
          WITH VALUE #( ( %key-Orderid = key-Orderid ) )
          RESULT DATA(Orders).

      READ ENTITIES OF zi_sha_orders IN LOCAL MODE
      ENTITY zi_sha_orders
    FIELDS ( Status )
    WITH VALUE #( ( %key-Orderid = key-Orderid ) )
    RESULT DATA(Status).

      IF lines( orders ) = 5.
        DATA(lv_feature_control) = if_abap_behv=>fc-o-disabled.
      ELSE.
      lv_feature_control = if_abap_behv=>fc-o-enabled.
      ENDIF.

      If  status[ 1 ]-Status = 'CMP' OR status[ 1 ]-Status = 'CAN' and lines( orders ) < 5.
       DATA(lv_feature) = if_abap_behv=>fc-o-disabled.
       lv_feature_control = if_abap_behv=>fc-o-disabled.
      ELSE.
      lv_feature = if_abap_behv=>fc-o-enabled.
      lv_feature_control = if_abap_behv=>fc-o-enabled.
      ENDIF.

  result = VALUE #(  ( %tky = key-%tky
           %features-%assoc-_orderItems = lv_feature_control
           %features-%delete = lv_feature
           %features-%update = lv_feature
            ) ).
    ENDLOOP.


  ENDMETHOD.

  METHOD setCompleted.
*    DATA: lt_orders TYPE TABLE FOR UPDATE zi_sha_orders,
*          ls_orders LIKE LINE OF lt_orders.

*    READ ENTITIES OF zi_sha_orders IN LOCAL MODE
*    ENTITY  zi_sha_orders
*    ALL FIELDS WITH VALUE #( ( %key-Orderid = keys[ 1 ]-%key-Orderid ) )
*    RESULT DATA(Orders).
*
*    LOOP AT Orders INTO DATA(ls_ord).
*      ls_orders = CORRESPONDING #( ls_ord ).
*      ls_orders-Status = 'CMP'.
*      ls_orders-Comments = 'Order Completed'.
*      ls_orders-%control-Status = if_abap_behv=>mk-on.
*      APPEND ls_orders TO lt_orders.
*    ENDLOOP.

    MODIFY ENTITIES OF zi_sha_orders IN LOCAL MODE
    ENTITY zi_sha_orders
    UPDATE FIELDS ( Status Comments )
    WITH VALUE #( FOR key IN keys
    ( %key-Orderid = key-Orderid
    Status = 'CMP' "lt_orders[ 1 ]-Status
    Comments = 'Order Completed' ) )"lt_orders[ 1 ]-Comments ) )
    FAILED DATA(failed1)
    REPORTED DATA(reported1).



  ENDMETHOD.

  METHOD setCancelled.
*    DATA: lt_orders TYPE TABLE FOR UPDATE zi_sha_orders,
*          ls_orders LIKE LINE OF lt_orders.
*
*    READ ENTITIES OF zi_sha_orders IN LOCAL MODE
*    ENTITY  zi_sha_orders
*    ALL FIELDS WITH VALUE #( ( %key-Orderid = keys[ 1 ]-%key-Orderid ) )
*    RESULT DATA(Orders).
*
*    LOOP AT Orders INTO DATA(ls_ord).
*      ls_orders = CORRESPONDING #( ls_ord ).
*      ls_orders-Status = 'CAN'.
*      ls_orders-%control-Status = if_abap_behv=>mk-on.
*      APPEND ls_orders TO lt_orders.
*    ENDLOOP.

    MODIFY ENTITIES OF zi_sha_orders IN LOCAL MODE
    ENTITY zi_sha_orders
    UPDATE FIELDS ( Status Comments )
    WITH VALUE #( FOR key IN keys
    ( %key-Orderid = key-Orderid
    Comments = key-%param-comments
    Status = 'CAN' ) ) "lt_orders[ 1 ]-Status ) )
    REPORTED DATA(report)
    FAILED DATA(fail).
  ENDMETHOD.



  METHOD detStatus.
    MODIFY ENTITIES OF zi_sha_orders IN LOCAL MODE
     ENTITY zi_sha_orders
     UPDATE FROM VALUE #( ( %key-Orderid = keys[ 1 ]-%key-Orderid
     Status = 'PRC'
    Amount = '0.0'
     Curr = 'INR'
     %control-Status = if_abap_behv=>mk-on
     %control-Amount = if_abap_behv=>mk-on
     %control-Curr = if_abap_behv=>mk-on ) )
     FAILED DATA(failed)
     REPORTED DATA(reprt).
  ENDMETHOD.

ENDCLASS.
