create or replace view V_TM1_VERSION_LVL_HIER(
	PARENT,
	ACCOUNT,
	WEIGHT,
	LEVEL,
	DEPTH
) as

/*--------------------------------------------------------------------------------------------

 

This view is used to insert data into TM1.DimTM1Versionflat

----------------------------------------------------------------------------------------------

Revision History

----------------------------------------------------------------------------------------------

Date            Developer               Comments

----------------------------------------------------------------------------------------------

2021-03-29      Lakshman               Initial Revision

*/


with recursive TM1_Version_lvl 
(  
  parent 
  ,child 
  ,weight 
  ,lvl 
  ,Depth
  )
as
( select  
          parent 
         ,child 
		 ,cast ( weight as Decimal(18,6) ) 
		 ,1 as lvl 
		 ,0 as Depth 
 from 
 conformed.TM1_Version 
 union all 
 select 
       a.parent 
       ,b.child 
	   ,cast ( a.weight * b.weight as decimal(18,6))
	   ,a.lvl + 1  
	   ,a.Depth + 1
 from	   
 TM1_Version_lvl a
 inner join 
 conformed.TM1_Version b 
 on a.child = b.parent
)
select distinct 
               Parent 
               ,child 
			   ,weight 
			   ,lvl 
			   ,depth 
from TM1_Version_lvl
where child not in ( select parent from TM1_Version_lvl);