--@Autor:   Borboa Castillo Carlos Alfonso, Ortiz Rivera Miguel Angel
--@Fecha creación:  04/06/2024
--@Descripción:     Crea tablespaces del la BD de proyecto final

Prompt Creando tablespaces para el proyecto final HOUSE SERVICES!

Prompt conectando como sysdba
connect sys/system as sysdba


--------------------------------MODULO 1---------------------
--cliente, empresa, persona    ------> Espacio máximo 1200 mb -> 1.1719 GB
create tablespace clientes_tbs
  datafile 
  '/unam-bda/d13/clientes01.dbf' size 300m,
  '/unam-bda/d14/clientes02.dbf' size 300m,
  '/unam-bda/d15/clientes03.dbf' size 300m
  autoextend on next 10m maxsize 400m
  extent management local autoallocate
  segment space management auto;

--status_servicio, historico_status_servicio,   ----> 5000 Servicios por día 
--servicio, servicio_aceptado, evaluacion_servicio ------> Espacio máximo 1500 mb -> 1.46 GB
create tablespace servicio_tbs
  datafile 
  '/unam-bda/d16/servicio01.dbf' size 400m,
  '/unam-bda/d17/servicio02.dbf' size 400m,
  '/unam-bda/d18/servicio03.dbf' size 400m
  autoextend on next 10m maxsize 500m
  extent management local autoallocate
  segment space management auto;

--tarjeta_cliente, pago_servicio ------> Espacio máximo 1200 mb -> 1.1719 GB
create tablespace datos_bancarios_clientes_tbs
  datafile 
  '/unam-bda/d13/datos_bancarios_clientes01.dbf' size 300m,
  '/unam-bda/d14/datos_bancarios_clientes02.dbf' size 300m,
  '/unam-bda/d15/datos_bancarios_clientes03.dbf' size 300m
  autoextend on next 10m maxsize 400m
  extent management local autoallocate
  segment space management auto;

-----------------TABLESPACES BIG PARA DATOS BLOB   --> 900 mb  --> 0.8789 GB  (3 CAMPOS BLOB)
create bigfile tablespace datos_blob_clientes_tbs
  datafile
  '/unam-bda/d19/datos_blob_clientes.dbf' size 900m
  extent management local autoallocate;
--proporciona una forma eficiente y automática de gestionar el espacio en un tablespace, 
--permitiendo que Oracle se encargue de asignar el tamaño de las extensiones según las
--necesidades de la base de datos. 

--INDICES PARA PKS Y FKS DE CLIENTES     ------> Espacio máximo 400 mb -> 0.3906 GB
create tablespace indexes_clientes_tbs
  datafile 
  '/unam-bda/d16/indexes_clientes01.dbf' size 100m,
  '/unam-bda/d17/indexes_clientes02.dbf' size 100m
  autoextend on next 10m maxsize 200m
  extent management local autoallocate
  segment space management auto;

--------------------------------MODULO 2---------------------------
--proveedor, nivel_estudio, lugar_nacimiento, email,
--tipo_status_proveedor, historico_status_proveedor   ------> Espacio máximo 1200 mb -> 1.1719 GB
create tablespace proveedores_inf_tbs
  datafile 
  '/unam-bda/d20/proveedores_inf01.dbf' size 300m,
  '/unam-bda/d21/proveedores_inf02.dbf' size 300m,
  '/unam-bda/d22/proveedores_inf03.dbf' size 300m
  autoextend on next 10m maxsize 400m
  extent management local autoallocate
  segment space management auto;

--documento_proveedor, proveedor_servicio, tipo_servicio, comprobante, servicio_evidencia, 
--servicio_imagen                                     ------> Espacio máximo 1200 mb -> 1.1719 GB
create tablespace proveedores_doc_tbs
  datafile 
  '/unam-bda/d20/proveedores_doc01.dbf' size 300m,
  '/unam-bda/d21/proveedores_doc02.dbf' size 300m,
  '/unam-bda/d22/proveedores_doc03.dbf' size 300m
  autoextend on next 10m maxsize 400m
  extent management local autoallocate
  segment space management auto;

--cuenta_bancaria_proveedor, proveedor_deposito ------> Espacio máximo 800 mb -> 0.78125 GB
create tablespace datos_bancarios_proveedor_tbs
  datafile
  '/unam-bda/d23/datos_bancarios_proveedor01.dbf' size 300m,
  '/unam-bda/d24/datos_bancarios_proveedor02.dbf' size 300m
  autoextend on next 10m maxsize 400m
  extent management local autoallocate
  segment space management auto;

-----------------TABLESPACES BIG PARA DATOS BLOB --> 900 mb  --> 0.8789 GB  (6 CAMPOS BLOB)
create bigfile tablespace datos_blob_proveedores_tbs
  datafile
  '/unam-bda/d25/datos_blob_proveedores.dbf' size 900m
  extent management local autoallocate;

--INDICES PARA PKS Y FKS DE PROVEEDORES  ------> Espacio máximo 400 mb -> 0.3906 GB
create tablespace indexes_proveedores_tbs
  datafile 
  '/unam-bda/d23/indexes_proveedores01.dbf' size 100m,
  '/unam-bda/d24/indexes_proveedores02.dbf' size 100m
  autoextend on next 10m maxsize 200m
  extent management local autoallocate
  segment space management auto;

Prompt listo!

-------------------------------------------------------------->  9.4678 GB -> 10 GB
