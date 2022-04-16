create or replace view V_FACTMATERIALSELLPRICEHISTORY_UPDATES(
	MATERIALKEY,
	EFFECTIVEFROMDATEKEY,
	EFFECTIVETODATEKEY,
	EFFECTIVETODATEKEY_NEW,
	CREATEDON
) as 
SELECT
    MaterialKey
  , EffectiveFromDateKey
  , EffectiveToDateKey
  ,  CASE   
        WHEN lag(EffectiveFromDateKey) OVER ( PARTITION BY MaterialKey ORDER BY EffectiveFromDateKey DESC, EffectiveToDateKey DESC,CreatedOn DESC)  IS NULL 
     THEN '9999-12-31'
     else 
          dateadd( day, -1, lag(EffectiveFromDateKey) over ( PARTITION BY MaterialKey ORDER BY EffectiveFromDateKey DESC, EffectiveToDateKey DESC,CreatedOn DESC) ) 
       end EffectiveToDateKey_New
  ,CreatedOn
FROM 
    sap.FactMaterialSellPriceHistory;