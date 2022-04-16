create or replace view V_DIMTM1PROFITCENTERXREF(
	PROFITCENTERCODE,
	TM1PROFITCENTERCODE
) as

Select CC.ProfitCenterCode as ProfitCenterCode
      ,TM1.ProfitCenterCode as TM1ProfitCenterCode
from Conformed.v_DimTM1DistinctProfitCenters TM1
inner join 
tm1.dimprofitcenterhierarchy CC
on Upper(trim(TM1.ProfitCenterCode))=Upper(trim(CC.ProfitCenterName))
union 
Select CC.ProfitCenterCode as ProfitCenterCode
      ,TM1.ProfitCenterCode as TM1ProfitCenterCode
from Conformed.v_DimTM1DistinctProfitCenters TM1
inner join 
tm1.dimprofitcenterhierarchy CC
on Upper(trim(TM1.ProfitCenterCode))=Upper(trim(CC.ProfitCenterCode))
;