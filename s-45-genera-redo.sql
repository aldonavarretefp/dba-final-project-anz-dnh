--@Autor:   Borboa Castillo Carlos Alfonso, Ortiz Rivera Miguel Angel
--@Fecha creación:  07/06/2024
--@Descripción:  Genera operaciones update, para generar datos REDO

SET SERVEROUTPUT ON

DECLARE
  v_count NUMBER;
BEGIN
  FOR i IN 1..3000 LOOP
    -- Actualizar NIVEL_ESTUDIO
    v_count := 0;
    FOR r IN (SELECT NIVEL_ESTUDIO_ID, NIVEL_ESTUDIO FROM NIVEL_ESTUDIO) LOOP
      UPDATE NIVEL_ESTUDIO
      SET NIVEL_ESTUDIO = r.NIVEL_ESTUDIO
      WHERE NIVEL_ESTUDIO_ID = r.NIVEL_ESTUDIO_ID;
      v_count := v_count + SQL%ROWCOUNT;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('Registros actualizados en NIVEL_ESTUDIO: ' || v_count);

    -- Actualizar CLIENTE
    v_count := 0;
    FOR r IN (SELECT CLIENTE_ID, USUARIO, CONTRASEÑA, FECHA_REGISTRO, EMAIL, TELEFONO, DIRECCION, TIPO FROM CLIENTE) LOOP
      UPDATE CLIENTE
      SET USUARIO = r.USUARIO, 
          CONTRASEÑA = r.CONTRASEÑA, 
          FECHA_REGISTRO = r.FECHA_REGISTRO,
          EMAIL = r.EMAIL,
          TELEFONO = r.TELEFONO,
          DIRECCION = r.DIRECCION,
          TIPO = r.TIPO
      WHERE CLIENTE_ID = r.CLIENTE_ID;
      v_count := v_count + SQL%ROWCOUNT;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('Registros actualizados en CLIENTE: ' || v_count);

    -- Actualizar SERVICIO
    v_count := 0;
    FOR r IN (SELECT SERVICIO_ID, FECHA_DE_SOLICITUD, DESCRIPCION, DESCRIPCION_PDF, FECHA_PROGRESO,
               PROVEEDOR_SERVICIO_RID, CLIENTE_ID, STATUS_SERVICIO_ID FROM SERVICIO) LOOP
      UPDATE SERVICIO
      SET FECHA_DE_SOLICITUD = r.FECHA_DE_SOLICITUD,
          DESCRIPCION = r.DESCRIPCION,
          DESCRIPCION_PDF = r.DESCRIPCION_PDF,
          FECHA_PROGRESO = r.FECHA_PROGRESO,
          PROVEEDOR_SERVICIO_RID = r.PROVEEDOR_SERVICIO_RID,
          CLIENTE_ID = r.CLIENTE_ID,
          STATUS_SERVICIO_ID = r.STATUS_SERVICIO_ID
      WHERE SERVICIO_ID = r.SERVICIO_ID;
      v_count := v_count + SQL%ROWCOUNT;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('Registros actualizados en SERVICIO: ' || v_count);
  END LOOP;
END;
/


