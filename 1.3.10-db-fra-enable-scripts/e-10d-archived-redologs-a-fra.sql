--@Autor: Aldo Navarrete y Diego Nuñez
--@Fecha: 2024-12-1
--@Descripción: Script para comprobar que los redologs están en la FRA

select dest_id,dest_name,status, binding, destination
from v$archive_dest where dest_id in (1,2);

alter system switch logfile;

SELECT * 
FROM (
    SELECT recid, name, dest_id, sequence#, 
        TO_CHAR(completion_time, 'yyyy-mm-dd hh24:mi:ss') completion_time, 
        is_recovery_dest_file
    FROM v$archived_log 
    ORDER BY sequence# DESC
) 
WHERE rownum <= 4;        