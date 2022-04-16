create or replace view V_FACTMRP_HISTORICAL(
	MRPNUMBER,
	MRPITEM,
	MRPSCENARIO,
	PLANTKEY,
	MATERIALKEY,
	MRPTYPEKEY,
	MRPTYPESTANDARDCODE,
	AMLKEY,
	ROW_ID,
	PLANNINGPLANTKEY,
	SUPPLIERKEY,
	MRPCURRENTDATEKEY,
	RECEIPTREQUIREMENTDATEKEY,
	DELIVERYFINISHDATEKEY,
	STARTRELEASEDATEKEY,
	OPENINGDATEKEY,
	RESCHEDULETODATEKEY,
	PARENTMATERIALKEY,
	REQUISITIONDATEKEY,
	PURCHASESCHEDULETYPEKEY,
	MRPELEMENTINDICATOR,
	MRPDOCUMENTTYPECODE,
	BASEUNITOFMEASURE,
	MRPPROCESSEDFLAG,
	LOWLEVELCODE,
	MRPAREA,
	MRPPLANNINGSEGMENT,
	QUANTITY,
	DOCUMENTNUMBER,
	DOCUMENTITEM,
	DOCUMENTSCHEDULELINE,
	RECEIPTISSUEINDICATOR,
	FIRMEDORDERFLAG,
	FIRMEDCOMPONENTFLAG,
	AVAILABILITY,
	DOCUMENTNUMBER2,
	ORDERTYPE,
	CUSTOMERKEY,
	MRPRECOMMENDATIONCODE,
	MRPRECOMMENDATIONCODE2,
	SRCLASTMODIFIEDDATE,
	HASH_VALUE,
	DATASOURCEKEY,
	SNAPSHOT_,
	CANCELLATIONLEADTIME
) as
/*--------------------------------------------------------------------------------------------

This view is used to insert data into SAP.FactMRP
----------------------------------------------------------------------------------------------
Revision History
----------------------------------------------------------------------------------------------
Date            Developer               Comments
----------------------------------------------------------------------------------------------
2021-03-03      Carlos Carrillo             Initial Revision
                                        
*/ 

SELECT 
		FQ.MRPNumber
      , FQ.MRPItem
      , FQ.MRPScenario
      , FQ.PlantKey
      , FQ.MaterialKey
      , FQ.MRPTypeKey
      , FQ.MRPTypeStandardCode
      , FQ.AMLKey
      , FQ.Row_ID
      , FQ.PlanningPlantKey
      , FQ.SupplierKey
      , FQ.MRPCurrentDateKey
      , FQ.ReceiptRequirementDateKey
      , FQ.DeliveryFinishDateKey
      , FQ.StartReleaseDateKey
      , FQ.OpeningDateKey
      , FQ.RescheduleToDateKey
      , FQ.ParentMaterialKey
      , FQ.RequisitionDateKey
      , FQ.PurchaseScheduleTypeKey
      , FQ.MRPElementIndicator
      , FQ.MRPDocumentTypeCode
      , FQ.BaseUnitOfMeasure
      , FQ.MRPProcessedFlag
      , FQ.LowLevelCode
      , FQ.MRPArea
      , FQ.MRPPlanningSegment
      , FQ.Quantity
      , FQ.DocumentNumber
      , FQ.DocumentItem
      , FQ.DocumentScheduleLine
      , FQ.ReceiptIssueIndicator
      , FQ.FirmedOrderFlag
      , FQ.FirmedComponentFlag
      , FQ.Availability
      , FQ.DocumentNumber2
      , FQ.OrderType
      , FQ.CustomerKey
      , FQ.MRPRecommendationCode
      , FQ.MRPRecommendationCode2
      , FQ.SrcLastModifiedDate
      , FQ.HASH_VALUE 
		, 1 AS DataSourceKey
        ,FQ.SNAPSHOT_
       ,IFNULL(cancellationleadtime,0) as cancellationleadtime
    FROM 
    (
        SELECT 
            ESMD.MRPNumber,
            MRPItem,
            ESMD.MRPScenario,
            IFNULL(DP.PlantKey,0) PlantKey,
            IFNULL(DPP.MaterialKey,0) MaterialKey,
            IFNULL(MT.MRPTypeKey,0) MRPTypeKey,
            IFNULL(MT.MRPTypeStandardCode,'') as MRPTypeStandardCode,
            IFNULL(DA.AMLKey,0) AMLKey,
            ROW_NUMBER() over 
                (Partition by 
                    ESMD.MRPNumber
                    ,ESMD.MRPItem
                    ,ESMD.SiteCode
                    ,ESMD.SitePartCode 
                  ORDER by 
                    ESMD.MRPNumber
                    ,ESMD.MRPItem
                    ,ESMD.SiteCode
                    ,ESMD.SitePartCode Desc 
                   ) AS Row_ID,
            IFNULL(PP.PlantKey ,0) PlanningPlantKey,
            IFNULL(DS.SupplierKey,0) SupplierKey,            
            CASE 
                WHEN LEFT(ESMD.MRPCurrentAsOFDTS,1) ='0' THEN Left(ESMD.MRPCurrentAsOFDTS,9)
                ELSE Left(ESMD.MRPCurrentAsOFDTS,8)
            END AS MRPCurrentDateKey,
            ESMD.ReceiptRequirementDTS ReceiptRequirementDateKey,
            ESMD.DeliveryFinishDTS DeliveryFinishDateKey,
            ESMD.StartReleaseDTS StartReleaseDateKey,
            ESMD.OpeningDTS OpeningDateKey,
            ESMD.MRPCalcDate RescheduleToDateKey,
            IFNULL(PPP.MaterialKey ,0) ParentMaterialKey,
            IFNULL( ESMD.ReqDate , '19000101' ) RequisitionDateKey,
            IFNULL(DPST.PurchaseScheduleTypeKey,0) PurchaseScheduleTypeKey,
            CASE WHEN DPST.PurchaseScheduleTypeKey IS NULL THEN ESMD.MRPElementIndicator ELSE '' END MRPElementIndicator,
            ESMD.MRPDocumentTypeCode,
            ESMD.BaseUnitOfMeasureDSCode BaseUnitOfMeasure,
            MRPProcessedFlag,
            LowLevelCode,
            MRPArea,
            MRPPlanningSegment,
            DocumentItem,
            DocumentScheduleLine,
            ReceiptIssueIndicator,
            FirmedOrderFlag,
            FirmedComponentFlag,
            Availability,
            DocumentNumber2,
            ESMD.POOrderType OrderType,
			MRPRecommendationCode, 
			MRPRecommendationCode2, 
            ESMD.updated_on SrcLastModifiedDate,
            Quantity,
            ESMD.DOCUMENTNUMBER,
            IFNULL( DPP.MaterialGroupKey, 0 ) AS CustomerKey,
            ESMD.SNAPSHOT_
            ,ESMD.cancellationleadtime
            ,HASH(ESMD.MRPNumber
            ,ESMD.MRPItem
            ,ESMD.MRPScenario
            ,DP.PlantKey
            ,DPP.MaterialKey
            ,MRPTypeKey
            ,MRPTypeStandardCode
            ,DA.AMLKey
            ,PP.PlantKey
            ,DS.SupplierKey
            ,ESMD.MRPCurrentAsOFDTS
            ,ESMD.ReceiptRequirementDTS
            ,ESMD.DeliveryFinishDTS
            ,ESMD.StartReleaseDTS
            ,ESMD.OpeningDTS
            ,ESMD.MRPCalcDate
            ,PPP.MaterialKey
            ,ESMD.ReqDate
            ,DPST.PurchaseScheduleTypeKey
            ,DPST.PurchaseScheduleTypeKey 
			,ESMD.MRPElementIndicator
            ,ESMD.MRPDocumentTypeCode
            ,ESMD.BaseUnitOfMeasureDSCode
            ,MRPProcessedFlag
            ,LowLevelCode
            ,MRPArea
            ,MRPPlanningSegment
            ,Quantity
            ,ESMD.DocumentNumber
            ,DocumentItem
            ,DocumentScheduleLine
            ,ReceiptIssueIndicator
            ,FirmedOrderFlag
            ,FirmedComponentFlag
            ,Availability
            ,DocumentNumber2
            ,ESMD.POOrderType
            ,ESMD.MRPRecommendationCode
            ,ESMD.MRPRecommendationCode2
            , ESMD.SNAPSHOT_
            ,cancellationleadtime
        ) as HASH_VALUE
    FROM 
    (
        SELECT 
			MRPNumber
			, MRPItem
			, MRPTypeCode
			, MRPArea
			, MRPPlanningSegment
			, LEFT(ReceiptRequirementDTS,8) ReceiptRequirementDTS
			, LEFT(DeliveryFinishDTS,8) DeliveryFinishDTS
			, LEFT(StartReleaseDTS,8) StartReleaseDTS
			, LEFT(OpeningDTS,8) OpeningDTS
			, LEFT(MRPCalcDate,8) MRPCalcDate
			, MRPElementIndicator
			, MRPElementIndicator MRPDocumentTypeCode
			, Quantity
			, DocumentNumber
			, DocumentItem
			, DocumentScheduleLine
			, ParentSitePartCode
			, ReceiptIssueIndicator
			, SiteCode
			, SitePartCode
			, MRPScenario
			, FixedVendor
			, MPNMaterial
			, FirmedOrderFlag
			, FirmedComponentFlag
			, Availability
			, DocumentNumber2
			, MRPRecommendationCode
			, MRPRecommendationCode2
			, POOrderType
			, PlanningProductionPlant
			, ProductionVersion
			, LEFT(ReqDate,8) ReqDate            
			, updated_on
            , MDTB_SNAPSHOTDATE AS SNAPSHOT_
            , IFNULL(cancellationleadtime,0) as cancellationleadtime
            , MRPCURRENTASOFDTS
            , BASEUNITOFMEASUREDSCODE
            , '' AS MRPPROCESSEDFLAG
            , '' AS LOWLEVELCODE
    FROM
        CONFORMED.V_ECC_HA_MRPDETAIL_historical a ) ESMD --SELECT DISTINCT  MDTB_SNAPSHOTDATE FROM  CONFORMED.V_ECC_HA_MRPDETAIL_historical
        /*INNER JOIN CONFORMED.V_ECC_HA_MRPHEADER ESMH ON 
            ESMD.MRPNumber=ESMH.MRPNumber
            --and ESMD.SNAPSHOT_ >= DATEADD(day,0,current_date)*/
        INNER JOIN SAP.DimPlants DP ON 
            LTRIM(RTRIM( ESMD.SiteCode))=DP.PlantCode
			AND DP.DataSourceKey = 1 
        LEFT JOIN SAP.DimPlants PP ON 
            LTRIM(RTRIM(ESMD.PlanningProductionPlant))=PP.PlantCode
			AND PP.DataSourceKey = 1 
        INNER JOIN SAP.DimMaterials DPP ON 
            (RTRIM(ESMD.SitePartCode)) = DPP.MaterialCode 
            AND DP.PlantKey = DPP.PlantKey
            AND DPP.MaterialKey > 0
		  AND DPP.DataSourceKey = 1 
        LEFT JOIN SAP.DimMaterials PPP ON 
            (RTRIM(ESMD.ParentSitePartCode))=PPP.MaterialCode
            AND DP.PlantKey = PPP.PlantKey
			AND PPP.DataSourceKey = 1 
        LEFT JOIN (
					SELECT 
						DIMAMLINTERNAL.AMLKey
                      , DIMAMLINTERNAL.AMLReference
                      , DIMAMLINTERNAL.PlantKey
                      , DIMAMLINTERNAL.EffectiveFromDateKey
                      , DIMAMLINTERNAL.EffectiveToDateKey
                      , DIMAMLINTERNAL.rn 
                    FROM 
						(
							SELECT 
								  AMLKey
								, AMLReference
								, PlantKey
								, EffectiveFromDateKey
								, EffectivetoDateKey
								, ROW_NUMBER() OVER (PARTITION BY AMLReference,PlantKey ORDER By EffectivetoDateKey,AMLkey ) as rn 
							FROM 
								SAP.DimAML
							WHERE 
								DataSourceKey = 1 
						) DIMAMLINTERNAL 
					WHERE 
						DIMAMLINTERNAL.rn = 1) DA ON 
				LTRIM(RTRIM(ESMD.MPNMaterial)) = DA.AMLReference
				AND DA.PlantKey  = DP.PlantKey
			LEFT JOIN 
				(
					SELECT 
						  SupplierKey
						, SupplierCode
						, row_number() over (PARTITION BY SupplierCode ORDER BY SupplierKey) AS RN
						, DataSourceKey
					FROM 
						SAP.DimSuppliers
					WHERE 
						DataSourceKey = 1 
				) DS ON 
					LTRIM(RTRIM(ESMD.FixedVendor))=DS.SupplierCode 
					AND DS.RN = 1
					
			LEFT OUTER JOIN SAP.DimPurchaseScheduleTypes DPST 
				ON LTRIM(RTRIM(ESMD.MRPElementIndicator))=DPST.PurchaseScheduleTypeCode
				AND DPST.DataSourceKey = 1 
			LEFT OUTER JOIN SAP.DimMRPTypes MT 
				ON LTRIM(RTRIM(ESMD.MRPTypeCode))=MT.MRPTypeCode
				AND MT.DataSourceKey = 1 
		) FQ
	WHERE 
		FQ.Row_ID = 1
        
union all


SELECT 
		TO_VARCHAR( FQ.MRPNumber  ) AS MRPNumber
      , FQ.MRPItem
      , FQ.MRPScenario
      , FQ.PlantKey
      , FQ.MaterialKey
      , FQ.MRPTypeKey
      , FQ.MRPTypeStandardCode
      , FQ.AMLKey
      , FQ.Row_ID
      , FQ.PlanningPlantKey
      , FQ.SupplierKey
      , FQ.MRPCurrentDateKey
      , FQ.ReceiptRequirementDateKey
      , FQ.DeliveryFinishDateKey
      , FQ.StartReleaseDateKey
      , FQ.OpeningDateKey
      , FQ.RescheduleToDateKey
      , FQ.ParentMaterialKey
      , FQ.RequisitionDateKey
      , FQ.PurchaseScheduleTypeKey
      , FQ.MRPElementIndicator
      , FQ.MRPDocumentTypeCode
      , FQ.BaseUnitOfMeasure
      , FQ.MRPProcessedFlag
      , FQ.LowLevelCode
      , FQ.MRPArea
      , FQ.MRPPlanningSegment
      , FQ.Quantity
      , FQ.DocumentNumber
      , FQ.DocumentItem
      , FQ.DocumentScheduleLine
      , FQ.ReceiptIssueIndicator
      , FQ.FirmedOrderFlag
      , FQ.FirmedComponentFlag
      , FQ.Availability
      , FQ.DocumentNumber2
      , FQ.OrderType
      , FQ.CustomerKey
      , FQ.MRPRecommendationCode
      , FQ.MRPRecommendationCode2
      , FQ.SrcLastModifiedDate
      , FQ.HASH_VALUE 
	  , FQ.DataSourceKey
      , FQ.Snapshot_
      , IFNULL(FQ.cancellationleadtime,0) as cancellationleadtime
    FROM 
    (
        SELECT 
            ESMD.MRPNumber,
            MRPItem,
            ESMD.MRPScenario,
            IFNULL(DP.PlantKey,0) PlantKey,
            IFNULL(DPP.MaterialKey,0) MaterialKey,
            IFNULL(MT.MRPTypeKey,0) MRPTypeKey,
            IFNULL(MT.MRPTypeStandardCode,'') MRPTypeStandardCode,
            IFNULL(DA.AMLKey,0) AMLKey,
            1 AS Row_ID,
            IFNULL(PP.PlantKey ,0) PlanningPlantKey,
            IFNULL(DS.SupplierKey,0) SupplierKey,            
            CASE 
                WHEN LEFT(ESMD.MRPCurrentAsOFDTS,1) ='0' THEN Left(ESMD.MRPCurrentAsOFDTS,9)
                ELSE Left(ESMD.MRPCurrentAsOFDTS,8) 
            END AS MRPCurrentDateKey,
            ESMD.ReceiptRequirementDTS ReceiptRequirementDateKey,
            ESMD.DeliveryFinishDTS DeliveryFinishDateKey,
            ESMD.StartReleaseDTS StartReleaseDateKey,
            ESMD.OpeningDTS OpeningDateKey,
            ESMD.MRPCalcDate RescheduleToDateKey,
            IFNULL(PPP.MaterialKey ,0) ParentMaterialKey,
            IFNULL( ESMD.ReqDate , '19000101' ) RequisitionDateKey,
            IFNULL(DPST.PurchaseScheduleTypeKey,0) PurchaseScheduleTypeKey,
            CASE WHEN DPST.PurchaseScheduleTypeKey IS NULL THEN ESMD.MRPElementIndicator ELSE '' END MRPElementIndicator,
            ESMD.MRPDocumentTypeCode,
            ESMD.BaseUnitOfMeasureDSCode BaseUnitOfMeasure,
            MRPProcessedFlag,
            LowLevelCode,
            MRPArea,
            MRPPlanningSegment,
            Quantity,
            ESMD.DocumentNumber,
            DocumentItem,
            DocumentScheduleLine,
            ReceiptIssueIndicator,
            FirmedOrderFlag,
            FirmedComponentFlag,
            Availability,
            DocumentNumber2,
            ESMD.POOrderType OrderType,
			MRPRecommendationCode, 
			MRPRecommendationCode2, 
            ESMD.updated_on SrcLastModifiedDate,
            IFNULL( DPP.MaterialGroupKey, 0 ) AS CustomerKey,
            ESMD.Snapshot_,
            ESMD.cancellationleadtime
            ,HASH(ESMD.MRPNumber
            ,TO_VARCHAR(ESMD.MRPItem)
            ,ESMD.MRPScenario
            ,TO_VARCHAR(DP.PlantKey)
            ,TO_VARCHAR(DPP.MaterialKey)
            ,TO_VARCHAR(MRPTypeKey)
            ,MRPTypeStandardCode                  
            ,TO_VARCHAR(DA.AMLKey)
            ,TO_VARCHAR(PP.PlantKey)
            ,TO_VARCHAR(DS.SupplierKey)
            ,TO_VARCHAR(Left(ESMD.MRPCurrentAsOFDTS,8))
            ,TO_VARCHAR(ESMD.ReceiptRequirementDTS)
            ,TO_VARCHAR(ESMD.DeliveryFinishDTS)
            ,TO_VARCHAR(ESMD.StartReleaseDTS)
            ,TO_VARCHAR(ESMD.OpeningDTS)
            ,TO_VARCHAR(ESMD.MRPCalcDate)
            ,TO_VARCHAR(PPP.MaterialKey)
            ,TO_VARCHAR(ESMD.ReqDate)
            ,TO_VARCHAR(DPST.PurchaseScheduleTypeKey)
            ,DPST.PurchaseScheduleTypeKey
			,ESMD.MRPElementIndicator
            ,ESMD.MRPDocumentTypeCode
            ,ESMD.BaseUnitOfMeasureDSCode
            ,MRPProcessedFlag
            ,LowLevelCode
            ,MRPArea
            ,MRPPlanningSegment
            ,TO_VARCHAR(Quantity)
            ,TO_VARCHAR(ESMD.DocumentNumber)
            ,TO_VARCHAR(DocumentItem)
            ,TO_VARCHAR(DocumentScheduleLine)
            ,ReceiptIssueIndicator
            ,FirmedOrderFlag
            ,FirmedComponentFlag
            ,Availability
            ,DocumentNumber2
            ,ESMD.POOrderType
            ,ESMD.MRPRecommendationCode
            ,ESMD.MRPRecommendationCode2
            ,ESMD.Snapshot_
            ,ESMD.cancellationleadtime
        ) as HASH_VALUE
		, 2 as DataSourceKey 
    FROM 
    (
        SELECT 
			  RCOUNT AS MRPNumber
			, '' AS MRPItem
			, CONCAT(delkz , 
					 ( CASE 
						 WHEN COALESCE((CASE WHEN  delkz ='FE' THEN 'X' ELSE fix01 END),'0')='X' AND COALESCE((CASE WHEN  delkz ='FE' THEN 'X' ELSE fix02 END), '0' ) = 'X' AND RTRIM(LTRIM(delkz))  <> 'VJ' 
						 THEN '-XX' 
						 WHEN COALESCE((CASE WHEN  delkz ='FE' THEN 'X' ELSE fix01 END),'0')='X' AND (CASE WHEN  delkz ='FE' THEN 'X' ELSE fix02 END) IS NULL AND RTRIM(LTRIM( delkz )) <> 'VJ' 
						 THEN '-X' 
						 WHEN RTRIM(LTRIM(delkz)) = 'PP' AND RTRIM(LTRIM(baart)) = 'SAFT' 
						 THEN CONCAT('-' , 'SAFT') 
						 WHEN LEN(COALESCE(PlanningStrategyGroup,'')) > 0 
						 THEN CONCAT('-' , COALESCE( PlanningStrategyGroup, '' ) )
                         ELSE '' 
					   END 
					  ) 
					, 
					 ( CASE 
						 WHEN COALESCE( vrfkz, '0' ) = 'X' AND plumi = '-' 
						 THEN CONCAT('-' , 'N') 
						ELSE '' 
						 END 
					 )
					)
				 AS MRPTypeCode
			, wrk01 AS MRPArea
			, '' AS MRPPlanningSegment
			, IFNULL(dstmp,0) AS MRPCurrentAsOFDTS
			, meins AS BaseUnitOfMeasureDSCode
			, '' AS MRPProcessedFlag
			, disst AS LowLevelCode
			, LEFT(dat00,8) ReceiptRequirementDTS
			, LEFT(dat01,8) DeliveryFinishDTS
			, LEFT(dat02,8) StartReleaseDTS
			, LEFT('',8) OpeningDTS
			, LEFT(umdat,8) MRPCalcDate
			, delkz AS MRPElementIndicator
			, delkz AS MRPDocumentTypeCode
			, mng01 AS Quantity
			, CASE WHEN  delkz ='SB' THEN aufvr ELSE delnr END AS DocumentNumber
			, delps AS DocumentItem
			, delet AS DocumentScheduleLine
			, matnr AS  ParentSitePartCode
			, plumi AS ReceiptIssueIndicator
			, wrk01 AS  SiteCode
			, matnr AS	SitePartCode
			, '' AS  MRPScenario
			, CASE WHEN delkz = 'BA' then flief_eban
				   WHEN delkz = 'BE' or delkz = 'LA' or delkz ='SA' then lifnr
				   WHEN delkz = 'PA' then flief_plaf
			  ELSE ''
			  END AS  FixedVendor
			, '' AS  MPNMaterial
			, CASE WHEN  delkz ='FE' THEN 'X' ELSE fix01 END  AS FirmedOrderFlag
			, CASE WHEN  delkz ='FE' THEN 'X' ELSE fix02 END  AS FirmedComponentFlag
			, vrfkz AS Availability
			, del12 AS DocumentNumber2
			, aussl AS MRPRecommendationCode
			, oldsl AS MRPRecommendationCode2
			, ''	AS POOrderType
			, wrk02 AS PlanningProductionPlant
			, ''	AS ProductionVersion
			, LEFT('',8) ReqDate            
			, a.SNFLK_UPDATEDON	AS	updated_on
            , a.DATASOURCEKEY
            , A.Demand_Snapshot AS  Snapshot_
            , A.cancellationleadtime AS cancellationleadtime
		FROM
			conformed.V_HCC_HA_MRP a ) ESMD 
			LEFT JOIN SAP.DimPlants DP ON 
				LTRIM(RTRIM( ESMD.SiteCode))=DP.PlantCode
				AND DP.DataSourceKey = ESMD.DataSourceKey 
			LEFT JOIN SAP.DimPlants PP ON 
				LTRIM(RTRIM(ESMD.PlanningProductionPlant))=PP.PlantCode
				AND PP.DataSourceKey = ESMD.DataSourceKey   
			LEFT JOIN SAP.DimMaterials DPP ON 
				(RTRIM(ESMD.SitePartCode)) = DPP.MaterialCode 
				AND DP.PlantKey = DPP.PlantKey
				AND DPP.DataSourceKey = ESMD.DataSourceKey  
			LEFT JOIN SAP.DimMaterials PPP ON 
				(RTRIM(ESMD.ParentSitePartCode))=PPP.MaterialCode
				AND DP.PlantKey = PPP.PlantKey
				AND PPP.DataSourceKey = ESMD.DataSourceKey  
			LEFT JOIN (
						SELECT 
							DIMAMLINTERNAL.AMLKey
						  , DIMAMLINTERNAL.AMLReference
						  , DIMAMLINTERNAL.PlantKey
						  , DIMAMLINTERNAL.EffectiveFromDateKey
						  , DIMAMLINTERNAL.EffectiveToDateKey
						  , DIMAMLINTERNAL.rn 
						  , DIMAMLINTERNAL.DataSourceKey
						FROM 
							(
								SELECT 
									  AMLKey
									, AMLReference
									, PlantKey
									, EffectiveFromDateKey
									, EffectivetoDateKey
									, DataSourceKey
									, ROW_NUMBER() OVER (PARTITION BY AMLReference,PlantKey,DataSourceKey ORDER By EffectivetoDateKey,AMLkey ) as rn 
								FROM 
									SAP.DimAML
							) DIMAMLINTERNAL 
						WHERE 
							DIMAMLINTERNAL.rn = 1) DA ON LTRIM(RTRIM(ESMD.MPNMaterial)) = DA.AMLReference
							AND DA.PlantKey  = DP.PlantKey
							AND DA.DataSourceKey = ESMD.DataSourceKey
				LEFT JOIN 
					(
						SELECT 
							  SupplierKey
							, SupplierCode
							, row_number() over (PARTITION BY SupplierCode,DataSourceKey ORDER BY SupplierKey) AS RN
							, DataSourceKey
						FROM 
							SAP.DimSuppliers
					) DS ON 
						LTRIM(RTRIM(ESMD.FixedVendor))=DS.SupplierCode 
						AND DS.RN = 1
						AND DS.DataSourceKey = ESMD.DataSourceKey 
				LEFT OUTER JOIN SAP.DimPurchaseScheduleTypes DPST 
					ON LTRIM(RTRIM(ESMD.MRPElementIndicator))=DPST.PurchaseScheduleTypeCode
					AND DPST.DataSourceKey = ESMD.DataSourceKey  
				LEFT OUTER JOIN SAP.DimMRPTypes MT 
					ON LTRIM(RTRIM(ESMD.MRPTypeCode))=MT.MRPTypeCode
					AND MT.DataSourceKey = ESMD.DataSourceKey  
		)FQ
        WHERE 
            FQ.DataSourceKey <> 1;