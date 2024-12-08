--@Autor: Aldo Yael Navarrete Zamora, Diego Ignacio Núñez Hernández
--@Fecha creación:  08/12/2024
--@Descripción:     Crea un usuario para crear las tablas del proyecto

Prompt proporcione el password del usuario sys
connect sys/system as sysdba

whenever sqlerror exit rollback
set serveroutput on