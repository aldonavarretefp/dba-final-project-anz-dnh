connect sys/system1 as sysdba

whenever sqlerror exit rollback
set serveroutput on

----------------------------------- Modulo 2. Órdenes y platos -----------------------------------
alter session set container = naproynu_modulo_2;
connect usermod2/usermod2@naproynu_modulo_2 

insert into ORDER_STATUS (ORDER_REVIEW_ID, ORDER_STATUS) values (1, 'REGISTERED');
insert into ORDER_STATUS (ORDER_REVIEW_ID, ORDER_STATUS) values (2, 'PAID');
insert into ORDER_STATUS (ORDER_REVIEW_ID, ORDER_STATUS) values (3, 'IN_PROCESS');
insert into ORDER_STATUS (ORDER_REVIEW_ID, ORDER_STATUS) values (4, 'SENT_TO_DEALER');
insert into ORDER_STATUS (ORDER_REVIEW_ID, ORDER_STATUS) values (5, 'DELIVERED');
insert into ORDER_STATUS (ORDER_REVIEW_ID, ORDER_STATUS) values (6, 'CANCELED');
insert into ORDER_STATUS (ORDER_REVIEW_ID, ORDER_STATUS) values (7, 'REJECTED');
