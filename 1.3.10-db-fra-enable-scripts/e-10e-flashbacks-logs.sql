
connect sys/system1 as sysdba;

alter database flashback on;

alter system set db_flashback_retention_target=1440 scope=both;

exit