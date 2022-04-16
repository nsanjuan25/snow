create or replace view V_FACTMATERIALSOURCE(
	PLANTKEY,
	MATERIALKEY,
	SUPPLIERKEY,
	MATERIALSOURCETYPEKEY,
	PURCHASINGORGANIZATIONCODE,
	AMLKEY,
	FIXEDLEADTIME,
	CANCELLATIONLEADTIME,
	YIELD,
	ORDERUNITOFMEASURE,
	MAXIMUMLOTSIZE,
	MINIMUMLOTSIZE,
	MULTIPLEQUANTITY,
	NUMBEROFDAYSSUPPLY,
	PLANNINGTIMEFENCE,
	PRIORITY,
	TARGETRATIO,
	TODATEQTY,
	TRANSFERSITECODE,
	TRANSFERSITEPARTCODE,
	AMLREFERENCE,
	PURCHASEDOCUMENTNUMBER,
	PURCHASEDOCUMENTITEM,
	STATUSCODE,
	EFFECTIVEFROMDATE,
	EFFECTIVETODATE,
	MRPINDICATOR,
	SEQUENCENUMBER,
	DELETEFLAG,
	DSCREATEDDATE,
	HASH_VALUE,
	DATASOURCEKEY,
	MATERIALSOURCECATEGORYCODE
) as
/*--------------------------------------------------------------------

This view is used to ADD data into SAP.FactMaterialSource table
-----------------------------------------------------------------------
Revision History
-----------------------------------------------------------------------
Date            Developer               Comments
-----------------------------------------------------------------------
2021-03-22      Noel San Juan          Initial Revision
*/
SELECT    
	IFNULL(Plant.Plantkey,0)                                           AS PlantKey,
	IFNULL(Material.Materialkey,0)                                     AS MaterialKey,
	IFNULL(Supplier.SupplierKey,0)                                     AS SupplierKey,
	IFNULL(DimPPartSource.MaterialSourceTypeKey,0)                     AS MaterialSourceTypeKey,
	IFNULL(SourceInfo.PurchasingOrganizationCode,'')                   AS PurchasingOrganizationCode,
	IFNULL(AML.AMLKEY,0)                                               AS AMLKEY,    
	IFNULL(SourceInfo.FixedLeadTime,0)                                 AS FixedLeadTime,
	IFNULL(SourceInfo.CancellationLeadTime,0)                          AS CancellationLeadTime,
	IFNULL(SourceInfo.YIELD,0.00000)                                   AS YIELD,
	IFNULL(SourceInfo.OrderUnitOfMeasureDSCode,'')                     AS OrderUnitOfMeasure,
	IFNULL(SourceInfo.MaximumLotSize,0 )                               AS MaximumLotSize,
	IFNULL(SourceInfo.MinimumLotSize,0)                                AS MinimumLotSize,
    IFNULL(SourceInfo.MultipleQty,0)                                   AS MultipleQuantity,
	IFNULL(SourceInfo.numberofdayssupply,0)                            AS Numberofdayssupply,
	IFNULL(SourceInfo.planningtimefence,0)							   AS planningtimefence,
	IFNULL(SourceInfo.priority,0)									   AS priority,
	IFNULL(SourceInfo.targetratio,0)								   AS targetratio,
	IFNULL(SourceInfo.todateqty,0)								       AS todateqty,
    IFNULL(SourceInfo.transfersitecode,'')							   AS transfersitecode,
	IFNULL(SourceInfo.transfersitepartcode,'')						   AS transfersitepartcode,
	IFNULL(SourceInfo.amlreference,'')								   AS amlreference,
	IFNULL(SourceInfo.purchasedocumentnumber,'')					   AS purchasedocumentnumber,
    IFNULL(SourceInfo.purchasedocumentitem,'0')						   AS purchasedocumentitem,
	IFNULL(SourceInfo.StatusCode,'')								   AS StatusCode,
    CASE
	    WHEN SourceInfo.EffectiveFromDate = '00000000' THEN '1900-01-01'
		ELSE IFNULL ( TRY_TO_DATE(SourceInfo.EffectiveFromDate, 'YYYYMMDD' ), '1900-01-01')
	END AS EffectiveFromDate,
    CASE
	    WHEN SourceInfo.EffectiveToDate = '00000000' THEN '1900-01-01'
		ELSE IFNULL ( TRY_TO_DATE(SourceInfo.EffectiveToDate, 'YYYYMMDD' ), '1900-01-01')
	END AS EffectiveToDate,
	IFNULL( try_to_number(SourceInfo.MRPIndicator) ,'0')								   AS MRPIndicator,
	IFNULL(SourceInfo.SequenceNumber,'0')								   AS SequenceNumber,
	CASE UPPER(SourceInfo.DeleteFlag) 
		WHEN 'TRUE'  THEN 1 
		WHEN 'FALSE' THEN 0 
		ELSE 0 
	END																   AS DeleteFlag,
	LTRIM(RTRIM(SourceInfo.DSCreateDTS))                               AS DSCreatedDate,
	HASH
	(
		IFNULL(Plant.Plantkey,0),
        IFNULL(Material.Materialkey,0),
        IFNULL(Supplier.SupplierKey,0),
        IFNULL(DimPPartSource.MaterialSourceTypeKey,0),
        IFNULL(SourceInfo.PurchasingOrganizationCode,''),
        IFNULL(AML.AMLKEY,'0'),
        IFNULL(SourceInfo.FixedLeadTime,'0'),
        IFNULL(SourceInfo.CancellationLeadTime,'0'),--
        IFNULL(SourceInfo.YIELD,'0'),
        IFNULL(SourceInfo.MaximumLotSize,'0' ),
        IFNULL(SourceInfo.MinimumLotSize,'0'),
        IFNULL(SourceInfo.MultipleQty,'0'),
		IFNULL(SourceInfo.numberofdayssupply,'0'),
		IFNULL(SourceInfo.planningtimefence,''),
		IFNULL(SourceInfo.priority,''),
		IFNULL(SourceInfo.targetratio,'0'),
		IFNULL(SourceInfo.transfersitecode,''),
		IFNULL(SourceInfo.transfersitepartcode,''),
		IFNULL(SourceInfo.amlreference,''),
		IFNULL(SourceInfo.purchasedocumentnumber,''),
		IFNULL(SourceInfo.purchasedocumentitem,'0'),
		IFNULL(SourceInfo.StatusCode,''),
		SourceInfo.EffectiveFromDate,
		SourceInfo.EffectiveToDate,
		IFNULL(SourceInfo.MRPIndicator,'0') ,
		IFNULL(SourceInfo.SequenceNumber,'0'),
        IFNULL(SourceInfo.DeleteFlag,''),
        IFNULL(SourceInfo.DSCreateDTS, '') 
	) AS HASH_VALUE,
	SourceInfo.DataSourceKey,
	LTRIM(RTRIM(SourceInfo.Materialsourcecategorycode)) AS Materialsourcecategorycode

FROM 
	CONFORMED.V_SAP_SITEPARTSOURCE AS SourceInfo
	LEFT OUTER JOIN PUBLIC.DIMDATASOURCES AS DS ON DS.DataSourceKey = SourceInfo.DataSourceKey
    LEFT OUTER JOIN SAP.DimPlants AS Plant	
		ON  LTRIM(RTRIM(SourceInfo.PlantCode)) = Plant.PlantCode 
        AND DS.DataSourceKey = Plant.DataSourceKey
    LEFT OUTER JOIN  SAP.DimMaterials AS Material 
		ON  LTRIM(RTRIM(SourceInfo.MaterialCode)) = Material.MaterialCode 
        AND Plant.PlantKey = Material.PlantKey
        AND DS.DataSourceKey = Material.DataSourceKey
    LEFT OUTER JOIN SAP.DimMaterialSourceTypes AS DimPPartSource 
		ON DimPPartSource.MaterialSourceTypeCode = LTRIM(RTRIM(SourceInfo.MaterialSourceTypeCode))
        AND DimPPartSource.DataSourceKey = DS.DataSourceKey
    LEFT OUTER JOIN SAP.DimSuppliers AS Supplier        
        ON  Supplier.SupplierCode = LTRIM(RTRIM(SourceInfo.SupplierCorporationDsCode))
        AND Supplier.SupplierTypeCode = LTRIM(RTRIM(SourceInfo.CorporationdSTypeCode))
        AND DS.DataSourceKey = Supplier.DataSourceKey
    LEFT OUTER JOIN 
    (
        SELECT 
            AMLKey,
			AMLReference,
			PlantKey,
			EffectiveFromDateKey,
			EffectivetoDateKey,
			ManufacturerPartKey,
			DataSourceKey,
			rn
        FROM 
        (
			SELECT 
				DAI.AMLKey,
				DAI.AMLReference,
				DAI.PlantKey,
				DAI.EffectiveFromDateKey,
				DAI.EffectivetoDateKey,
				DAI.ManufacturerPartKey,
				DAI.DataSourceKey,
				 ROW_NUMBER() OVER 
				 (
					PARTITION BY 
						DAI.AMLReference, 
						DAI.PlantKey, 
						DAI.EffectiveFromDateKey, 
						DAI.DataSourceKey
					ORDER BY 
						DAI.EffectivetoDateKey, 
						DAI.AMLkey 
				) as rn 
			FROM 
				SAP.DimAML DAI
         ) DIMAMLINTERNAL
         WHERE 
            DIMAMLINTERNAL.rn = 1
	) AML ON  LTRIM(RTRIM(SourceInfo.AMLReference)) = AML.AMLReference 
    AND Plant.Plantkey = AML.PlantKey 
    AND AML.EffectiveFromDateKey <=  try_to_date(SourceInfo.DSCreateDTS , 'YYYYMMDD') -- LTRIM(RTRIM(SourceInfo.DSCreateDTS))
    AND AML.EffectiveToDateKey   >   try_to_date(SourceInfo.DSCreateDTS , 'YYYYMMDD') --LTRIM(RTRIM(SourceInfo.DSCreateDTS))
    AND DS.DataSourceKey = AML.DataSourceKey;