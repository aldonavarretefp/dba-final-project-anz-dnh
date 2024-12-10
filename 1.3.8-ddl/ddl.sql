--@Autor: Aldo Yael Navarrete Zamora, Diego Ignacio Núñez Hernández
--@Fecha creación:  08/12/2024
--@Descripción:     Creación de tablas

connect sys/system1 as sysdba

whenever sqlerror exit rollback
set serveroutput on

----------------------------------- Modulo 1. Usuarios y Transacciones -----------------------------------
alter session set container = naproynu_modulo_1;
connect usermod1/usermod1@naproynu_modulo_1 

DROP TABLE IF EXISTS BANK CASCADE CONSTRAINT;
CREATE TABLE BANK (
    BANK_ID              NUMBER NOT NULL,
    BANK_NAME            VARCHAR2(20) NOT NULL,
    CONSTRAINT BANK_PK PRIMARY KEY (BANK_ID)
    USING INDEX (
        CREATE UNIQUE INDEX BANK_PK ON BANK (BANK_ID)
        TABLESPACE TS_PAYMENTS_INDEX
    )
) TABLESPACE TS_PAYMENTS_DATA;

DROP TABLE IF EXISTS USERVF CASCADE CONSTRAINT;
CREATE TABLE USERVF (
    USER_ID              NUMBER NOT NULL,
    USER_USERNAME        VARCHAR2(20) NOT NULL,
    USER_PASSWORD        VARCHAR2(20) NOT NULL,
    USER_EMAIL           VARCHAR2(20) NOT NULL,
    USER_IS_CLIENT       INTEGER NOT NULL,
    USER_IS_DEALER       INTEGER NOT NULL,
    USER_IS_PROVIDER     INTEGER NOT NULL,
    CONSTRAINT USER_PK PRIMARY KEY (USER_ID)
    USING INDEX (
        CREATE UNIQUE INDEX USER_PK ON USERVF (USER_ID)
        TABLESPACE TS_USERS_INDEX
    )
) TABLESPACE TS_USERS_DATA;

CREATE UNIQUE INDEX UIDX_USER_USERNAME ON USERVF (USER_USERNAME) TABLESPACE TS_USERS_INDEX;
CREATE UNIQUE INDEX UIDX_USER_EMAIL ON USERVF (USER_EMAIL) TABLESPACE TS_USERS_INDEX;

DROP TABLE IF EXISTS CLIENT CASCADE CONSTRAINT;
CREATE TABLE CLIENT (
    CLIENT_USER_ID       NUMBER NOT NULL,
    CLIENT_NAME          VARCHAR2(20) NOT NULL,
    CLIENT_LASTNAME      VARCHAR2(20) NOT NULL,
    CLIENT_PHOTO         BLOB NOT NULL,
    CLIENT_BIRTHDATE     DATE NOT NULL,
    CLIENT_ADDRESS       VARCHAR2(30) NULL,
    CLIENT_LATITUDE      FLOAT NULL,
    CLIENT_LONGITUDE     FLOAT NULL,
    CONSTRAINT CLIENT_PK PRIMARY KEY (CLIENT_USER_ID)
    USING INDEX (
        CREATE UNIQUE INDEX CLIENT_PK ON CLIENT (CLIENT_USER_ID)
        TABLESPACE TS_USERS_INDEX
    ),
    CONSTRAINT CLIENT_USER_ID_FK FOREIGN KEY (CLIENT_USER_ID) REFERENCES USERVF(USER_ID) ON DELETE CASCADE
) 
LOB (CLIENT_PHOTO) STORE AS (TABLESPACE TS_USERS_BLOB)
TABLESPACE TS_USERS_DATA;

DROP TABLE IF EXISTS CARD CASCADE CONSTRAINT;
CREATE TABLE CARD (
    CARD_ID                 NUMBER NOT NULL,
    CARD_NUMBER             NUMBER NOT NULL,
    CARD_EXPIRATION_DATE    NUMBER(4) NOT NULL,
    CARD_EXPIRATION_MONTH   NUMBER(2) NOT NULL,
    CARD_CVV                VARCHAR2(3) NOT NULL,
    CARD_CLIENT_ID          NUMBER NOT NULL,
    CONSTRAINT CARD_PK PRIMARY KEY (CARD_ID)
    USING INDEX(
        CREATE UNIQUE INDEX CARD_PK ON CARD (CARD_ID)
        TABLESPACE TS_PAYMENTS_INDEX
    ),
    CONSTRAINT CARD_CARD_CLIENT_ID_FK FOREIGN KEY (CARD_CLIENT_ID) REFERENCES CLIENT (CLIENT_USER_ID)
) TABLESPACE TS_PAYMENTS_DATA;

CREATE INDEX IDX_CARD_CLIENT_ID ON CARD (CARD_CLIENT_ID) TABLESPACE TS_PAYMENTS_INDEX;

DROP TABLE IF EXISTS DEALER CASCADE CONSTRAINT;
CREATE TABLE DEALER (
    DEALER_USER_ID              NUMBER NOT NULL,
    DEALER_NAME                 VARCHAR2(20) NOT NULL,
    DEALER_LASTNAME             VARCHAR2(20) NOT NULL,
    DEALER_PHOTO                BLOB NOT NULL,
    DEALER_BIRTHDATE            DATE NOT NULL,
    DEALER_LICENSE_NUMBER       NUMBER(6) NOT NULL,
    DEALER_LICENSE_STARTDATE    DATE NOT NULL,
    DEALER_LICENSE_END_DATE     DATE NOT NULL,
    DEALER_MOTORCYCLE_PLATE     VARCHAR2(20) NULL,
    DEALER_MOTORCYCLE_PHOTO     BLOB NOT NULL,
    DEALER_SUBSTITUTE_ID        NUMBER NULL,
    CONSTRAINT DEALER_PK PRIMARY KEY (DEALER_USER_ID)
    USING INDEX (
        CREATE UNIQUE INDEX DEALER_PK ON DEALER (DEALER_USER_ID)
        TABLESPACE TS_USERS_INDEX
    ),
    CONSTRAINT DEALER_DEALER_SUBSTITUTE_ID_FK FOREIGN KEY (DEALER_SUBSTITUTE_ID) REFERENCES DEALER (DEALER_USER_ID) ON DELETE SET NULL,
    CONSTRAINT DEALER_USER_ID_FK FOREIGN KEY (DEALER_USER_ID) REFERENCES USERVF(USER_ID) ON DELETE CASCADE
) 
LOB (DEALER_PHOTO) STORE AS (TABLESPACE TS_USERS_BLOB)
LOB (DEALER_MOTORCYCLE_PHOTO) STORE AS (TABLESPACE TS_USERS_BLOB)
TABLESPACE TS_USERS_DATA;

DROP TABLE IF EXISTS DEALER_BANK_DATA CASCADE CONSTRAINT;
CREATE TABLE DEALER_BANK_DATA (
    DEALER_BANK_DATA_ID         NUMBER NOT NULL,
    DEALER_BANK_DATA_CLABE      VARCHAR2(16) NOT NULL,
    DEALER_BANK_DATA_FREQUENCY  VARCHAR2(20) NOT NULL CHECK (DEALER_BANK_DATA_FREQUENCY IN ('BIWEEKLY', 'WEEKLY', 'DAILY')),
    DEALER_BANK_DEALER_ID       NUMBER NOT NULL,
    DEALER_BANK_DATA_BANK_ID    NUMBER NOT NULL,
    CONSTRAINT DEALER_BANK_DATA_PK PRIMARY KEY (DEALER_BANK_DATA_ID)
    USING INDEX (
        CREATE UNIQUE INDEX DEALER_BANK_DATA_PK ON DEALER_BANK_DATA (DEALER_BANK_DATA_ID)
        TABLESPACE TS_PAYMENTS_INDEX
    ),
    CONSTRAINT DEALER_BANK_DATA_DEALER_ID_FK FOREIGN KEY (DEALER_BANK_DEALER_ID) REFERENCES DEALER (DEALER_USER_ID),
    CONSTRAINT DEALER_BANK_DATA_BANK_ID_FK FOREIGN KEY (DEALER_BANK_DATA_BANK_ID) REFERENCES BANK (BANK_ID) ON DELETE SET NULL
) TABLESPACE TS_PAYMENTS_DATA;

CREATE INDEX IDX_DEALER_BANK_DEALER_ID ON DEALER_BANK_DATA (DEALER_BANK_DEALER_ID) TABLESPACE TS_PAYMENTS_INDEX;

DROP TABLE IF EXISTS DEALER_PAYMENT CASCADE CONSTRAINT;
CREATE TABLE DEALER_PAYMENT (
    DEALER_PAYMENT_ID           NUMBER NOT NULL,
    DEALER_PAYMENT_AMOUNT       FLOAT NOT NULL,
    DEALER_PAYMENT_DATE         DATE NOT NULL,
    DEALER_PAYMENT_DEALER_ID    NUMBER NOT NULL,
    DEALER_PAYMENT_ORDER_ID     NUMBER NOT NULL,
    CONSTRAINT DEALER_PAYMENT_PK PRIMARY KEY (DEALER_PAYMENT_ID)
    USING INDEX (
        CREATE UNIQUE INDEX DEALER_PAYMENT_PK ON DEALER_PAYMENT (DEALER_PAYMENT_ID)
        TABLESPACE TS_PAYMENTS_INDEX
    ),
    CONSTRAINT DEALER_PAYMENT_DEALER_ID_FK FOREIGN KEY (DEALER_PAYMENT_DEALER_ID) REFERENCES DEALER (DEALER_USER_ID)
) TABLESPACE TS_PAYMENTS_HISTORY;

CREATE INDEX IDX_DEALER_PAYMENT_DEALER_ID ON DEALER_PAYMENT (DEALER_PAYMENT_DEALER_ID) TABLESPACE TS_PAYMENTS_INDEX;
CREATE INDEX IDX_DEALER_PAYMENT_DATE ON DEALER_PAYMENT (DEALER_PAYMENT_DATE) TABLESPACE TS_PAYMENTS_INDEX;

DROP TABLE IF EXISTS LOCATION_LOG CASCADE CONSTRAINT;
CREATE TABLE LOCATION_LOG (
    LOCATION_LOG_ID         NUMBER NOT NULL,
    LOCATION_LOG_TIMESTAMP  DATE NOT NULL,
    LOCATION_LOG_LATITUDE   FLOAT NOT NULL,
    LOCATION_LOG_LONGITUDE  FLOAT NOT NULL,
    LOCATION_LOG_USER_ID    NUMBER NOT NULL,
    CONSTRAINT LOCATION_LOG_PK PRIMARY KEY (LOCATION_LOG_ID)
    USING INDEX (
        CREATE UNIQUE INDEX LOCATION_LOG_PK ON LOCATION_LOG (LOCATION_LOG_ID)
        TABLESPACE TS_LOCATION_INDEX
    ),
    CONSTRAINT LOCATION_LOG_LOCATION_LOG_USER_ID_FK FOREIGN KEY (LOCATION_LOG_USER_ID) REFERENCES DEALER (DEALER_USER_ID)
) TABLESPACE TS_LOCATION_DATA;

CREATE INDEX IDX_LOCATION_LOG_USER_ID ON LOCATION_LOG (LOCATION_LOG_USER_ID) TABLESPACE TS_LOCATION_INDEX;
CREATE INDEX IDX_LOCATION_LOG_TIMESTAMP ON LOCATION_LOG (LOCATION_LOG_TIMESTAMP) TABLESPACE TS_LOCATION_INDEX;

DROP TABLE IF EXISTS PROVIDER CASCADE CONSTRAINT;
CREATE TABLE PROVIDER (
    PROVIDER_USER_ID     NUMBER NOT NULL,
    PROVIDER_NAME        VARCHAR2(18) NOT NULL,
    PROVIDER_LOGO        BLOB NOT NULL,
    PROVIDER_DESCRIPTION VARCHAR2(1000) NOT NULL,
    CONSTRAINT PROVIDER_PK PRIMARY KEY (PROVIDER_USER_ID)
    USING INDEX (
        CREATE UNIQUE INDEX PROVIDER_PK ON PROVIDER (PROVIDER_USER_ID)
        TABLESPACE TS_USERS_INDEX
    ),
    CONSTRAINT PROVIDER_USER_ID_FK FOREIGN KEY (PROVIDER_USER_ID) REFERENCES USERVF(USER_ID) ON DELETE CASCADE
) 
LOB (PROVIDER_LOGO) STORE AS (TABLESPACE TS_USERS_BLOB)
TABLESPACE TS_USERS_DATA;

DROP TABLE IF EXISTS PROVIDER_BANK_DATA CASCADE CONSTRAINT;
CREATE TABLE PROVIDER_BANK_DATA (
    PROVIDER_BANK_DATA_ID NUMBER NOT NULL,
    PROVIDER_BANK_DATA_CLABE VARCHAR2(16) NOT NULL,
    PROVIDER_BANK_DATA_FREQUENCY VARCHAR2(20) NOT NULL CHECK (PROVIDER_BANK_DATA_FREQUENCY IN ('BIWEEKLY', 'WEEKLY', 'DAILY')),
    PROVIDER_BANK_DATA_BANK_ID NUMBER NOT NULL,
    PROVIDER_BANK_DATA_PROVIDER_ID NUMBER NOT NULL,
    CONSTRAINT PROVIDER_BANK_DATA_PK PRIMARY KEY (PROVIDER_BANK_DATA_ID)
    USING INDEX (
        CREATE UNIQUE INDEX PROVIDER_BANK_DATA_PK ON PROVIDER_BANK_DATA (PROVIDER_BANK_DATA_ID)
        TABLESPACE TS_PAYMENTS_INDEX
    ),
    CONSTRAINT PROVIDER_BANK_DATA_PROVIDER_ID_FK FOREIGN KEY (PROVIDER_BANK_DATA_PROVIDER_ID) REFERENCES PROVIDER (PROVIDER_USER_ID),
    CONSTRAINT PROVIDER_BANK_DATA_BANK_ID_FK FOREIGN KEY (PROVIDER_BANK_DATA_BANK_ID) REFERENCES BANK (BANK_ID) ON DELETE SET NULL
) TABLESPACE TS_PAYMENTS_DATA;

CREATE INDEX IDX_PROVIDER_BANK_DATA_PROVIDER_ID ON PROVIDER_BANK_DATA (PROVIDER_BANK_DATA_PROVIDER_ID) TABLESPACE TS_PAYMENTS_INDEX;

DROP TABLE IF EXISTS PROVIDER_GALLERY CASCADE CONSTRAINT;
CREATE TABLE PROVIDER_GALLERY (
    PROVIDER_GALLERY_ID  NUMBER NOT NULL,
    PROVIDER_GALLERY_PHOTO BLOB NOT NULL,
    PROVIDER_GALLERY_USER_ID NUMBER NOT NULL,
    CONSTRAINT PROVIDER_GALLERY_PK PRIMARY KEY (PROVIDER_GALLERY_ID)
    USING INDEX (
        CREATE UNIQUE INDEX PROVIDER_GALLERY_PK ON PROVIDER_GALLERY (PROVIDER_GALLERY_ID)
        TABLESPACE TS_USERS_INDEX
    ),
    CONSTRAINT PROVIDER_GALLERY_USER_ID_FK FOREIGN KEY (PROVIDER_GALLERY_USER_ID) REFERENCES PROVIDER (PROVIDER_USER_ID)
) TABLESPACE TS_USERS_BLOB;

CREATE INDEX IDX_PROVIDER_GALLERY_USER_ID ON PROVIDER_GALLERY (PROVIDER_GALLERY_USER_ID) TABLESPACE TS_USERS_INDEX;

DROP TABLE IF EXISTS PROVIDER_PAYMENT CASCADE CONSTRAINT;
CREATE TABLE PROVIDER_PAYMENT (
    PROVIDER_PAYMENT_ID  NUMBER NOT NULL,
    PROVIDER_PAYMENT_AMOUNT FLOAT NOT NULL,
    PROVIDER_PAYMENT_DATE DATE NOT NULL,
    PROVIDER_PAYMENT_USER_ID NUMBER NULL,
    CONSTRAINT PROVIDER_PAYMENT_PK PRIMARY KEY (PROVIDER_PAYMENT_ID)
    USING INDEX (
        CREATE UNIQUE INDEX PROVIDER_PAYMENT_PK ON PROVIDER_PAYMENT (PROVIDER_PAYMENT_ID)
        TABLESPACE TS_PAYMENTS_INDEX
    ),
    CONSTRAINT PROVIDER_PAYMENT_PROVIDER_PAYMENT_USER_ID_FK FOREIGN KEY (PROVIDER_PAYMENT_USER_ID) REFERENCES PROVIDER (PROVIDER_USER_ID) ON DELETE SET NULL
) TABLESPACE TS_PAYMENTS_HISTORY;

CREATE INDEX IDX_PROVIDER_PAYMENT_USER_ID ON PROVIDER_PAYMENT (PROVIDER_PAYMENT_USER_ID) TABLESPACE TS_PAYMENTS_INDEX;
CREATE INDEX IDX_PROVIDER_PAYMENT_DATE ON PROVIDER_PAYMENT (PROVIDER_PAYMENT_DATE) TABLESPACE TS_PAYMENTS_INDEX;

----------------------------------- Modulo 2. Órdenes y platos -----------------------------------
connect sys/system1 as sysdba
alter session set container = naproynu_modulo_2;
connect usermod2/usermod2@naproynu_modulo_2 

DROP TABLE IF EXISTS DISH_TYPE;
CREATE TABLE DISH_TYPE (
    DISH_TYPE_ID         NUMBER NOT NULL,
    DISH_TYPE_TYPE       VARCHAR2(20) NOT NULL CHECK (DISH_TYPE_TYPE IN ('ENTRY', 'SOUP', 'STRONG_MEAL', 'DESSERT', 'DRINK')),
    CONSTRAINT DISH_TYPE_PK PRIMARY KEY (DISH_TYPE_ID)
    USING INDEX (
        CREATE UNIQUE INDEX DISH_TYPE_PK ON DISH_TYPE (DISH_TYPE_ID)
        TABLESPACE TS_DISH_INDEX
    )
) TABLESPACE TS_DISH_DATA;

DROP TABLE IF EXISTS DISH;
CREATE TABLE DISH (
    DISH_ID              NUMBER NOT NULL,
    DISH_NAME            VARCHAR2(20) NOT NULL,
    DISH_CATEGORY        VARCHAR2(20) NOT NULL CHECK (DISH_DISH_CATEGORY IN ('BREAKFAST', 'LUNCH', 'DINNER')),
    DISH_DESCRIPTION     VARCHAR2(200) NOT NULL,
    DISH_CALORIES        NUMBER NULL,
    DISH_VIDEO           BLOB NULL,
    DISH_LAST_PRICE      FLOAT NOT NULL,
    DISH_LAST_PRICE_DATE DATE NOT NULL,
    DISH_TYPE_ID         NUMBER NOT NULL,
    DISH_PROVIDER_USER_ID NUMBER NOT NULL,
    CONSTRAINT DISH_PK PRIMARY KEY (DISH_ID)
    USING INDEX (
        CREATE UNIQUE INDEX DISH_PK ON DISH (DISH_ID)
        TABLESPACE TS_DISH_INDEX
    ),
    CONSTRAINT DISH_DISH_TYPE_ID_FK FOREIGN KEY (DISH_TYPE_ID) REFERENCES DISH_TYPE (DISH_TYPE_ID) ON DELETE SET NULL
) 
LOB (DISH_VIDEO) STORE AS (TABLESPACE TS_DISH_BLOB)
TABLESPACE TS_DISH_DATA;

CREATE INDEX IDX_DISH_PROVIDER_USER_ID ON DISH (DISH_PROVIDER_USER_ID) TABLESPACE TS_DISH_INDEX;
CREATE INDEX IDX_DISH_TYPE_CATEGORY ON DISH (DISH_TYPE_ID, DISH_CATEGORY) TABLESPACE TS_DISH_INDEX;
CREATE INDEX IDX_DISH_CALORIES ON DISH (DISH_CALORIES) TABLESPACE TS_DISH_INDEX;

DROP TABLE IF EXISTS DISH_GALLERY;
CREATE TABLE DISH_GALLERY (
    DISH_GALLERY_ID      NUMBER NOT NULL,
    DISH_GALLERY_PHOTO   BLOB NOT NULL,
    DISH_GALLERY_DISH_ID NUMBER NOT NULL,
    CONSTRAINT DISH_GALLERY_PK PRIMARY KEY (DISH_GALLERY_ID)
    USING INDEX (
        CREATE UNIQUE INDEX DISH_GALLERY_PK ON DISH_GALLERY (DISH_GALLERY_ID)
        TABLESPACE TS_DISH_INDEX
    ),
    CONSTRAINT DISH_GALLERY_DISH_ID_FK FOREIGN KEY (DISH_GALLERY_DISH_ID) REFERENCES DISH (DISH_ID)
) TABLESPACE TS_DISH_BLOB;

CREATE INDEX IDX_DISH_GALLERY_DISH_ID ON DISH_GALLERY (DISH_GALLERY_DISH_ID) TABLESPACE TS_DISH_INDEX;

DROP TABLE IF EXISTS DISH_PRICE_HISTORY;
CREATE TABLE DISH_PRICE_HISTORY (
    DISH_PRICE_HISTORY_ID       NUMBER NOT NULL,
    DISH_PRICE_HISTORY_AMOUNT   FLOAT NOT NULL,
    DISH_PRICE_HISTORY_DATE     DATE NOT NULL,
    DISH_PRICE_HISTORY_DISH_ID  NUMBER NOT NULL,
    CONSTRAINT DISH_PRICE_HISTORY_PK PRIMARY KEY (DISH_PRICE_HISTORY_ID)
    USING INDEX (
        CREATE UNIQUE INDEX DISH_PRICE_HISTORY_PK ON DISH_PRICE_HISTORY (DISH_PRICE_HISTORY_ID)
        TABLESPACE TS_DISH_INDEX
    ),
    CONSTRAINT DISH_PRICE_HISTORY_DISH_ID_FK FOREIGN KEY (DISH_PRICE_HISTORY_DISH_ID) REFERENCES DISH (DISH_ID)
) TABLESPACE TS_DISH_DATA;

CREATE INDEX IDX_DISH_PRICE_HISTORY_DISH_ID ON DISH_PRICE_HISTORY (DISH_PRICE_HISTORY_DISH_ID) TABLESPACE TS_DISH_INDEX;

DROP TABLE IF EXISTS DISH_REVIEW;
CREATE TABLE DISH_REVIEW (
    DISH_REVIEW_ID       NUMBER NOT NULL,
    DISH_REVIEW_RATE     INTEGER NOT NULL,
    DISH_REVIEW_COMMENT  VARCHAR2(200) NOT NULL,
    DISH_REVIEW_DISH_ID  NUMBER NOT NULL,
    DISH_REVIEW_USER_ID  NUMBER NOT NULL,
    CONSTRAINT DISH_REVIEW_PK PRIMARY KEY (DISH_REVIEW_ID)
    USING INDEX (
        CREATE UNIQUE INDEX DISH_REVIEW_PK ON DISH_REVIEW (DISH_REVIEW_ID)
        TABLESPACE TS_DISH_INDEX
    ),
    CONSTRAINT DISH_REVIEW_DISH_REVIEW_DISH_ID_FK FOREIGN KEY (DISH_REVIEW_DISH_ID) REFERENCES DISH (DISH_ID)
) TABLESPACE TS_DISH_DATA;

CREATE INDEX IDX_DISH_REVIEW_DISH_ID ON DISH_REVIEW (DISH_REVIEW_DISH_ID) TABLESPACE TS_DISH_INDEX;
CREATE INDEX IDX_DISH_REVIEW_USER_ID ON DISH_REVIEW (DISH_REVIEW_USER_ID) TABLESPACE TS_DISH_INDEX;

DROP TABLE IF EXISTS ORDER_STATUS;
CREATE TABLE ORDER_STATUS (
    ORDER_STATUS_ID      NUMBER NOT NULL,
    ORDER_STATUS         VARCHAR2(20) NOT NULL CHECK (ORDER_STATUS_ORDER_STATUS IN ('REGISTERED', 'PAID', 'IN_PROCESS', 'SENT_TO_DEALER', 'DELIVERED', 'CANCELED', 'REJECTED')),
    CONSTRAINT ORDER_STATUS_PK PRIMARY KEY (ORDER_STATUS_ID)
    USING INDEX (
        CREATE UNIQUE INDEX ORDER_STATUS_PK ON ORDER_STATUS (ORDER_STATUS_ID)
        TABLESPACE TS_ORDERS_INDEX
    )
) TABLESPACE TS_ORDERS_DATA;

DROP TABLE IF EXISTS ORDER;
CREATE TABLE ORDER (
    ORDER_ID             NUMBER NOT NULL,
    ORDER_AMOUNT         FLOAT NOT NULL,
    ORDER_DATE           DATE NOT NULL,
    ORDER_FEE            FLOAT NOT NULL,
    ORDER_DELIVERY_COST  FLOAT NOT NULL,
    ORDER_STATUS_DATE    DATE NOT NULL,
    ORDER_RECEIPT_FOLIO  CHAR(7) NULL,
    ORDER_DIG_SIGNATURE  BLOB NULL,
    ORDER_STATUS_ID      NUMBER NOT NULL,
    ORDER_CLIENT_ID      NUMBER NOT NULL,
    ORDER_DEALER_ID      NUMBER NULL,
    ORDER_CARD_ID        NUMBER NULL,
    CONSTRAINT ORDER_PK PRIMARY KEY (ORDER_ID)
    USING INDEX (
        CREATE UNIQUE INDEX ORDER_PK ON ORDER (ORDER_ID)
        TABLESPACE TS_ORDERS_INDEX
    ),
    CONSTRAINT ORDER_ORDER_STATUS_ID_FK FOREIGN KEY (ORDER_STATUS_ID) REFERENCES ORDER_STATUS (ORDER_STATUS_ID) ON DELETE SET NULL
) 
LOB (ORDER_DIG_SIGNATURE) STORE AS (TABLESPACE TS_ORDERS_BLOB)
TABLESPACE TS_ORDERS_DATA;

CREATE INDEX IDX_ORDER_CLIENT_ID ON ORDER (ORDER_CLIENT_ID) TABLESPACE TS_ORDERS_INDEX;
CREATE INDEX IDX_ORDER_DEALER_ID ON ORDER (ORDER_DEALER_ID) TABLESPACE TS_ORDERS_INDEX;
CREATE INDEX IDX_ORDER_CLIENT_STATUS ON ORDER (ORDER_CLIENT_ID, ORDER_STATUS_ID) TABLESPACE TS_ORDERS_INDEX;
CREATE INDEX IDX_ORDER_DATE ON ORDER (ORDER_DATE) TABLESPACE TS_ORDERS_INDEX;
CREATE INDEX IDX_ORDER_AMOUNT ON ORDER (ORDER_AMOUNT) TABLESPACE TS_ORDERS_INDEX;
CREATE INDEX IDX_ORDER_DISH_QUANTITY ON ORDER_DISH (ORDER_DISH_QUANTITY) TABLESPACE TS_ORDERS_INDEX;

DROP TABLE IF EXISTS ORDER_DISH;
CREATE TABLE ORDER_DISH (
    ORDER_DISH_ID        NUMBER NOT NULL,
    ORDER_DISH_QUANTITY  NUMBER NOT NULL,
    ORDER_DISH_DISH_ID   NUMBER NOT NULL,
    ORDER_DISH_ORDER_ID  NUMBER NOT NULL,
    CONSTRAINT ORDER_DISH_PK PRIMARY KEY (ORDER_DISH_ID)
    USING INDEX (
        CREATE UNIQUE INDEX ORDER_DISH_PK ON ORDER_DISH (ORDER_DISH_ID)
        TABLESPACE TS_ORDERS_INDEX
    ),
    CONSTRAINT ORDER_DISH_ORDER_ID_FK FOREIGN KEY (ORDER_DISH_ORDER_ID) REFERENCES ORDER (ORDER_ID),
    CONSTRAINT ORDER_DISH_DISH_ID_FK FOREIGN KEY (ORDER_DISH_DISH_ID) REFERENCES DISH (DISH_ID)
) TABLESPACE TS_ORDERS_DATA;

CREATE INDEX IDX_ORDER_DISH_DISH_ID ON ORDER_DISH (ORDER_DISH_DISH_ID) TABLESPACE TS_ORDERS_INDEX;

DROP TABLE IF EXISTS ORDER_REVIEW;
CREATE TABLE ORDER_REVIEW (
    ORDER_REVIEW_ID       NUMBER NOT NULL,
    ORDER_REVIEW_RATE     INTEGER NOT NULL,
    ORDER_REVIEW_COMMENT  VARCHAR2(100) NOT NULL,
    ORDER_REVIEW_ORDER_ID NUMBER NOT NULL,
    ORDER_REVIEW_USER_ID  NUMBER NOT NULL,
    CONSTRAINT ORDER_REVIEW_PK PRIMARY KEY (ORDER_REVIEW_ID)
    USING INDEX (
        CREATE UNIQUE INDEX ORDER_REVIEW_PK ON ORDER_REVIEW (ORDER_REVIEW_ID)
        TABLESPACE TS_ORDERS_INDEX
    ),
    CONSTRAINT ORDER_REVIEW_ORDER_ID_FK FOREIGN KEY (ORDER_REVIEW_ORDER_ID) REFERENCES ORDER (ORDER_ID)
) TABLESPACE TS_ORDERS_DATA;

DROP TABLE IF EXISTS ORDER_STATUS_HISTORY;
CREATE TABLE ORDER_STATUS_HISTORY (
    ORDER_STATUS_HISTORY_ID         NUMBER NOT NULL,
    ORDER_STATUS_HISTORY_DATE       DATE NOT NULL,
    ORDER_STATUS_HISTORY_ORDER_ID   NUMBER NOT NULL,
    ORDER_STATUS_HISTORY_STATUS_ID  NUMBER NOT NULL,
    CONSTRAINT ORDER_STATUS_HISTORY_PK PRIMARY KEY (ORDER_STATUS_HISTORY_ID)
    USING INDEX (
        CREATE UNIQUE INDEX ORDER_STATUS_HISTORY_PK ON ORDER_STATUS_HISTORY (ORDER_STATUS_HISTORY_ID)
        TABLESPACE TS_ORDERS_INDEX
    ),
    CONSTRAINT ORDER_STATUS_HISTORY_ORDER_ID_FK FOREIGN KEY (ORDER_STATUS_HISTORY_ORDER_ID) REFERENCES ORDER (ORDER_ID),
    CONSTRAINT ORDER_STATUS_HISTORY_ORDER_STATUS_HISTORY_STATUS_ID_FK FOREIGN KEY (ORDER_STATUS_HISTORY_STATUS_ID) REFERENCES ORDER_STATUS (ORDER_STATUS_ID) ON DELETE SET NULL
) TABLESPACE TS_ORDERS_DATA;

CREATE INDEX IDX_ORDER_STATUS_HISTORY_ORDER_ID ON ORDER_STATUS_HISTORY (ORDER_STATUS_HISTORY_ORDER_ID) TABLESPACE TS_ORDERS_INDEX;
CREATE INDEX IDX_ORDER_STATUS_HISTORY_STATUS_ID ON ORDER_STATUS_HISTORY (ORDER_STATUS_HISTORY_STATUS_ID) TABLESPACE TS_ORDERS_INDEX;
CREATE INDEX IDX_ORDER_STATUS_HISTORY_DATE ON ORDER_STATUS_HISTORY (ORDER_STATUS_HISTORY_DATE) TABLESPACE TS_ORDERS_INDEX;