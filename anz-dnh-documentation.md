# Carátula

## Universidad Nacional Autónoma de México (UNAM)
- Facultad de Ingeniería
- División de Ingeniería Eléctrica
- Ingeniería en Computación

**Profesor:** Jorge Rodriguez Campos  
**Materia:** Bases de Datos Avanzadas  
**Alumnos:** Navarrete Zamora Aldo Yael, Nuñez Hernandez Diego Ignacio  
**Fecha:** `<fecha>`  
**Proyecto:** `<nombre-del-proyecto>`  
**Semestre:** 2025-1

<div style="page-break-after: always;"></div>

# Tabla de contenido

1. [Creación de la base de datos](#13-creación-de-la-base-de-datos)
  - [Configuraciones iniciales para crear la nueva base de datos](#132-configuraciones-iniciales-para-crear-la-nueva-base-de-datos)
  - [Módulos del sistema](#133-módulos-del-sistema)
  - [Esquemas por módulo](#134-esquemas-por-módulo)
  - [Esquema de indexado](#135-esquema-de-indexado)
  - [Diseño de tablespaces](#136-diseño-de-tablespaces)
    - [Tablespaces comunes](#1361-tablespaces-comunes)
    - [Tablespaces por módulo](#1362-tablespaces-por-módulo)
    - [Asignación de tablespace por objeto y módulo](#1363-asignación-de-tablespace-por-objeto-y-módulo)
  - [Generación del código DDL para el modelo relacional](#138-generación-del-código-ddl-para-el-modelo-relacional)
  - [Habilitar la FRA](#1310-habilitar-la-fra)
  - [Modo archivelog](#1311-modo-archivelog)
  - [Planeación del esquema de respaldos](#1312-planeación-del-esquema-de-respaldos)
  - [Simulación de la carga diaria](#1315-simulación-de-la-carga-diaria)

<div style="page-break-after: always;"></div>

## 1.3 Creación de la base de datos

- Comenzar con la creación de la base de datos una vez que se haya revisado y verificado el diseño lógico realizado en la sección anterior.
- Todas las configuraciones y código deberán ser guardados en scripts SQL o archivos shell. Emplear la notación `s-nn-<descripcion-corta>.sql` o `s-nn-<descripcion-corta>.sh`. `nn` se refiere al número de script iniciando en 01, `<descripcion-corta>` representa una cadena separada por guiones medios que indica una descripción corta en cuanto al propósito del script. Ejemplo: `s-01-creacion-bd.sql`
- Todos los scripts deberán contener su encabezado que incluye integrantes, fecha de creación, descripción del script.

El encabezado eligo es el siguiente para todos los scripts:
  
```sql
--@Autores: Navarrete Zamora Aldo Yael y Nuñez Hernandez Diego Ignacio
--@Fecha:   <fecha-de-creacion>
--@Descripción: <descripcion-del-script>
```

- El código deberá estar correctamente formateado.

- Una vez que el proyecto haya sido concluido, generar una tabla con el resumen de todos los scripts creados.

| Nombre del script                | Descripción                                |
|----------------------------------|--------------------------------------------|
| e-00-crea-contenedor.sh          | Creación del contenedor base Docker.       |
| e-01-crea-loop-devices-host-root.sh | Creación de dispositivos de loop en el host. |
| e-02-crea-pwdfile-oracle.sh      | Creación del archivo de contraseñas para Oracle. |
| e-03-crea-pfile-oracle.sh        | Creación del archivo PFILE con configuración básica. |
| e-04-crea-spfile-ordinario.sql   | Creación del archivo SPFILE a partir del PFILE. |
| e-05-crea-directorios-root.sh    | Configuración de directorios para data files y redo logs. |
| e-06-crea-bd-ordinario.sql       | Creación de la base de datos Oracle.       |
| e-07-crea-diccionario-datos-oracle.sh | Creación del diccionario de datos Oracle. |
| s-08-crea-pdb-ordinario.sql      | Creación de la base de datos pluggable (PDB). |

### 1.3.2. Configuraciones iniciales para crear la nueva base de datos
- Crear una nueva base de datos empleando como nombre `<iniciales>proy<iniciales>` (para nuestro caso, sería `naproynu`).
- Si el espacio en disco resulta ser un impedimento para crear esta nueva base de datos, eliminar la base de datos 1 creada al inicio del semestre. Se recomienda contar con 10 GB de espacio para evitar problemas durante el desarrollo del proyecto.

Proponer una configuración inicial y llenar la siguiente tabla:

| Configuración | Descripción y/o configuración |
|---------------|------------------------------|
| Número y ubicación de los archivos de control | Los archivos de control no deberían ubicarse en los mismos discos donde se encuentran los Redo Logs y data files. Es por eso que los decidimos poner (3) en `/unam/bda/proyecto-final/disk/d01/app/oracle/oradata/FREE/`|
| Propuesta de grupos de REDO | Un miembro de cada grupo deberá ubicarse en la FRA. No olvidar: Los data files no deberían ubicarse en los mismos discos donde se encuentran los Redo Logs y archivos de control. |
| Propuesta de juego de caracteres | El juego de caracteres será `AL32UTF8`. Debido a que se trata de un proyecto de base de datos para un sistema de pedidos de comida, es importante que se soporten caracteres especiales. |
| Tamaño del bloque de datos | Se recomienda emplear un tamaño de bloque de 8 KB. |
| Lista de parámetros que serán configurados al crear la base de datos | Especificar nombre y valor. |
| Archivo de passwords | Indicar los usuarios que contendrá este archivo de forma inicial. Como requisito indispensable, deberá existir un usuario diferente a `sys` que será el encargado de realizar la administración de backups. |

### 1.3.3. Módulos del sistema

Con base a los requerimientos y a las características del caso de estudio, proponer una división por módulos funcionales. La idea es que estos módulos puedan ser administrados de forma independiente, en especial sus estructuras físicas de almacenamiento. Los datos de cada módulo deberán ser almacenados en tablespaces separados para poder implementar esta independencia de administración. Cada módulo deberá contar con un usuario dueño de todos los objetos. Se recomienda crear solo 2 módulos. Llenar la siguiente tabla.

| Nombre del módulo | Descripción | Usuario |
| ----------------- | ----------- | ------- |
| Gestión de Usuarios y Transacciones | Contiene las tablas relacionadas con los usuarios (clientes, proveedores y repartidores) y sus transacciones. |         |
| Gestión de Órdenes y Platos | Contiene las tablas para órdenes y su relación con los platillos. |         |

### 1.3.4. Esquemas por módulo

Con base al modelo relacional realizado anteriormente realizar una distribución de los objetos considerando la propuesta de módulos realizada. Llenar la siguiente tabla.

| Nombre de la tabla | Nombre del módulo |
| ------------------ | ----------------- |
| USER | Gestión de Usuarios y Transacciones |
| CLIENT | Gestión de Usuarios y Transacciones | 
| DEALER | Gestión de Usuarios y Transacciones | 
| DEALER_BANK_DATA | Gestión de Usuarios y Transacciones | 
| DEALER_PAYMENT | Gestión de Usuarios y Transacciones | 
| LOCATION_LOG | Gestión de Usuarios y Transacciones | 
| PROVIDER | Gestión de Usuarios y Transacciones | 
| PROVIDER_BANK_DATA | Gestión de Usuarios y Transacciones | 
| PROVIDER_GALLERY | Gestión de Usuarios y Transacciones | 
| PROVIDER_PAYMENT | Gestión de Usuarios y Transacciones |
| BANK | Gestión de Usuarios y Transacciones |
| CARD | Gestión de Usuarios y Transacciones | 
| DISH | Gestión de Órdenes y Platos |
| DISH_GALLERY | Gestión de Órdenes y Platos |
| DISH_PRICE_HISTORY | Gestión de Órdenes y Platos |
| DISH_REVIEW | Gestión de Órdenes y Platos |
| DISH_TYPE | Gestión de Órdenes y Platos |
| ORDER | Gestión de Órdenes y Platos |
| ORDER_DISH | Gestión de Órdenes y Platos |
| ORDER_REVIEW | Gestión de Órdenes y Platos |
| ORDER_STATUS | Gestión de Órdenes y Platos |
| ORDER_STATUS_HISTORY | Gestión de Órdenes y Platos |

### 1.3.5. Esquema de indexado

Con base a las reglas de negocio del caso de estudio asignado generar una lista de índices que serían considerados como necesarios para implementar reglas de negocio que requieran valores únicos, o para mejorar desempeño. Por ejemplo, indexar FKs, índices basados en funciones, etc. Llenar la siguiente tabla


| Módulo | Nombre de la tabla | Nombre del índice | Tipo | Propósito |
|--------|--------------------|-------------------|------|-----------|
| Gestión de Usuarios y Transacciones | BANK | BANK_PK | UNIQUE | Garantizar unicidad de la PK (BANK_ID) |
| Gestión de Usuarios y Transacciones | USERVF | USER_PK | UNIQUE | PK de USERVF (USER_ID) |
| Gestión de Usuarios y Transacciones | USERVF | UIDX_USER_USERNAME | UNIQUE | Garantizar unicidad del nombre de usuario (USER_USERNAME) |
| Gestión de Usuarios y Transacciones | USERVF | UIDX_USER_EMAIL | UNIQUE | Garantizar unicidad del correo electrónico (USER_EMAIL) |
| Gestión de Usuarios y Transacciones | CLIENT | CLIENT_PK | UNIQUE | PK de CLIENT (CLIENT_USER_ID) |
| Gestión de Usuarios y Transacciones | CARD | CARD_PK | UNIQUE | PK de CARD (CARD_ID) |
| Gestión de Usuarios y Transacciones | CARD | IDX_CARD_CLIENT_ID | NON-UNIQUE | Mejorar desempeño en búsquedas por CLIENT_USER_ID |
| Gestión de Usuarios y Transacciones | DEALER | DEALER_PK | UNIQUE | PK de DEALER (DEALER_USER_ID) |
| Gestión de Usuarios y Transacciones | DEALER_BANK_DATA | DEALER_BANK_DATA_PK | UNIQUE | PK de DEALER_BANK_DATA (DEALER_BANK_DATA_ID) |
| Gestión de Usuarios y Transacciones | DEALER_BANK_DATA | IDX_DEALER_BANK_DEALER_ID | NON-UNIQUE | Mejorar búsqueda por DEALER (DEALER_BANK_DEALER_ID) |
| Gestión de Usuarios y Transacciones | DEALER_PAYMENT | DEALER_PAYMENT_PK | UNIQUE | PK de DEALER_PAYMENT (DEALER_PAYMENT_ID) |
| Gestión de Usuarios y Transacciones | DEALER_PAYMENT | IDX_DEALER_PAYMENT_DEALER_ID | NON-UNIQUE | Búsqueda de pagos por DEALER (DEALER_PAYMENT_DEALER_ID) |
| Gestión de Usuarios y Transacciones | DEALER_PAYMENT | IDX_DEALER_PAYMENT_DATE | NON-UNIQUE | Búsqueda de pagos por fecha (DEALER_PAYMENT_DATE) |
| Gestión de Usuarios y Transacciones | LOCATION_LOG | LOCATION_LOG_PK | UNIQUE | PK de LOCATION_LOG (LOCATION_LOG_ID) |
| Gestión de Usuarios y Transacciones | LOCATION_LOG | IDX_LOCATION_LOG_USER_ID | NON-UNIQUE | Filtrar logs por usuario (LOCATION_LOG_USER_ID) |
| Gestión de Usuarios y Transacciones | LOCATION_LOG | IDX_LOCATION_LOG_TIMESTAMP | NON-UNIQUE | Búsqueda por fecha/hora (LOCATION_LOG_TIMESTAMP) |
| Gestión de Usuarios y Transacciones | PROVIDER | PROVIDER_PK | UNIQUE | PK de PROVIDER (PROVIDER_USER_ID) |
| Gestión de Usuarios y Transacciones | PROVIDER_BANK_DATA | PROVIDER_BANK_DATA_PK | UNIQUE | PK de PROVIDER_BANK_DATA (PROVIDER_BANK_DATA_ID) |
| Gestión de Usuarios y Transacciones | PROVIDER_BANK_DATA | IDX_PROVIDER_BANK_DATA_PROVIDER_ID | NON-UNIQUE | Búsqueda por PROVIDER (PROVIDER_BANK_DATA_PROVIDER_ID) |
| Gestión de Usuarios y Transacciones | PROVIDER_GALLERY | PROVIDER_GALLERY_PK | UNIQUE | PK de PROVIDER_GALLERY (PROVIDER_GALLERY_ID) |
| Gestión de Usuarios y Transacciones | PROVIDER_GALLERY | IDX_PROVIDER_GALLERY_USER_ID | NON-UNIQUE | Búsqueda de galerías por PROVIDER (PROVIDER_GALLERY_USER_ID) |
| Gestión de Usuarios y Transacciones | PROVIDER_PAYMENT | PROVIDER_PAYMENT_PK | UNIQUE | PK de PROVIDER_PAYMENT (PROVIDER_PAYMENT_ID) |
| Gestión de Usuarios y Transacciones | PROVIDER_PAYMENT | IDX_PROVIDER_PAYMENT_USER_ID | NON-UNIQUE | Búsqueda de pagos por PROVIDER (PROVIDER_PAYMENT_USER_ID) |
| Gestión de Usuarios y Transacciones | PROVIDER_PAYMENT | IDX_PROVIDER_PAYMENT_DATE | NON-UNIQUE | Búsqueda de pagos por fecha (PROVIDER_PAYMENT_DATE) |
| Gestión de Órdenes y Platos | DISH_TYPE | DISH_TYPE_PK | UNIQUE | PK de DISH_TYPE (DISH_TYPE_ID) |
| Gestión de Órdenes y Platos | DISH | DISH_PK | UNIQUE | PK de DISH (DISH_ID) |
| Gestión de Órdenes y Platos | DISH | IDX_DISH_PROVIDER_USER_ID | NON-UNIQUE | Búsqueda de platos por proveedor (DISH_PROVIDER_USER_ID) |
| Gestión de Órdenes y Platos | DISH | IDX_DISH_TYPE_CATEGORY | NON-UNIQUE | Búsqueda por tipo y categoría (DISH_TYPE_ID, DISH_CATEGORY) |
| Gestión de Órdenes y Platos | DISH | IDX_DISH_CALORIES | NON-UNIQUE | Búsqueda por calorías (DISH_CALORIES) |
| Gestión de Órdenes y Platos | DISH_GALLERY | DISH_GALLERY_PK | UNIQUE | PK de DISH_GALLERY (DISH_GALLERY_ID) |
| Gestión de Órdenes y Platos | DISH_GALLERY | IDX_DISH_GALLERY_DISH_ID | NON-UNIQUE | Búsqueda de galerías por plato (DISH_GALLERY_DISH_ID) |
| Gestión de Órdenes y Platos | DISH_PRICE_HISTORY | DISH_PRICE_HISTORY_PK | UNIQUE | PK de DISH_PRICE_HISTORY (DISH_PRICE_HISTORY_ID) |
| Gestión de Órdenes y Platos | DISH_PRICE_HISTORY | IDX_DISH_PRICE_HISTORY_DISH_ID | NON-UNIQUE | Histórico de precios por plato (DISH_PRICE_HISTORY_DISH_ID) |
| Gestión de Órdenes y Platos | DISH_REVIEW | DISH_REVIEW_PK | UNIQUE | PK de DISH_REVIEW (DISH_REVIEW_ID) |
| Gestión de Órdenes y Platos | DISH_REVIEW | IDX_DISH_REVIEW_DISH_ID | NON-UNIQUE | Búsqueda de reseñas por plato (DISH_REVIEW_DISH_ID) |
| Gestión de Órdenes y Platos | DISH_REVIEW | IDX_DISH_REVIEW_USER_ID | NON-UNIQUE | Búsqueda de reseñas por usuario (DISH_REVIEW_USER_ID) |
| Gestión de Órdenes y Platos | ORDER_STATUS | ORDER_STATUS_PK | UNIQUE | PK de ORDER_STATUS (ORDER_STATUS_ID) |
| Gestión de Órdenes y Platos | ORDERVF (ORDER) | ORDER_PK | UNIQUE | PK de ORDERVF (ORDER_ID) |
| Gestión de Órdenes y Platos | ORDERVF (ORDER) | IDX_ORDER_CLIENT_ID | NON-UNIQUE | Búsqueda de órdenes por cliente (ORDER_CLIENT_ID) |
| Gestión de Órdenes y Platos | ORDERVF (ORDER) | IDX_ORDER_DEALER_ID | NON-UNIQUE | Búsqueda de órdenes por dealer (ORDER_DEALER_ID) |
| Gestión de Órdenes y Platos | ORDERVF (ORDER) | IDX_ORDER_CLIENT_STATUS | NON-UNIQUE | Búsqueda combinada por cliente y status (ORDER_CLIENT_ID, ORDER_STATUS_ID) |
| Gestión de Órdenes y Platos | ORDERVF (ORDER) | IDX_ORDER_DATE | NON-UNIQUE | Búsqueda por fecha de orden (ORDER_DATE) |
| Gestión de Órdenes y Platos | ORDERVF (ORDER) | IDX_ORDER_AMOUNT | NON-UNIQUE | Búsqueda por monto de orden (ORDER_AMOUNT) |
| Gestión de Órdenes y Platos | ORDER_DISH | ORDER_DISH_PK | UNIQUE | PK de ORDER_DISH (ORDER_DISH_ID) |
| Gestión de Órdenes y Platos | ORDER_DISH | IDX_ORDER_DISH_DISH_ID | NON-UNIQUE | Búsqueda por plato en la orden (ORDER_DISH_DISH_ID) |
| Gestión de Órdenes y Platos | ORDER_DISH | IDX_ORDER_DISH_QUANTITY | NON-UNIQUE | Búsqueda por cantidad (ORDER_DISH_QUANTITY) |
| Gestión de Órdenes y Platos | ORDER_REVIEW | ORDER_REVIEW_PK | UNIQUE | PK de ORDER_REVIEW (ORDER_REVIEW_ID) |
| Gestión de Órdenes y Platos | ORDER_STATUS_HISTORY | ORDER_STATUS_HISTORY_PK | UNIQUE | PK de ORDER_STATUS_HISTORY (ORDER_STATUS_HISTORY_ID) |
| Gestión de Órdenes y Platos | ORDER_STATUS_HISTORY | IDX_ORDER_STATUS_HISTORY_ORDER_ID | NON-UNIQUE | Búsqueda de historial por orden (ORDER_STATUS_HISTORY_ORDER_ID) |
| Gestión de Órdenes y Platos | ORDER_STATUS_HISTORY | IDX_ORDER_STATUS_HISTORY_STATUS_ID | NON-UNIQUE | Búsqueda de historial por status (ORDER_STATUS_HISTORY_STATUS_ID) |
| Gestión de Órdenes y Platos | ORDER_STATUS_HISTORY | IDX_ORDER_STATUS_HISTORY_DATE | NON-UNIQUE | Búsqueda por fecha de cambio de estado (ORDER_STATUS_HISTORY_DATE) |
 
### 1.3.6. Diseño de tablespaces

Con base a los requerimientos del caso de estudio, proponer un diseño físico en el que se describen los tablespaces que serán creados para soportar la operación de la base de datos para cada uno de los módulos. 

- Considerar el almacenamiento de objetos CLOB, BLOB en discos diferentes. Considerar el uso de Big File tablespaces.
- Realizar un análisis y determinar las tablas que pudieran tener una gran cantidad de registros con el paso del tiempo, proponer un esquema simple de particionamiento. Considerar almacenar los datos de cada partición en un disco diferente.
- Considerar el almacenamiento de los índices en un tablespace separado.
- No olvidar que la distribución propuesta debe cuidar en todo momento que si los tablespaces de un módulo se detienen o fallan, el otro módulo debería seguir operando sin mayor problema.
- Tener presente y procurar en todo momento evitar posibles problemas de contención, por ejemplo, considerar crear tablespaces con más de un data file donde cada archivo se almacena en discos diferentes.

En esta tabla se documentan los tablespaces comunes a los módulos.

#### 1.3.6.1 Tablespaces comunes



| Nombre del tablespace | Configuración |
|-----------------------|---------------|
|                       |Especificar: Big File o múltiple data files, tamaño, tipo de administración de segmentos y extensiones, ubicación de sus data files.         |

| Nombre del tablespace | Configuración |
|-----------------------|---------------|
| SYSTEM                | Ubicación: Por defecto en el directorio de instalación de la BD, ej: `/u01/app/oracle/oradata/naproynu_pdb/system01.dbf`. Tamaño y configuración definidos al crear la BD. Extent Management Local, Segment Space Management Auto. |
| SYSAUX                | Ubicación: Por defecto, por ejemplo: `/u01/app/oracle/oradata/naproynu_pdb/sysaux01.dbf`. Configuración similar a SYSTEM. |
| UNDO                  | Ubicación: `/u01/app/oracle/oradata/naproynu_pdb/undotbs01.dbf`. Local autoallocate, Autoextend On, utilizado para transacciones. |
| TEMP                  | Ubicación: `/u01/app/oracle/oradata/naproynu_pdb/temp01.dbf`. Temporary tablespace. Autoextend On según configuración base. |

#### 1.3.6.2 Tablespaces por módulo

| Módulo | Nombre del tablespace | Objetivo / Beneficio | Configuración |
|--------|------------------------|----------------------|--------------|
| Gestión de Usuarios y Transacciones | TS_USERS_DATA          | Almacenar datos de usuario, cliente, dealer, provider, etc. | Rutas: `/unam/bda/proyecto-final/d11/TS_USERS_DATA01.dbf size 100M`, `/unam/bda/proyecto-final/d12/TS_USERS_DATA02.dbf size 100M`, `/unam/bda/proyecto-final/d13/TS_USERS_DATA03.dbf size 100M`. Autoextend on next 50M maxsize 500M, extent management local autoallocate, segment space management auto. |
| Gestión de Usuarios y Transacciones | TS_USERS_BLOB          | Almacenar BLOBs de usuarios y proveedores (fotos, logos). | Ruta: `/unam/bda/proyecto-final/d14/TS_USERS_BLOB01.dbf size 1G`. Bigfile tablespace, extent management local autoallocate. |
| Gestión de Usuarios y Transacciones | TS_USERS_INDEX         | Almacenar índices de tablas de usuarios.                  | Rutas: `/unam/bda/proyecto-final/d11/TS_USERS_INDEX01.dbf size 100M`, `/unam/bda/proyecto-final/d12/TS_USERS_INDEX02.dbf size 100M`. Autoextend on next 50M maxsize 200M. |
| Gestión de Usuarios y Transacciones | TS_PAYMENTS_DATA       | Almacenar datos de pagos, bancos, tarjetas, etc.          | Rutas: `/unam/bda/proyecto-final/d11/TS_PAYMENTS_DATA01.dbf size 100M`, `/unam/bda/proyecto-final/d12/TS_PAYMENTS_DATA02.dbf size 100M`, `/unam/bda/proyecto-final/d13/TS_PAYMENTS_DATA03.dbf size 100M`. Autoextend on next 50M maxsize 300M. |
| Gestión de Usuarios y Transacciones | TS_PAYMENTS_INDEX      | Índices de tablas de pagos.                               | Rutas: `/unam/bda/proyecto-final/d11/TS_PAYMENTS_INDEX01.dbf size 50M`, `/unam/bda/proyecto-final/d12/TS_PAYMENTS_INDEX02.dbf size 50M`. Autoextend on next 25M maxsize 100M. |
| Gestión de Usuarios y Transacciones | TS_PAYMENTS_HISTORY    | Datos históricos de pagos.                                | Rutas: `/unam/bda/proyecto-final/d11/TS_PAYMENTS_HISTORY01.dbf size 100M`, `/unam/bda/proyecto-final/d12/TS_PAYMENTS_HISTORY02.dbf size 100M`, `/unam/bda/proyecto-final/d13/TS_PAYMENTS_HISTORY03.dbf size 100M`. Autoextend on next 50M maxsize 300M. |
| Gestión de Usuarios y Transacciones | TS_LOCATION_DATA       | Datos de localización (LOCATION_LOG).                     | Rutas: `/unam/bda/proyecto-final/d11/TS_LOCATION_DATA01.dbf size 100M`, `/unam/bda/proyecto-final/d12/TS_LOCATION_DATA02.dbf size 100M`. Autoextend on next 50M maxsize 400M. |
| Gestión de Usuarios y Transacciones | TS_LOCATION_INDEX      | Índices de LOCATION_LOG.                                  | Ruta: `/unam/bda/proyecto-final/d11/TS_LOCATION_INDEX01.dbf size 50M`. Autoextend on next 10M maxsize 100M. |
Módulo 2: Órdenes y Platos

Módulo	Nombre del tablespace	Objetivo / Beneficio	Configuración
| Módulo                      | Nombre del tablespace | Objetivo / Beneficio                          | Configuración                                                                                                           |
|-----------------------------|-----------------------|-----------------------------------------------|------------------------------------------------------------------------------------------------------------------------|
| Gestión de Órdenes y Platos | TS_DISH_DATA          | Datos de platos, tipos, historial, reseñas.   | Rutas: `/unam/bda/proyecto-final/d15/TS_DISH_DATA01.dbf size 100M`, `/unam/bda/proyecto-final/d16/TS_DISH_DATA02.dbf size 100M`, `/unam/bda/proyecto-final/d17/TS_DISH_DATA03.dbf size 100M`. Autoextend on next 50M maxsize 300M. |
| Gestión de Órdenes y Platos | TS_DISH_BLOB          | BLOBs de galerías de platos y videos. Bigfile.| Ruta: `/unam/bda/proyecto-final/d18/TS_DISH_BLOB01.dbf size 1G`. Bigfile, extent management local autoallocate.        |
| Gestión de Órdenes y Platos | TS_DISH_INDEX         | Índices de DISH y tablas relacionadas.        | Ruta: `/unam/bda/proyecto-final/d15/TS_DISH_INDEX01.dbf size 50M`. Autoextend on next 10M maxsize 100M.                |
| Gestión de Órdenes y Platos | TS_ORDERS_DATA        | Datos de órdenes, status, historial de órdenes.| Rutas: `/unam/bda/proyecto-final/d15/TS_ORDERS_DATA01.dbf size 100M`, `/unam/bda/proyecto-final/d16/TS_ORDERS_DATA02.dbf size 100M`, `/unam/bda/proyecto-final/d17/TS_ORDERS_DATA03.dbf size 100M`. Autoextend on next 50M maxsize 300M. |
| Gestión de Órdenes y Platos | TS_ORDERS_BLOB        | BLOB con firmas digitales de las órdenes. Bigfile.| Ruta: `/unam/bda/proyecto-final/d19/TS_ORDERS_BLOB01.dbf size 1000M`. Bigfile, extent management local autoallocate. |
| Gestión de Órdenes y Platos | TS_ORDERS_INDEX       | Índices para mejorar búsqueda en órdenes.     | Ruta: `/unam/bda/proyecto-final/d15/TS_ORDERS_INDEX01.dbf size 50M`. Autoextend on next 10M maxsize 100M.              |

#### 1.3.6.3. Asignación de tablespace por objeto y módulo

Con base al diseño de tablespaces propuesto, cada módulo estará formado por varios tablespaces. En cada módulo existirán segmentos de diferente tipo (tablas, índices, particiones, objetos blob/clob) que requieren la asignación de su correspondiente tablespace. En esta tabla se podrá realizar una propuesta de distribución de los diferentes segmentos empleando los tablespaces definidos anteriormente.

| Módulo | Tipo de segmento | Nombre del segmento | Nombre del tablespace |
|--------|------------------|---------------------|-----------------------|
|        |                  |                     |                       |
|        |                  |                     |                       |

Módulo 1: Gestión de Usuarios y Transacciones

Módulo	Tipo de segmento	Nombre del segmento (tabla/índice/objeto)	Nombre del tablespace
Gestión de Usuarios y Transacciones	Tabla (Datos)	USERVF, CLIENT, DEALER, PROVIDER, BANK, CARD, DEALER_BANK_DATA, PROVIDER_BANK_DATA	TS_USERS_DATA
Gestión de Usuarios y Transacciones	Tabla (Datos)	DEALER_PAYMENT, PROVIDER_PAYMENT (Históricos)	TS_PAYMENTS_HISTORY
Gestión de Usuarios y Transacciones	Tabla (Datos)	LOCATION_LOG	TS_LOCATION_DATA
Gestión de Usuarios y Transacciones	Índice	Índices de USERVF y CLIENT (ej. USER_PK, UIDX_USER_USERNAME, UIDX_USER_EMAIL, CLIENT_PK)	TS_USERS_INDEX
Gestión de Usuarios y Transacciones	Índice	Índices de DEALER, PROVIDER, BANK, CARD, DEALER_BANK_DATA, PROVIDER_BANK_DATA (ej. DEALER_PK, CARD_PK)	TS_USERS_INDEX
Gestión de Usuarios y Transacciones	Índice	Índices de pagos (ej. IDX_CARD_CLIENT_ID, IDX_DEALER_BANK_DEALER_ID, IDX_PROVIDER_BANK_DATA_PROVIDER_ID, IDX_PROVIDER_PAYMENT_DATE, etc.)	TS_PAYMENTS_INDEX
Gestión de Usuarios y Transacciones	Índice	Índices de ubicación (LOCATION_LOG) (ej. IDX_LOCATION_LOG_USER_ID, IDX_LOCATION_LOG_TIMESTAMP)	TS_LOCATION_INDEX
Gestión de Usuarios y Transacciones	BLOB	CLIENT_PHOTO, DEALER_PHOTO, DEALER_MOTORCYCLE_PHOTO, PROVIDER_LOGO, PROVIDER_GALLERY_PHOTO	TS_USERS_BLOB

### 1.3.8. Generación del código DDL para el modelo relacional

A partir del modelo relacional generado anteriormente, realizar las siguientes acciones en ER-Studio:

- Crear un nuevo modelo lógico por cada uno de los módulos propuestos anteriormente.
- Incluir en cada modelo lógico las tablas que le corresponden.
- Crear un modelo físico a partir del modelo lógico para Oracle a partir de cada uno de los módulos (modelos lógicos creados en el punto anterior).
- Los constraints deben ser creados como parte de la instrucción `CREATE TABLE`. Evitar el uso de `ALTER TABLE` para crear constraints.
- Emplear las siguientes convenciones para realizar el nombrado de los constraints. Si el nombre es demasiado largo, pueden aplicar algunas abreviaturas que sean lo más claras posible.

| Tipo de Constraint | Convención de nombrado |
|--------------------|------------------------|
| UNIQUE             | `<nombre_tabla>_<nombre_columna>_uk` |
| PRIMARY KEY        | `<nombre_tabla>_<nombre_columna>_pk` |
| FOREIGN KEY        | `<nombre_tabla_hija>_<nombre_columna>_fk` |
| CHECK              | `<nombre_tabla>_<nombre_columna>_<chk>` |

- Generar el código SQL empleando ER-Studio.
- Editar el script generado para realizar las asignaciones de tablespaces tanto de
tablas como para índices, PKs, índices tipo LOB.

### 1.3.9.Modos de conexión.
- Realizar las configuraciones necesarias de tal forma que un usuario pueda conectarse a la instancia ya sea en modo compartido o en modo dedicado o a través de un pool de conexiones. La configuración por defecto deberá ser modo dedicado.

Nuestros servicios son los siguientes descritos en `tnsnames.ora`:
```sql
NAPROYNU_MODULO_1
NAPROYNU_MODULO_1_SHARED
NAPROYNU_MODULO_1_DEDICATED
NAPROYNU_MODULO_1_POOLED
NAPROYNU_MODULO_2
NAPROYNU_MODULO_2_SHARED
NAPROYNU_MODULO_2_DEDICATED
NAPROYNU_MODULO_2_POOLED
```

### 1.3.10. Habilitar la FRA
- Habilitar la FRA, realizar un cálculo estimado de su tamaño con base a la cantidad de datos que se pretenden almacenar (ver siguientes secciones).

Cálculo del espacio requerido para la FRA 
TODO: Cálcular el espacio requerido para la FRA
$$ 
\displaystyle
\left( \sum_{k=1}^n a_k b_k \right)^2
\leq
\left( \sum_{k=1}^n a_k^2 \right)
\left( \sum_{k=1}^n b_k^2 \right)
$$


#### 1.3.11. Modo archivelog
- La ubicación propuesta para las dos ubicaciónes es
   - La ubicación del disco dedicado que es `/unam/bda/proyecto-final/archive-logs/FREE/disk_a`
   - FRA `/unam/bda/proyecto-final/fast-recovery-area`

- Tip: Los discos donde se almacene la copia que no está en la FRA debería ser
dedicado.
##### 1.3.12. Planeación del esquema de respaldos.
Diseñar la estrategia que se empleará para realizar los respaldos de la base de datos. Esta
estrategia deberá incluir:
**Requerimientos**
- Tipos de backups a realizar  
- Frecuencia de repetición
- Ubicaciones de respaldo (FRA)
- Política de retención de backups.
- Tamaño total en espacio en disco disponible para realizar backups.

**Propuesta**
- Por la naturaleza de las pdbs en las que estamos desarrollando el proyecto y se parece a un ambiente de Uber Eats, hemos propuesto realizar backups incrementales de las pdbs.
- Para la frecuencia de repetición hemos decidido realizar backups incrementales diarios de las pdbs. Esto con el fin de tener un respaldo diario de los datos que se generan en la base de datos.
- Para la ubicación de los respaldos hemos decidido almacenarlos en la FRA. Esto con el fin de tener un respaldo en caso de que se pierda la información de la base de datos.
- Para la política de retención de backups hemos decidido mantener los backups incrementales diarios por 7 días. Recordando que una política de retención de backups es aquella que define cuánto tiempo se mantendrán los backups en el sistema. Nosotros hemos decidido mantener los backups incrementales diarios por 7 días.
```sql
configure retention policy.
```
- Verificar los scripts en nuestras carpetas

#### 1.3.15. Simulación de la carga diaria

- Generar Scripts que simulen la generación de datos de REDO los cuales representarán la carga diaria de una base productiva. Se recomienda tomar como base los scripts proporcionados en temas anteriores. Como mínimo se deberán generar aproximadamente 30 MB de datos REDO. Este valor también deberá ser considerado para decidir el tamaño de los grupos de REDO al momento de crear la base de datos.
- Realizar algunos ciclos de generación de datos REDO, y posteriormente hacer respaldos para comprobar su correcto funcionamiento.
- Ejecutar los comandos necesarios para liberar espacio en disco considerando archivos obsoletos.
- Llenar la siguiente tabla:

##### Programación de respaldos

| Fecha y hora | Datos REDO producidos (MB) | Fecha de Respaldo | Tipo de backup | Espacio requerido por el backup |
|--------------|-----------------------------|-------------------|----------------|---------------------------------|
|              |                             |                   |                |                                 |

> 8.4.1.6.Respaldar archive redo logs
El siguiente comando realiza un respaldo completo de la base de datos, realiza switch de
los Redo logs e incluye los archived redo logs en el backup.
backup database plus archivelog;
8.4.1.7. Respaldar tablespaces
backup device type disk tablespace users, tools;
8.4.1.8.Respaldar datafiles
backup device type sbt datafile 1,2,3,4 datafilecopy'/tmp/system01.dbf';
8.4.1.9.Respaldar el archivo de control
En caso de que la configuración configure controlfile autobackup no esté habilitada, se
deben emplear alguna de las siguientes instrucciones para incluirlo en un backup.
backup current controlfile
backup device type sbt tablespace users include current controlfile;
backup as copy current controlfile format'/tmp/control01.ctl';
backup as copy current controlfile format'/tmp/control01.ctl';
backup device type sbt controlfilecopy'/tmp/control01.ctl';
8.4.1.10. backup device type sbt spfile;