create or replace view V_DIMPLANNERS(
	DATASOURCEKEY,
	PLANNERCODE,
	PLANTCODE,
	MRPCONTROLLER,
	FULLNAME,
	PHONE1,
	PROFITCENTER,
	RN
) as
/*--------------------------------------------------------------------------------------------

This view is used to insert data into SAP.DimPlanners
----------------------------------------------------------------------------------------------
Revision History
----------------------------------------------------------------------------------------------
Date            Developer               Comments
----------------------------------------------------------------------------------------------
2021-02-18      Juan Cedeno             Initial Revision
2021-07-14      Jagan                   Add JPS
2021-09-22      Jagan                   Add PLA
*/

SELECT
    * 
FROM
    (
      SELECT 
	         1 as DataSourceKey                       
           , plannercode
           , plantcode   
           , mrpcontroller
           , fullname
           , phone1
           , profitcenter
           , ROW_NUMBER() over (partition by plannercode order by plannercode ) rn
      FROM   
	         conformed.v_ecc_ha_DimPlanners

      UNION ALL 

      SELECT 
	         2 as DataSourceKey
           , plannercode
           , plantcode   
           , mrpcontroller
           , fullname
           , phone1
           , profitcenter  
           , ROW_NUMBER() over (partition by plannercode order by plannercode ) rn
      FROM   
	         conformed.v_Hcc_ha_DimPlanners
	  
	  UNION ALL
	  
	  SELECT 
	         5 as DataSourceKey
           , plannercode
           , plantcode   
           , mrpcontroller
           , fullname
           , phone1
           , profitcenter
           , ROW_NUMBER() over (partition by plannercode order by plannercode ) rn
      FROM   
	         conformed.v_jps_ha_DimPlanners

	  UNION ALL
	  
	  SELECT 
	         4 as DataSourceKey
           , plannercode
           , plantcode   
           , mrpcontroller
           , fullname
           , phone1
           , profitcenter
           , ROW_NUMBER() over (partition by plannercode order by plannercode ) rn
      FROM   
	         conformed.v_pla_ha_DimPlanners
) Q
WHERE 
      Q.rn = 1;