create or replace view V_TM1_ACCOUNT_LVL_HIER(
	PARENT,
	ACCOUNT,
	WEIGHT,
	LEVEL,
	DEPTH,
	HIERARCHY
) as

/*--------------------------------------------------------------------------------------------

 

This view is used to insert data into TM1.DimTM1Accountflat

----------------------------------------------------------------------------------------------

Revision History

----------------------------------------------------------------------------------------------

Date            Developer               Comments

----------------------------------------------------------------------------------------------

2021-03-29      Lakshman               Initial Revision

*/


with recursive TM1_ACCOUNT_lvl 
(  
   parent 
  ,child 
  ,weight 
  ,lvl 
  ,depth
  ,hier
  )
as
( select  
          parent 
         ,child 
		 ,cast ( weight as Decimal(18,6) ) 
		 ,1 as lvl 
         ,0 as depth
		 ,cast(parent || '||' || child  as string) as hier 
 from 
 conformed.TM1_ACCOUNT 
 union all 
 select 
        a.parent 
       ,b.child 
	   ,cast ( a.weight * b.weight as decimal(18,6))
	   ,a.lvl + 1  
       ,a.depth + 1
	   ,cast( a.hier || '||' || a.child as string ) from 
 TM1_ACCOUNT_lvl a
 inner join 
 conformed.TM1_ACCOUNT b 
 on a.child = b.parent
)
select 
               parent 
               ,child 
			   ,cast (weight  as decimal(18,6))
			   ,lvl 
               ,depth
			   ,hier  
from TM1_ACCOUNT_lvl
where child not in ( select parent from TM1_ACCOUNT_lvl);