--https://community.toadworld.com/platforms/oracle/w/wiki/4902.script-to-report-table-partition-keys

SELECT   owner, NAME, column_name, column_position
    FROM dba_part_key_columns
   WHERE owner LIKE UPPER ('&&ENTER_OWNER_NAME')
     AND NAME LIKE UPPER ('&&ENTER_TABLE_NAME')
ORDER BY owner, NAME;

--partition info
select distinct tp.table_owner,tp.table_name,pt.partitioning_type,pt.SUBPARTITIONING_TYPE,pt.interval,count(1) 
from dba_tab_partitions tp,DBA_PART_TABLES pt 
where tp.table_owner=pt.owner and tp.table_name=pt.table_name and tp.table_owner not in ('SYS','SYSTEM') 
group by tp.table_owner,tp.table_name,pt.partitioning_type,pt.SUBPARTITIONING_TYPE,pt.interval 
order by 6 desc;


**** partition modify default atributes

select 'alter table '||owner||'.'||table_name||' modify default attributes tablespace  AZS_LOG_DATA_TS4;' from dba_part_tables where def_tablespace_name='AZS_LOG_DATA_TS1'
select 'alter table '||table_owner||'.'||table_name||' modify default attributes lob('||column_name||') (tablespace  AZS_LOG_DATA_TS4);' from dba_part_lobs  where def_tablespace_name='AZS_LOG_DATA_TS1'
