create or replace view V_FACTMATERIALSTANDARDPRICEHISTORY(
	MATERIALKEY,
	STDUNITCOSTP0,
	MATERIALCODE,
	P0EFFECTIVEFROMDATEKEY,
	EFFECTIVEFROMDATEKEY,
	EFFECTIVETODATEKEY,
	LOCALCURRENCYTOUSDEXCHANGERATE,
	DATASOURCEKEY
) as 
/*-------------------------------------------------------------------------------------------------

This view is used to insert data into v_ECC_FactMaterialStandardPriceHistory
-----------------------------------------------------------------------------------------------
Revision History
-----------------------------------------------------------------------------------------------
Date            Developer               Comments
----------------------------------------------------------------------------------------------
2021-03-12     SRIDHAR                 Initial Revision     
*/

SELECT 
	  M.MaterialKey
	, M.StandardUnitCostP0  	AS StdUnitCostP0
	, M.MaterialCode
	, M.P0EffectiveFromDateKey
	, current_date() AS EffectiveFromDateKey
	, CASE WHEN M.DeleteFlag = 0 OR M.DeleteFlag IS NULL THEN  '9999-12-31' ELSE current_date()  END	AS EffectiveToDateKey
	, M.LocalCurrencyToUSDExchangeRate
	, M.DataSourceKey    
FROM 
	SAP.DimMaterials M
	INNER JOIN (
					SELECT MaterialKey,StdUnitCostP0,EffectiveToDateKey,ROW_NUMBER() OVER ( PARTITION BY MaterialKey ORDER BY SrcLAstModifiedDate DESC, EffectiveToDateKey DESC,CreatedOn DESC) rownumber
					FROM SAP.FactMaterialStandardPriceHistory
				) MH
				ON m.MaterialKey = mh.MaterialKey
				AND m.StandardUnitCostP0 <> mh.StdUnitCostP0
				AND mh.rownumber = 1
                
UNION 

SELECT 
	  M.MaterialKey
	, M.StandardUnitCostP0 AS StdUnitCostP0
	, M.MaterialCode
	, M.P0EffectiveFromDateKey
	, current_date() AS EffectiveFromDateKey
	, CASE WHEN M.DeleteFlag = 0 OR M.DeleteFlag IS NULL THEN  '9999-12-31' ELSE current_date()  END	AS EffectiveToDateKey
	, M.LocalCurrencyToUSDExchangeRate
	, M.DataSourceKey
FROM 
	SAP.DimMaterials M
WHERE
	NOT EXISTS ( SELECT NULL FROM SAP.FactMaterialStandardPriceHistory H WHERE  M.MaterialKey = H.MaterialKey) 
	AND M.MaterialKey <> 0;