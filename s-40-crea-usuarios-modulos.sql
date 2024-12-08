--@Autor:   Borboa Castillo Carlos Alfonso, Ortiz Rivera Miguel Angel
--@Fecha creación:  07/06/2024
--@Descripción:  Crea usuarios para los módulos 

Prompt proporcione el password del usuario sys
connect sys/system as sysdba

whenever sqlerror exit rollback

--permite la salida de mensajes a consula empleabo dbms_output.put_line
set serveroutput on
set linesize window

--------------------------------MODULO 1-------------------------------
Prompt 1. Eliminando al usuario MODCLIENTE si existe.
declare 
    v_count number(1,0);
begin
    select count(*) into v_count
    from dba_users
    where username = 'MODCLIENTE';
    if v_count > 0 then
        dbms_output.put_line('Eliminando usuario existente');
        execute immediate 'drop user MODCLIENTE cascade';
    end if;     
end;
/

Prompt 2. Creando al usuario MODCLIENTE

create user modcliente identified by modcliente quota unlimited on users;

alter user modcliente quota unlimited on clientes_tbs;
alter user modcliente quota unlimited on servicio_tbs;
alter user modcliente quota unlimited on datos_bancarios_clientes_tbs;
alter user modcliente quota unlimited on datos_blob_clientes_tbs;
alter user modcliente quota unlimited on indexes_clientes_tbs;

alter user modcliente default tablespace users;

grant create session, create table, create procedure, create sequence to modcliente;

grant insert, select on boorproy.cliente to modcliente;
grant insert, select on boorproy.status_servicio to modcliente;
grant insert, select on boorproy.empresa to modcliente;
grant insert, select on boorproy.persona to modcliente;
grant insert, select on boorproy.servicio to modcliente;
grant insert, select on boorproy.servicio_aceptado to modcliente;
grant insert, select on boorproy.historico_status_servicio to modcliente;
grant insert, select on boorproy.tarjeta_cliente to modcliente;
grant insert, select on boorproy.pago_servicio to modcliente;
grant insert, select on boorproy.evaluacion_servicio to modcliente;


----------------------------------------MODULO 2-------------------------------------
Prompt 1. Eliminando al usuario MODPROVEEDOR si existe.
declare 
    v_count number(1,0);
begin
    select count(*) into v_count
    from dba_users
    where username = 'MODPROVEEDOR';
    if v_count > 0 then
        dbms_output.put_line('Eliminando usuario existente');
        execute immediate 'drop user MODPROVEEDOR cascade';
    end if;     
end;
/

Prompt 2. Creando al usuario MODPROVEEDOR

create user modproveedor identified by modproveedor quota unlimited on users;

alter user modproveedor quota unlimited on proveedores_inf_tbs;
alter user modproveedor quota unlimited on proveedores_doc_tbs;
alter user modproveedor quota unlimited on datos_bancarios_proveedor_tbs;
alter user modproveedor quota unlimited on datos_blob_proveedores_tbs;
alter user modproveedor quota unlimited on indexes_proveedores_tbs;

alter user modproveedor default tablespace users;

grant create session, create table, create procedure, create sequence to modproveedor;

grant insert, select on boorproy.tipo_servicio to modproveedor;
grant insert, select on boorproy.nivel_estudio to modproveedor;
grant insert, select on boorproy.tipo_status_proveedor to modproveedor;
grant insert, select on boorproy.lugar_nacimiento to modproveedor;
grant insert, select on boorproy.proveedor to modproveedor;
grant insert, select on boorproy.proveedor_servicio to modproveedor;
grant insert, select on boorproy.comprobante to modproveedor;
grant insert, select on boorproy.documento_proveedor to modproveedor;
grant insert, select on boorproy.email to modproveedor;
grant insert, select on boorproy.historico_status_proveedor to modproveedor;
grant insert, select on boorproy.proveedor_deposito to modproveedor;
grant insert, select on boorproy.servicio_evidencia to modproveedor;
grant insert, select on boorproy.servicio_imagen to modproveedor;
grant insert, select on boorproy.cuenta_bancaria_proveedor to modproveedor;

------------------------------------USUARIO PARA RESPALDOS------------------------------
Prompt 1. Eliminando al usuario RESPALDOS si existe.
declare 
    v_count number(1,0);
begin
    select count(*) into v_count
    from dba_users
    where username = 'RESPALDOS';
    if v_count > 0 then
        dbms_output.put_line('Eliminando usuario existente');
        execute immediate 'drop user RESPALDOS cascade';
    end if;     
end;
/

Prompt 2. Creando al usuario RESPALDOS

create user respaldos identified by respaldos quota unlimited on users;

alter user respaldos default tablespace users;

grant create session to respaldos;

grant sysdba, sysbackup to respaldos;


/*
Prompt 3. Consultando privilegios del usuarios MODPROVEEDOR:
select privilege,admin_option 
from user_sys_privs;*/

