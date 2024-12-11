select * from v$log;

alter system switch logfile;

!ls -l /unam/bda/proyecto-final/archive-logs/FREE/disk_a

ALTER SESSION SET NLS_DATE_FORMAT = 'yyyy-mm-dd hh24:mi:ss';


SELECT session_key, bs_key, tag, status, start_time, completion_time,
      TRUNC(elapsed_seconds) elapsed_seconds, deleted, size_bytes_display
FROM v$backup_piece_details
order by completion_time;

alter database enable block change tracking using file '/unam/bda/proyecto-final/backups/block-tracking/change_tracking.dbf'

SELECT d.session_key, d.bs_key, d.tag, s.backup_type, d.status, d.start_time,
      d.completion_time, TRUNC(d.elapsed_seconds) elapsed_seconds,
      d.deleted, d.size_bytes_display
FROM v$backup_piece_details d, v$backup_set s
WHERE d.bs_key = s.recid;
-- ARCHIVOS EN FRA
select * from v$recovery_area_usage;

show parameter control_files;