CLASS zsample_class_sha DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zsample_class_sha IMPLEMENTATION.
METHOD if_oo_adt_classrun~main.
DATA: lt_order_status TYPE TABLE OF zord_status.

    " Define Fixed Values
    APPEND VALUE #( status = 'PRC' statustext = 'Processing' ) TO lt_order_status.
    APPEND VALUE #( status = 'ONH' statustext = 'On Hold' ) TO lt_order_status.
    APPEND VALUE #( status = 'RFD' statustext = 'Refunded' ) TO lt_order_status.
    APPEND VALUE #( status = 'PND' statustext = 'Pending Payment' ) TO lt_order_status.
    APPEND VALUE #( status = 'CMP' statustext = 'Completed' ) TO lt_order_status.
    APPEND VALUE #( status = 'CAN' statustext = 'Canceled' ) TO lt_order_status.

    " Insert Data
    INSERT zord_status FROM TABLE @lt_order_status.

ENDMETHOD.
ENDCLASS.
