create or replace view V_FACTMATERIALSELLPRICEHISTORY(
	MATERIALKEY,
	SELLUNITPRICEP0,
	MATERIALCODE,
	P0EFFECTIVEFROMDATEKEY,
	EFFECTIVEFROMDATEKEY,
	EFFECTIVETODATEKEY,
	LOCALCURRENCYTOUSDEXCHANGERATE,
	DATASOURCEKEY
) as  
/* 
Description         : View used to insert v_FactMaterialSellPriceHistory
Created date  : 
Created By          : Sridhar K

Start Revision History            
-----------------------------------------------------------------------------------------------
Date          Developer           Revision Description
----------    --------------      -------------------------------------------------------------
2021-03-17    Sridhar K     Initial Version
-----------------------------------------------------------------------------------------------
End   Revision   History
*/

 SELECT 
	 M.MaterialKey
	,M.SellUnitPriceP0 																								AS SellUnitPriceP0
	,M.MaterialCode
	,M.P0EffectiveFromDateKey
	,current_date()																					AS EffectiveFromDateKey
	,CASE WHEN M.DeleteFlag = 0 OR M.DeleteFlag IS NULL THEN  '9999-12-31' ELSE current_date()	 END	AS EffectiveToDateKey 
	,M.LocalCurrencyToUSDExchangeRate
	,M.DataSourceKey
	
FROM 
	SAP.DimMaterials M
	INNER JOIN (
					SELECT MaterialKey,SellUnitPriceP0,EffectiveToDateKey,ROW_NUMBER() OVER ( PARTITION BY MaterialKey ORDER BY SrcLAstModifiedDate DESC, EffectiveToDateKey DESC,CreatedOn DESC) rownumber
					FROM SAP.FactMaterialSellPriceHistory
				) MH
				ON m.MaterialKey = mh.MaterialKey
				AND M.SellUnitPriceP0<> mh.SellUnitPriceP0
				AND mh.rownumber = 1
union
SELECT 
	 M.MaterialKey
	,M.SellUnitPriceP0 																								AS SellUnitPriceP0
	,M.MaterialCode
	,M.P0EffectiveFromDateKey
	,current_date() AS EffectiveFromDateKey
	,CASE WHEN M.DeleteFlag = 0 OR M.DeleteFlag IS NULL THEN  '9999-12-31' ELSE current_date() END	AS EffectiveToDateKey 
	,M.LocalCurrencyToUSDExchangeRate
	,M.DataSourceKey
   
FROM 
	SAP.DimMaterials M
WHERE
	NOT EXISTS ( SELECT NULL FROM SAP.FactMaterialSellPriceHistory H WHERE  M.MaterialKey = H.MaterialKey) 
	AND MaterialKey <> 0;