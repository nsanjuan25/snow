create or replace view V_COPYHISTORYFUNCTION(
	TABLENAME,
	LOADDATE,
	SOURCEDATA,
	TABLESTATUS,
	FILE_NAME,
	STAGE_LOCATION,
	LAST_LOAD_TIME,
	ROW_COUNT,
	ROW_PARSED,
	FILE_SIZE,
	FIRST_ERROR_MESSAGE,
	FIRST_ERROR_LINE_NUMBER,
	FIRST_ERROR_CHARACTER_POS,
	FIRST_ERROR_COLUMN_NAME,
	ERROR_COUNT,
	ERROR_LIMIT,
	STATUS,
	TABLE_CATALOG_NAME,
	TABLE_SCHEMA_NAME,
	TABLE_NAME,
	PIPE_CATALOG_NAME,
	PIPE_SCHEMA_NAME,
	PIPE_NAME,
	PIPE_RECEIVED_TIME,
	CREATEDON
) as
select
    a.tablename, Cast(b.last_load_time as date) LoadDate
    , upper( LEFT( TableName , CHARINDEX(  '_', TableName , 1 ) - 1 )  ) as SourceData
    , case when b.STATUS is null then 'Missing' else b.STATUS end TableStatus
    , b.*
from 
    landing.TableMetadata a 
    left outer join admin.etl_tables_CopyHistory b on  b.table_name = a.TableName;