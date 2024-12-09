--TODO: header

whenever sqlerror exit rollback;

spool s-42a-probar-conexiones.log

Prompt Conectando como usuario sys...

connect sys/system1 as sysdba

Prompt viendo en qué modo de conexión estamos
select program,pid,pname
from v$process where pname like'S0%' or pname like 'D0%' order by program;
Pause [Enter] ¿En qué modo de conexión estamos?...

Prompt Probando la conexión
Prompt conectando NAPROYNU_MODULO_1...
connect sys/system1@NAPROYNU_MODULO_1 as sysdba;
select program,pid,pname
from v$process where pname like'S0%' or pname like 'D0%' order by program;
Pause [Enter] ¿En qué modo de conexión estamos?...

Prompt conectando NAPROYNU_MODULO_1_SHARED...
connect sys/system1@NAPROYNU_MODULO_1_SHARED as sysdba;
select program,pid,pname
from v$process where pname like'S0%' or pname like 'D0%' order by program;
Pause [Enter] ¿En qué modo de conexión estamos?...

Prompt conectando NAPROYNU_MODULO_1_DEDICATED...
connect sys/system1@NAPROYNU_MODULO_1_DEDICATED as sysdba;
select program,pid,pname
from v$process where pname like'S0%' or pname like 'D0%' order by program;
Pause [Enter] ¿En qué modo de conexión estamos?...

Prompt conectando NAPROYNU_MODULO_1_POOLED...
connect sys/system1@NAPROYNU_MODULO_1_POOLED as sysdba;
select program,pid,pname
from v$process where pname like'S0%' or pname like 'D0%' order by program;
Pause [Enter] ¿En qué modo de conexión estamos?...

Prompt conectando NAPROYNU_MODULO_2...
connect sys/system1@NAPROYNU_MODULO_2 as sysdba;
select program,pid,pname
from v$process where pname like'S0%' or pname like 'D0%' order by program;
Pause [Enter] ¿En qué modo de conexión estamos?...

Prompt conectando NAPROYNU_MODULO_2_SHARED...
connect sys/system1@NAPROYNU_MODULO_2_SHARED as sysdba;
select program,pid,pname
from v$process where pname like'S0%' or pname like 'D0%' order by program;
Pause [Enter] ¿En qué modo de conexión estamos?...

Prompt conectando NAPROYNU_MODULO_2_DEDICATED...
connect sys/system1@NAPROYNU_MODULO_2_DEDICATED as sysdba;
select program,pid,pname
from v$process where pname like'S0%' or pname like 'D0%' order by program;
Pause [Enter] ¿En qué modo de conexión estamos?...

Prompt conectando NAPROYNU_MODULO_2_POOLED...
connect sys/system1@NAPROYNU_MODULO_2_POOLED as sysdba;
select program,pid,pname
from v$process where pname like'S0%' or pname like 'D0%' order by program;
Pause [Enter] ¿En qué modo de conexión estamos?...

spool off

exit;