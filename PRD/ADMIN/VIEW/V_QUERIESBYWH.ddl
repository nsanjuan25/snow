create or replace view V_QUERIESBYWH(
	WAREHOUSE_NAME,
	DATEMONTH,
	NUMBEROFQUERIES
) as 
select 
      warehouse_name 
    , date_trunc('month', start_time ) as DateMonth
    , count(*) numberofQueries
from
    snowflake.account_usage.query_history 
where 
    warehouse_name is not null
group by 
    warehouse_name
    , date_trunc('month', start_time );