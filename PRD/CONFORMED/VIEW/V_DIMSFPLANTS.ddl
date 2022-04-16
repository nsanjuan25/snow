create or replace view V_DIMSFPLANTS(
	SETTARTGETPLANTKEY,
	PLANTNAME
) as

with recursive PlantNamesplit(SetTargetPlants , lvl , resstring , nextstring , lasstring)
as
(
select SetTargetPlants , 1  
 , substring (SetTargetPlants , 1 , position ( ';' in SetTargetPlants)-1  ) 
 , substring (SetTargetPlants ,position ( ';' in SetTargetPlants) + 1 , 1000 ) as nextstring 
 , case when position ( ';' in nextstring) = 0 then nextstring  end as laststring
from conformed.v_DimSFSetTargetPlants
where SetTargetPlants <> ''
union all
select a.SetTargetPlants , lvl + 1--, position ( ';' in nextstring) as pos2 
  , substring (nextstring , 1 , position ( ';' in nextstring)-1) as resstring 
  , substring (nextstring , position ( ';' in nextstring) + 1 , 1000  )
  , case when position ( ';' in a.nextstring) = 0 then a.nextstring  end as laststring
from
PlantNamesplit a
inner join  
conformed.v_DimSFSetTargetPlants b  
on a.SetTargetPlants = b.SetTargetPlants
and a.lvl <= regexp_count (b.SetTargetPlants , ';' )  
) select distinct  b.SetTartgetPlantKey ,-- a.SetTargetPlants , lvl , 
case when resstring is not null and resstring <> '' then  resstring else  lasstring end as plantname
from PlantNamesplit a 
inner join 
SalesForce.DIMSFSetTargetPlants b
on a.SetTargetPlants = b.SetTargetPlants;