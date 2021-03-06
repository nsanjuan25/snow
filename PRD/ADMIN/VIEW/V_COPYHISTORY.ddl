create or replace view V_COPYHISTORY(
	TABLENAME,
	COPYMINUTES,
	COPYSTATUS,
	SOURCEDATA,
	LOADDATE,
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
	TABLE_ID,
	TABLE_NAME,
	TABLE_SCHEMA_ID,
	TABLE_SCHEMA_NAME,
	TABLE_CATALOG_ID,
	TABLE_CATALOG_NAME,
	PIPE_CATALOG_NAME,
	PIPE_SCHEMA_NAME,
	PIPE_NAME,
	PIPE_RECEIVED_TIME
) as 
SELECT
      upper( A.TableName ) as TableName
    , DATEDIFF(MINUTES, PIPE_RECEIVED_TIME, LAST_LOAD_TIME  ) AS CopyMinutes
    , CASE WHEN c.Last_load_time is null then 'Missing Load' else 'Loaded' End CopyStatus
    , upper( LEFT( A.TABLEName , CHARINDEX(  '_', A.TableName , 1 ) - 1 )  ) as SourceData
    , CAST( D.DateKey as Date ) AS LoadDate 
    , C.FILE_NAME
    , C.STAGE_LOCATION
    , C.LAST_LOAD_TIME
    , C.ROW_COUNT
    , C.ROW_PARSED
    , C.FILE_SIZE
    , C.FIRST_ERROR_MESSAGE
    , C.FIRST_ERROR_LINE_NUMBER
    , C.FIRST_ERROR_CHARACTER_POS
    , C.FIRST_ERROR_COLUMN_NAME
    , C.ERROR_COUNT
    , C.ERROR_LIMIT
    , C.STATUS
    , C.TABLE_ID
    , C.TABLE_NAME
    , C.TABLE_SCHEMA_ID
    , C.TABLE_SCHEMA_NAME
    , C.TABLE_CATALOG_ID
    , C.TABLE_CATALOG_NAME
    , C.PIPE_CATALOG_NAME
    , C.PIPE_SCHEMA_NAME
    , C.PIPE_NAME
    , C.PIPE_RECEIVED_TIME
FROM
    landing.TableMetadata A
    INNER JOIN  Public.DimDates D on D.DateKey between DATEADD(Day ,-5, current_date) and current_date
    LEFT OUTER JOIN information_schema.PIPES P 
        ON CONCAT( 'PIPE_' , upper( A.TableName ) ) = P.PIPE_NAME
    LEFT OUTER JOIN SNOWFLAKE.ACCOUNT_USAGE.COPY_HISTORY C on upper(A.tablename ) = C.Table_Name 
        AND Last_load_time >= DATEADD(Day ,-5, current_date)
        AND D.DateKey = CAST( Last_Load_Time as date ) 
        AND C.TABLE_CATALOG_NAME = CURRENT_DATABASE();