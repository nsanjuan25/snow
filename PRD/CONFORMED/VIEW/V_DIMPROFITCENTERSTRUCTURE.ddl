create or replace view V_DIMPROFITCENTERSTRUCTURE(
	PROFITCENTERCODE,
	PROFITCENTERNAME,
	CUSTOMERCODE,
	CUSTOMERNAME,
	DIVISIONCODE,
	DIVISIONNAME,
	SECTORCODE,
	SECTORNAME,
	CREATEDDATE
) as
SELECT
	  ProfitCenterCode
	, ProfitCenterName
	, CustomerCode
	, CustomerName
	, DivisionCode
	, DivisionName
    , SectorCode
    , SectorName
	, CreatedDate
FROM
	TM1.DimProfitCenterHierarchy;