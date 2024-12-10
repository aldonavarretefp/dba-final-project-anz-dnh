connect sys/system1 as sysdba

whenever sqlerror exit rollback
set serveroutput on

----------------------------------- Modulo 2. Órdenes y platos -----------------------------------
alter session set container = naproynu_modulo_2;
connect usermod2/usermod2@naproynu_modulo_2 

insert into DISH_TYPE (DISH_TYPE_ID, DISH_TYPE_TYPE) values (1, 'ENTRY');
insert into DISH_TYPE (DISH_TYPE_ID, DISH_TYPE_TYPE) values (2, 'SOUP');
insert into DISH_TYPE (DISH_TYPE_ID, DISH_TYPE_TYPE) values (3, 'STRONG_MEAL');
insert into DISH_TYPE (DISH_TYPE_ID, DISH_TYPE_TYPE) values (4, 'DESSERT');
insert into DISH_TYPE (DISH_TYPE_ID, DISH_TYPE_TYPE) values (5, 'DRINK');
