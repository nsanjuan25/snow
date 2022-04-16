create or replace view V_STORAGECOST(
	USAGE_DATE,
	TERABYTES,
	STORAGEUSDCOST
) as
select 
      date_trunc(month, usage_date )        as usage_date
    , storage_bytes / 1099511627776         as TeraBytes
    , (storage_bytes / 1099511627776 ) * 23 as StorageUSDCost
from 
    "SNOWFLAKE"."ACCOUNT_USAGE"."STORAGE_USAGE"
where   
    usage_date in 
    (  
      select 
          max(usage_date)
      from 
          "SNOWFLAKE"."ACCOUNT_USAGE"."STORAGE_USAGE"
      group by 
          date_trunc(month, usage_date )
    )
order by date_trunc(month, usage_date ) desc;