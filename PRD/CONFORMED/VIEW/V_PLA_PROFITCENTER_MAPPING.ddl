create or replace view V_PLA_PROFITCENTER_MAPPING(
	PLANTCODE,
	MATERIALCODE,
	PROFITCENTERCODE
) as 
SELECT 
      PlantCode
    , MaterialCode
    , ProfitCenterCode
FROM
    (
        SELECT
              PlantCode
            , MaterialCode
            , IFF( right(ProfitCenterCode  ,1) = '_',  left(ProfitCenterCode, len(ProfitCenterCode)- 1 ) , ProfitCenterCode ) as ProfitCenterCode
            , Row_Number() Over(Partition By PlantCode, MaterialCode ORDER BY PlantCode ) RN
        FROM 
            CONFORMED.PLA_ProfitCenter_Mapping
    ) AS T
WHERE 
    RN = 1;