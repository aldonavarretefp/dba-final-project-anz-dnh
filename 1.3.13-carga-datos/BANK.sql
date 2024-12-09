connect sys/system1 as sysdba

whenever sqlerror exit rollback
set serveroutput on

----------------------------------- Modulo 1. Usuarios y Transacciones -----------------------------------
alter session set container = naproynu_modulo_1;
connect usermod1/usermod1 

insert into BANK (BANK_ID, BANK_NAME) values (1, 'Community Credit Union');
insert into BANK (BANK_ID, BANK_NAME) values (2, 'First National Bank');
insert into BANK (BANK_ID, BANK_NAME) values (3, 'City Bank,');
insert into BANK (BANK_ID, BANK_NAME) values (4, 'Regional Trust Bank');
insert into BANK (BANK_ID, BANK_NAME) values (5, 'Capital Savings and Loan');
insert into BANK (BANK_ID, BANK_NAME) values (6, 'Capital One');
