--@Autor: Aldo Yael Navarrete Zamora, Diego Ignacio Núñez Hernández
--@Fecha creación:  08/12/2024
--@Descripción:     Crea tablespaces del la BD de proyecto final

Prompt Creando tablespaces para el proyecto final

Prompt conectando como sysdba
connect sys/system1 as sysdba

whenever sqlerror exit rollback
set serveroutput on

----------------------------------- Modulo 1. Usuarios y Transacciones -----------------------------------
alter session set container = naproynu_modulo_1;

----- TS_USERS_DATA 
-- USER, CLIENT, DEALER, PROVIDER
create tablespace TS_USERS_DATA
  datafile 
  '/unam/bda/proyecto-final/d11/TS_USERS_DATA01.dbf' size 100m,
  '/unam/bda/proyecto-final/d12/TS_USERS_DATA02.dbf' size 100m,
  '/unam/bda/proyecto-final/d13/TS_USERS_DATA03.dbf' size 100m
  autoextend on next 50m maxsize 500m
  extent management local autoallocate
  segment space management auto;

----- TS_USERS_BLOB
-- PROVIDER_GALLERY
-- CLIENT_PHOTO, DEALER_PHOTO, DEALER_MOTORCYCLE_PHOTO, PROVIDER_LOGO
create bigfile tablespace TS_USERS_BLOB
  datafile
  '/unam/bda/proyecto-final/d14/TS_USERS_BLOB01.dbf' size 1g
  extent management local autoallocate;

----- TS_USERS_INDEX
-- UIDX_USER_USERNAME, UIDX_USER_EMAIL
create tablespace TS_USERS_INDEX
  datafile 
  '/unam/bda/proyecto-final/d11/TS_USERS_INDEX01.dbf' size 100m,
  '/unam/bda/proyecto-final/d12/TS_USERS_INDEX02.dbf' size 100m
  autoextend on next 50m maxsize 200m
  extent management local autoallocate
  segment space management auto;

----- TS_PAYMENTS_DATA
-- BANK, CARD, DEALER_BANK_DATA, PROVIDER_BANK_DATA
create tablespace TS_PAYMENTS_DATA
  datafile 
  '/unam/bda/proyecto-final/d11/TS_PAYMENTS_DATA01.dbf' size 100m,
  '/unam/bda/proyecto-final/d12/TS_PAYMENTS_DATA02.dbf' size 100m,
  '/unam/bda/proyecto-final/d13/TS_PAYMENTS_DATA03.dbf' size 100m
  autoextend on next 50m maxsize 300m
  extent management local autoallocate
  segment space management auto;

----- TS_PAYMENTS_INDEX
-- IDX_CARD_CLIENT_ID, IDX_DEALER_BANK_DEALER_ID, IDX_DEALER_PAYMENT_DEALER_ID, IDX_DEALER_PAYMENT_DATE
-- IDX_PROVIDER_BANK_DATA_PROVIDER_ID, IDX_PROVIDER_PAYMENT_USER_ID, IDX_PROVIDER_PAYMENT_DATE
create tablespace TS_PAYMENTS_INDEX
  datafile 
  '/unam/bda/proyecto-final/d11/TS_PAYMENTS_INDEX01.dbf' size 50m,
  '/unam/bda/proyecto-final/d12/TS_PAYMENTS_INDEX02.dbf' size 50m
  autoextend on next 25m maxsize 100m
  extent management local autoallocate
  segment space management auto;

----- TS_PAYMENTS_HISTORY
-- DEALER_PAYMENT, PROVIDER_PAYMENT
create tablespace TS_PAYMENTS_HISTORY
  datafile 
  '/unam/bda/proyecto-final/d11/TS_PAYMENTS_HISTORY01.dbf' size 100m,
  '/unam/bda/proyecto-final/d12/TS_PAYMENTS_HISTORY02.dbf' size 100m,
  '/unam/bda/proyecto-final/d13/TS_PAYMENTS_HISTORY03.dbf' size 100m
  autoextend on next 50m maxsize 300m
  extent management local autoallocate
  segment space management auto;

----- TS_LOCATION_DATA
-- LOCATION_LOG
create tablespace TS_LOCATION_DATA
  datafile 
  '/unam/bda/proyecto-final/d11/TS_LOCATION_DATA01.dbf' size 100m,
  '/unam/bda/proyecto-final/d12/TS_LOCATION_DATA02.dbf' size 100m
  autoextend on next 50m maxsize 400m
  extent management local autoallocate
  segment space management auto;

----- TS_LOCATION_INDEX
-- IDX_LOCATION_LOG_USER_ID, IDX_LOCATION_LOG_TIMESTAMP
create tablespace TS_LOCATION_INDEX
  datafile 
  '/unam/bda/proyecto-final/d11/TS_LOCATION_INDEX01.dbf' size 50m
  autoextend on next 10m maxsize 100m
  extent management local autoallocate
  segment space management auto;

----------------------------------- Modulo 2. Proveedores y Servicios -----------------------------------
alter session set container = naproynu_modulo_2;

----- TS_DISH_DATA
-- DISH, DISH_PRICE_HISTORY, DISH_REVIEW, DISH_TYPE
create tablespace TS_DISH_DATA
  datafile 
  '/unam/bda/proyecto-final/d15/TS_DISH_DATA01.dbf' size 100m,
  '/unam/bda/proyecto-final/d16/TS_DISH_DATA02.dbf' size 100m,
  '/unam/bda/proyecto-final/d17/TS_DISH_DATA03.dbf' size 100m
  autoextend on next 50m maxsize 300m
  extent management local autoallocate
  segment space management auto;

----- TS_DISH_BLOB
-- DISH_GALLERY
-- DISH_VIDEO 
create bigfile tablespace TS_DISH_BLOB
  datafile
  '/unam/bda/proyecto-final/d18/TS_DISH_BLOB01.dbf' size 1g
  extent management local autoallocate;

----- TS_DISH_INDEX
-- IDX_DISH_PROVIDER_USER_ID, IDX_DISH_TYPE_CATEGORY, IDX_DISH_CALORIES, IDX_DISH_GALLERY_DISH_ID
-- IDX_DISH_PRICE_HISTORY_DISH_ID, IDX_DISH_REVIEW_DISH_ID, IDX_DISH_REVIEW_USER_ID
create tablespace TS_DISH_INDEX
  datafile 
  '/unam/bda/proyecto-final/d15/TS_DISH_INDEX01.dbf' size 50m
  autoextend on next 10m maxsize 100m
  extent management local autoallocate
  segment space management auto;

----- TS_ORDERS_DATA
-- ORDER, ORDER_DISH, ORDER_REVIEW, ORDER_STATUS, ORDER_STATUS_HISTORY
create tablespace TS_ORDERS_DATA
  datafile 
  '/unam/bda/proyecto-final/d15/TS_ORDERS_DATA01.dbf' size 100m,
  '/unam/bda/proyecto-final/d16/TS_ORDERS_DATA02.dbf' size 100m,
  '/unam/bda/proyecto-final/d17/TS_ORDERS_DATA03.dbf' size 100m
  autoextend on next 50m maxsize 300m
  extent management local autoallocate
  segment space management auto;

----- TS_ORDERS_BLOB
-- ORDER_DIG_SIGNATURE
create bigfile tablespace TS_ORDERS_BLOB
  datafile
  '/unam/bda/proyecto-final/d19/TS_ORDERS_BLOB01.dbf' size 1000m
  extent management local autoallocate;

----- TS_ORDERS_INDEX
-- IDX_ORDER_CLIENT_ID, IDX_ORDER_DEALER_ID, IDX_ORDER_CLIENT_STATUS, IDX_ORDER_DATE
-- IDX_ORDER_AMOUNT, IDX_ORDER_DISH_QUANTITY, IDX_ORDER_DISH_DISH_ID, IDX_ORDER_STATUS_HISTORY_ORDER_ID
-- IDX_ORDER_STATUS_HISTORY_STATUS_ID, IDX_ORDER_STATUS_HISTORY_DATE
create tablespace TS_ORDERS_INDEX
  datafile 
  '/unam/bda/proyecto-final/d15/TS_ORDERS_INDEX01.dbf' size 50m
  autoextend on next 10m maxsize 100m
  extent management local autoallocate
  segment space management auto;