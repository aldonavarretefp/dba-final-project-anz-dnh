--@Autor: Aldo Yael Navarrete Zamora, Diego Ignacio Núñez Hernández
--@Fecha creación:  07/12/2024
--@Descripción:  Genera operaciones update, para generar datos REDO

connect sys/system1 as sysdba

whenever sqlerror exit rollback
set serveroutput on

alter session set container = naproynu_modulo_1;
connect usermod1/usermod1@naproynu_modulo_1 

SET SERVEROUTPUT ON

DECLARE
  v_count NUMBER;
BEGIN
  FOR i IN 1..3000 LOOP
    -- Actualizar CLIENT
    v_count := 0;
    FOR r IN (SELECT CLIENT_USER_ID, CLIENT_NAME, CLIENT_LASTNAME, CLIENT_BIRTHDATE, 
                     CLIENT_ADDRESS, CLIENT_LATITUDE, CLIENT_LONGITUDE 
              FROM CLIENT) LOOP
      UPDATE CLIENT
      SET CLIENT_NAME = r.CLIENT_NAME,
          CLIENT_LASTNAME = r.CLIENT_LASTNAME,
          CLIENT_ADDRESS = r.CLIENT_ADDRESS,
          CLIENT_LATITUDE = r.CLIENT_LATITUDE,
          CLIENT_LONGITUDE = r.CLIENT_LONGITUDE
      WHERE CLIENT_USER_ID = r.CLIENT_USER_ID;
      v_count := v_count + SQL%ROWCOUNT;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('Registros actualizados en CLIENT: ' || v_count);

    -- Actualizar DEALER
    v_count := 0;
    FOR r IN (SELECT DEALER_USER_ID, DEALER_NAME, DEALER_LASTNAME, DEALER_LICENSE_NUMBER, 
                     DEALER_LICENSE_STARTDATE, DEALER_LICENSE_END_DATE, DEALER_MOTORCYCLE_PLATE
              FROM DEALER) LOOP
      UPDATE DEALER
      SET DEALER_NAME = r.DEALER_NAME,
          DEALER_LASTNAME = r.DEALER_LASTNAME,
          DEALER_LICENSE_NUMBER = r.DEALER_LICENSE_NUMBER,
          DEALER_LICENSE_STARTDATE = r.DEALER_LICENSE_STARTDATE,
          DEALER_LICENSE_END_DATE = r.DEALER_LICENSE_END_DATE,
          DEALER_MOTORCYCLE_PLATE = r.DEALER_MOTORCYCLE_PLATE
      WHERE DEALER_USER_ID = r.DEALER_USER_ID;
      v_count := v_count + SQL%ROWCOUNT;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('Registros actualizados en DEALER: ' || v_count);

    -- Actualizar PROVIDER
    v_count := 0;
    FOR r IN (SELECT PROVIDER_USER_ID, PROVIDER_NAME, PROVIDER_DESCRIPTION 
              FROM PROVIDER) LOOP
      UPDATE PROVIDER
      SET PROVIDER_NAME = r.PROVIDER_NAME,
          PROVIDER_DESCRIPTION = r.PROVIDER_DESCRIPTION
      WHERE PROVIDER_USER_ID = r.PROVIDER_USER_ID;
      v_count := v_count + SQL%ROWCOUNT;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('Registros actualizados en PROVIDER: ' || v_count);
  END LOOP;
END;
/

Prompt Confirmando ...
