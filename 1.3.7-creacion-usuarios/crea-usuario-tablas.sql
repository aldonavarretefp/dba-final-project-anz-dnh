--@Autor: Aldo Yael Navarrete Zamora, Diego Ignacio Núñez Hernández
--@Fecha creación:  08/12/2024
--@Descripción:     Crea un usuario para crear las tablas del proyecto

connect sys/system1 as sysdba

whenever sqlerror exit rollback
set serveroutput on

----------------------------------- Modulo 1. Usuarios y Transacciones -----------------------------------
alter session set container = naproynu_modulo_1;

Prompt 1. Creando usuario USERMOD1
drop user usermod1 cascade;
create user usermod1 identified by usermod1 quota unlimited on users;

alter user usermod1 quota unlimited on TS_USERS_DATA;
alter user usermod1 quota unlimited on TS_USERS_BLOB;
alter user usermod1 quota unlimited on TS_USERS_INDEX;
alter user usermod1 quota unlimited on TS_PAYMENTS_DATA;
alter user usermod1 quota unlimited on TS_PAYMENTS_INDEX;
alter user usermod1 quota unlimited on TS_PAYMENTS_HISTORY;
alter user usermod1 quota unlimited on TS_LOCATION_DATA;
alter user usermod1 quota unlimited on TS_LOCATION_INDEX;

alter user usermod1 default tablespace users;

grant create session, create table, create procedure, create sequence to usermod1;

----------------------------------- Modulo 2. Proveedores y Servicios -----------------------------------
alter session set container = naproynu_modulo_2;

Prompt 2. Creando usuario USERMOD2
drop user usermod2 cascade;
create user usermod2 identified by usermod2 quota unlimited on users;

alter user usermod2 quota unlimited on TS_DISH_DATA;
alter user usermod2 quota unlimited on TS_DISH_BLOB;
alter user usermod2 quota unlimited on TS_DISH_INDEX;
alter user usermod2 quota unlimited on TS_ORDERS_DATA;
alter user usermod2 quota unlimited on TS_ORDERS_BLOB;
alter user usermod2 quota unlimited on TS_ORDERS_INDEX;

alter user usermod2 default tablespace users;

grant create session, create table, create procedure, create sequence to usermod2;