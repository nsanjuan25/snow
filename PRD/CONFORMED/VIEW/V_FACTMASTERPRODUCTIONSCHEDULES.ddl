create or replace view V_FACTMASTERPRODUCTIONSCHEDULES(
	MRPSNAPSHOTDATEKEY,
	DATASOURCEKEY,
	PLANTKEY,
	MATERIALKEY,
	MATERIALGROUPKEY,
	DELIVERYFINISHDATEKEY,
	SALESDOCUMENTNUMBER,
	SALESDOCUMENTITEM,
	SALESSCHEDULELINE,
	PLANNINGPLANTKEY,
	PROFITCENTERCODE,
	MRPDOCUMENTTYPECODE,
	QUANTITY
) as 
SELECT 
      FM.MRPCurrentDateKey      AS MRPSnapshotDateKey
    , FM.DataSourceKey
    , FM.PlantKey
    , FM.MaterialKey 
    , DM.MaterialGroupKey
    , FM.DeliveryFinishDateKey
    , FM.DocumentNumber         AS SalesDocumentNumber
    , FM.DocumentItem           AS SalesDocumentItem
    , FM.DocumentScheduleLine   AS SalesScheduleLine
    , FM.PlanningPlantKey     
    , DM.ProfitCenterCode
    , FM.MRPDocumentTypeCode    
    , FM.Quantity
FROM 
    sap.FactMRP AS FM
    INNER JOIN sap.DimMaterials AS DM  ON DM.MaterialKey = FM.MaterialKey
    INNER JOIN sap.DimMRPTypes  AS DMT ON DMT.MRPTypeKey = FM.MRPTypeKey
    INNER JOIN sap.DimPlants    AS DP  ON FM.PlantKey    = DP.PlantKey
WHERE 
    FM.MRPDocumentTypeCode  in ('PP','U2','U3','U4','VB','VC','VE','VF','VI','VJ','U1')
    AND DMT.MRPTypeStandardCode <>'Allocation'
    AND FM.Availability = 'X'
    AND DMT.DemandSupplyIndicator = '-'
    AND 
    (
        FM.MRPPlanningSegment = '' 
        OR 
        (
            LEN(FM.MRPPlanningSegment) > 10
            AND CAST(TRY_TO_NUMBER( RIGHT(FM.MRPPlanningSegment ,10) ) AS bigint) > 10
        )
   );