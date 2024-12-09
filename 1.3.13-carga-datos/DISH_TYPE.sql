connect sys/system1 as sysdba

whenever sqlerror exit rollback
set serveroutput on

----------------------------------- Modulo 2. Órdenes y platos -----------------------------------
alter session set container = naproynu_modulo_2;
connect usermod2/usermod2 

insert into DISH_TYPE (DISH_TYPE_ID, DISH_TYPE_TYPE) values (1, 'entradas');
insert into DISH_TYPE (DISH_TYPE_ID, DISH_TYPE_TYPE) values (2, 'sopas');
insert into DISH_TYPE (DISH_TYPE_ID, DISH_TYPE_TYPE) values (3, 'platos fuertes');
insert into DISH_TYPE (DISH_TYPE_ID, DISH_TYPE_TYPE) values (4, 'postres');
insert into DISH_TYPE (DISH_TYPE_ID, DISH_TYPE_TYPE) values (5, 'bebidas');
