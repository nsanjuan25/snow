create or replace view V_DIMTM1COSTCENTERXREF_BAK(
	COSTCENTERCODE,
	TM1COSTCENTERCODE
) as

Select CC.Costcentercode as Costcentercode
      ,TM1.Costcentercode as TM1Costcentercode
from 
    Conformed.v_DimTM1DistinctCostCenters_Bak TM1
    inner join tm1.dimcostcenterhierarchy CC
        on TM1.Costcentercode=CC.CostCenterName

union 

Select CC.Costcentercode as Costcentercode
      ,TM1.Costcentercode as TM1Costcentercode
from 
    Conformed.v_DimTM1DistinctCostCenters_Bak TM1
    inner join tm1.dimcostcenterhierarchy CC
        on TM1.Costcentercode=CC.Costcentercode
;