--@Autor:   Borboa Castillo Carlos Alfonso, Ortiz Rivera Miguel Angel
--@Fecha creación:  04/06/2024
--@Descripción:  Crea un usuario para crear las tablas del proyecto

Prompt proporcione el password del usuario sys
connect sys/system as sysdba

whenever sqlerror exit rollback

--permite la salida de mensajes a consula empleabo dbms_output.put_line
set serveroutput on

Prompt 1. Eliminando al usuario si existe.
declare 
    v_count number(1,0);
begin
    select count(*) into v_count
    from dba_users
    where username = 'BOORPROY';
    if v_count > 0 then
        dbms_output.put_line('Eliminando usuario existente');
        execute immediate 'drop user BOORPROY cascade';
    end if;     
end;
/

Prompt 2. creando al usuario

create user boorproy identified by boorproy;

alter user boorproy quota unlimited on clientes_tbs;
alter user boorproy quota unlimited on datos_bancarios_clientes_tbs;
alter user boorproy quota unlimited on indexes_clientes_tbs;
alter user boorproy quota unlimited on proveedores_inf_tbs;
alter user boorproy quota unlimited on proveedores_doc_tbs;
alter user boorproy quota unlimited on indexes_proveedores_tbs;
alter user boorproy quota unlimited on datos_blob_clientes_tbs;
alter user boorproy quota unlimited on datos_blob_proveedores_tbs;
alter user boorproy quota unlimited on datos_bancarios_proveedor_tbs;
alter user boorproy quota unlimited on servicio_tbs;

alter user boorproy default tablespace users;

grant create session, create table, create procedure, create sequence to boorproy;