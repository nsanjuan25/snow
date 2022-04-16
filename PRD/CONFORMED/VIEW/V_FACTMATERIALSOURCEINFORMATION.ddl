create or replace view V_FACTMATERIALSOURCEINFORMATION(
	DATASOURCEKEY,
	PLANTKEY,
	MATERIALKEY,
	SUPPLIERKEY,
	MATERIALSOURCETYPECODE,
	MATERIALSOURCETYPEKEY,
	PURCHASINGORGANIZATIONCODE,
	AMLKEY,
	MANUFACTURERKEY,
	MANUFACTURERPARTKEY,
	MATERIALSOURCEREFERENCE,
	FIXEDLEADTIME,
	CANCELLATIONLEADTIME,
	YIELD,
	ORDERUNITOFMEASURE,
	MAXIMUMLOTSIZE,
	MINIMUMLOTSIZE,
	MULTIPLEQUANTITY,
	PRICEUNIT,
	UNITPRICECURRENT,
	UNITPRICEFUTURE,
	UNITPRICECURRENTBASEUOM,
	UNITPRICEFUTUREBASEUOM,
	UNITPRICEFUTUREEFFECTIVEFROMDATEKEY,
	UNITPRICEFUTUREEFFECTIVETODATEKEY,
	DELETEFLAG,
	BASEUNITOFMEASURE,
	CURRENCYCODE,
	EXCHANGERATEKEY,
	SRCLASTMODIFIEDDATE,
	DSCREATEDDATE,
	HASH_VALUE
) as
/*--------------------------------------------------------------------

This view is used to insert data in SAP.FACTMATERIALSOURCEINFORMATION
-----------------------------------------------------------------------
Revision History
-----------------------------------------------------------------------
Date            Developer               Comments
-----------------------------------------------------------------------
2021-03-05      Noel San Juan          Initial Revision
*/
SELECT *
FROM
(	
	SELECT DISTINCT
		SourceInfo.DataSourceKey,
		IFNULL(Plant.Plantkey,0)                                           AS PlantKey,
		IFNULL(Material.Materialkey,0)                                     AS MaterialKey,
		IFNULL(Supplier.SupplierKey,0)                                     AS SupplierKey,
		IFNULL(SourceInfo.SitePartSourceTypeCode,'')                       AS MaterialSourceTypeCode,
		IFNULL(DimPPartSource.MaterialSourceTypeKey,0)                     AS MaterialSourceTypeKey,
		IFNULL(LTRIM(RTRIM(SourceInfo.PurchasingOrganizationCode)),'')     AS PurchasingOrganizationCode,
		IFNULL(AML.AMLKEY,0)                                               AS AMLKEY,
		IFNULL(MFR.Manufacturerkey,0)                                      AS ManufacturerKey,
		IFNULL(MFRPart.ManufacturerPartKey,0)                              AS ManufacturerPartKey,
		IFNULL(SourceInfo.SitePartSourceInformationReference,'')           AS MaterialSourceReference,
		IFNULL(SourceInfo.FixedLeadTime,0)                                 AS FixedLeadTime,
		IFNULL(SourceInfo.CancellationLeadTime,0)                          AS CancellationLeadTime,
		IFNULL(SourceInfo.YIELD,0)										   AS YIELD,
		IFNULL(SourceInfo.OrderUnitOfMeasureDSCode,'')                     AS OrderUnitOfMeasure,
		IFNULL(SourceInfo.MaximumLotSize,0 )                               AS MaximumLotSize,
		IFNULL(SourceInfo.MinimumLotSize,0)                                AS MinimumLotSize,
		IFNULL(SourceInfo.MultipleQty,0)                                   AS MultipleQuantity,
		IFNULL(SourceInfo.PriceUnit,0)                                     AS PriceUnit,
		IFNULL(SourceInfo.UnitPriceCurrent,0)  AS UnitPriceCurrent,  ---* IFNULL(DCDP.ExponentFactor,1) AS UnitPriceCurrent,
		IFNULL(SourceInfo.UnitPriceFuture, 0)  AS UnitPriceFuture,   ---* IFNULL(DCDP.ExponentFactor,1) AS UnitPriceFuture,		
		CASE 
			WHEN IFNULL(MDS.AlternateToBaseConversionRate,0) = 0 THEN SourceInfo.UnitPriceCurrent ---* IFNULL(DCDP.ExponentFactor,1)
			ELSE 
			(
				ifnull(SourceInfo.UnitPriceCurrent,'0.00000') / IFNULL(MDS.AlternateToBaseConversionRate,1) 
			) ----* IFNULL(DCDP.ExponentFactor,1)
			END AS UnitPriceCurrentBaseUOM,
		CASE 
			WHEN IFNULL(MDS.AlternateToBaseConversionRate,0) = 0 THEN SourceInfo.UnitPriceFuture ----* IFNULL(DCDP.ExponentFactor,1)
			ELSE 
			(
				ifnull(SourceInfo.UnitPriceFuture,'0.00000') / IFNULL(MDS.AlternateToBaseConversionRate,1)
			) ----* IFNULL(DCDP.ExponentFactor,1)
		END AS UnitPriceFutureBaseUOM,
		CASE
			WHEN SourceInfo.UnitPriceFutureEffectiveFromDate = '00000000' THEN '1900-01-01'
			ELSE IFNULL(TO_DATE(SourceInfo.UnitPriceFutureEffectiveFromDate, 'YYYYMMDD' ), '1900-01-01') 
		END AS UnitPriceFutureEffectiveFromDateKey,
		CASE
			WHEN SourceInfo.UnitPriceFutureEffectiveToDate = '00000000' THEN '1900-01-01'
			ELSE IFNULL(TO_DATE(SourceInfo.UnitPriceFutureEffectiveToDate, 'YYYYMMDD' ), '1900-01-01') 
		END AS UnitPriceFutureEffectiveToDateKey,
		CASE UPPER(SourceInfo.DeleteFlag) 
			WHEN 'TRUE'  THEN 1 
			WHEN 'FALSE' THEN 0 
			ELSE 0 END                                                       AS DeleteFlag,
		IFNULL(SourceInfo.BaseUnitOfMeasure,'')                              AS BaseUnitOfMeasure,
		IFNULL(SourceInfo.CurrencyCode,'')                                   AS CurrencyCode,
		LEFT(IFNULL(Currency.ExchangeRateKey,00000000),8)                    AS ExchangeRateKey,
		SourceInfo.Updated_On												 AS SRCLASTMODIFIEDDATE,
--		LTRIM(RTRIM(SourceInfo.DSCreateDTS))                                 AS DSCreatedDate,
  		try_to_date(SourceInfo.DSCreateDTS , 'YYYYMMDD')                                 AS DSCreatedDate,
	   HASH
	   (
			IFNULL(Plant.Plantkey,0),
			IFNULL(Material.Materialkey,0),
			IFNULL(Supplier.SupplierKey,0),
			IFNULL(DimPPartSource.MaterialSourceTypeKey,0),
			IFNULL(SourceInfo.PurchasingOrganizationCode,''),
			IFNULL(AML.AMLKEY,0),
			IFNULL(MFR.Manufacturerkey,0),
			IFNULL(MFRPart.ManufacturerPartKey,0),
			IFNULL(SourceInfo.SitePartSourceInformationReference,0),
			IFNULL(SourceInfo.FixedLeadTime,0),
			IFNULL(SourceInfo.CancellationLeadTime,0),
			IFNULL(SourceInfo.YIELD,0),
			IFNULL(SourceInfo.MaximumLotSize,0),
			IFNULL(SourceInfo.MinimumLotSize,0),
			IFNULL(SourceInfo.MultipleQty,0),
			IFNULL(SourceInfo.PriceUnit,0),
			IFNULL(SourceInfo.UnitPriceCurrent,0),
			IFNULL(MDS.AlternateToBaseConversionRate,0),
			IFNULL(SourceInfo.UnitPriceFuture, 0),
			IFNULL(SourceInfo.UnitPriceFutureEffectiveFromDate,''),
			IFNULL(SourceInfo.UnitPriceFutureEffectiveToDate,''),
			IFNULL(SourceInfo.DeleteFlag,''),
			IFNULL(SourceInfo.BaseUnitOfMeasure,''),
			IFNULL(SourceInfo.CurrencyCode,''),
			IFNULL(SourceInfo.DSCreateDTS, ''), 
			IFNULL(Currency.ExchangeRateKey,0)
		) AS HASH_VALUE  
	FROM 
		CONFORMED.V_ECC_HA_FactMaterialSourceInformation SourceInfo 
		LEFT OUTER JOIN SAP.DIMPLANTS Plant ON  LTRIM(RTRIM(SourceInfo.SiteCode)) = Plant.PlantCode 
			AND Plant.DataSourceKey = SourceInfo.DataSourceKey
		INNER JOIN  SAP.DIMMATERIALS Material ON  LTRIM(RTRIM(SourceInfo.SitePartCode)) = Material.MaterialCode 
			AND Plant.PlantKey = Material.PlantKey
			AND Material.DataSourceKey = SourceInfo.DataSourceKey
		LEFT OUTER JOIN SAP.DIMMATERIALSOURCETYPES  DimPPartSource ON DimPPartSource.MaterialSourceTypeCode = LTRIM(RTRIM(SourceInfo.SitePartSourceTypeCode))
			AND DimPPartSource.DataSourceKey = SourceInfo.DataSourceKey
		LEFT OUTER JOIN SAP.DIMSUPPLIERS Supplier ON  Supplier.SupplierCode = LTRIM(RTRIM(SourceInfo.SupplierCorporationDsCode))
			AND Supplier.SupplierTypeCode = LTRIM(RTRIM(SourceInfo.CorporationdSTypeCode  ))
			AND Supplier.DataSourceKey = SourceInfo.DataSourceKey
		LEFT OUTER JOIN 
		(
			SELECT 
				* 
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
					SAP.DIMAML DAI
			) DIMAMLINTERNAL
			WHERE 
				DIMAMLINTERNAL.rn = 1
		) AML ON  LTRIM(RTRIM(SourceInfo.AMLReference)) = AML.AMLReference 
			AND Plant.Plantkey = AML.PlantKey 
			AND AML.EffectiveFromDateKey <= LTRIM(RTRIM(SourceInfo.DSCreateDTS)) 
			AND AML.EffectiveToDateKey > LTRIM(RTRIM(SourceInfo.DSCreateDTS))
			AND AML.DataSourceKey = SourceInfo.DataSourceKey
		LEFT OUTER JOIN SAP.DIMMANUFACTURERS MFR         
			ON  LTRIM(RTRIM(SourceInfo.MfrCorporationDsCode)) = MFR.ManufacturerCode
			AND MFR.DataSourceKey = SourceInfo.DataSourceKey
		LEFT OUTER JOIN SAP.DimManufacturerParts MFRPart 
			ON  LTRIM(RTRIM(SourceInfo.SupplierPartCode)) = MFRPart.ManufacturerPartCode
			AND AML.ManufacturerPartKey = MFRPart.ManufacturerPartKey
			AND MFRPart.DataSourceKey = SourceInfo.DataSourceKey
		LEFT OUTER JOIN 
		(
			SELECT 
				* 
			FROM 
			(
				SELECT 
					DRI.ExchangeRateKey,
					DRI.CurrencyCode,
					DRI.ToCurrencyCode,
					DRI.EffectiveFromDateKey,
					DRI.DataSourceKey,
					ROW_NUMBER() OVER 
					(
						PARTITION BY 
							DRI.CurrencyCode, 
							DRI.ToCurrencyCode, 
							DRI.DataSourceKey, 
							DRI.EffectiveFromDateKey 
						ORDER BY 
							DRI.EffectiveFromDateKey DESC,
							DRI.ExchangeRateKey DESC 
					) as rn 
				FROM 
					SAP.DIMEXCHANGERATES DRI
			) DER 
			WHERE 
				DER.Rn = 1 
		) Currency ON Currency.CurrencyCode = LTRIM(RTRIM(SourceInfo.CurrencyCode)) 
			AND Currency.ToCurrencyCode = 'USD' 
			AND Currency.EffectiveFromDateKey = ifnull( try_to_date( SourceInfo.DSCreateDTS , 'YYYYMMDD' ) , '1900-01-01')
			AND Currency.DataSourceKey = SourceInfo.DataSourceKey
		LEFT OUTER JOIN  sap.DIMMATERIALSUNITOFMEASURES MDS ON  LTRIM(RTRIM(SourceInfo.SitePartCode))  = LTRIM(RTRIM(MDS.MAterialCode)) 
			AND LTRIM(RTRIM(SourceInfo.SiteCode)) = LTRIM(RTRIM(MDS.PlantCode)) 
			AND LTRIM(RTRIM(SourceInfo.OrderUnitOfMeasureDsCode)) = LTRIM(RTRIM(MDS.AlternateUnitOfMeasureDSCode))
		LEFT OUTER JOIN SAP.DimCurrencyDecimalPlaces AS DCDP ON DCDP.CurrencyCode = IFNULL(SourceInfo.CurrencyCode,'') AND DCDP.ExponentFactor > 0
			AND DCDP.DataSourceKey = SourceInfo.DataSourceKey

  
	UNION ALL

	SELECT DISTINCT 
		SourceInfo.DataSourceKey,
		IFNULL(Plant.Plantkey,0)                                           AS PlantKey,
		IFNULL(Material.Materialkey,0)                                     AS MaterialKey,
		IFNULL(Supplier.SupplierKey,0)                                     AS SupplierKey,
		IFNULL(SourceInfo.SitePartSourceTypeCode,'')                       AS MaterialSourceTypeCode,
		IFNULL(DimPPartSource.MaterialSourceTypeKey,0)                     AS MaterialSourceTypeKey,
		IFNULL(LTRIM(RTRIM(SourceInfo.PurchasingOrganizationCode)),'')     AS PurchasingOrganizationCode,
		IFNULL(AML.AMLKEY,0)                                               AS AMLKEY,
		IFNULL(MFR.Manufacturerkey,0)                                      AS ManufacturerKey,
		IFNULL(MFRPart.ManufacturerPartKey,0)                              AS ManufacturerPartKey,
		IFNULL(SourceInfo.SitePartSourceInformationReference,'')           AS MaterialSourceReference,
		IFNULL(SourceInfo.FixedLeadTime,0)                                 AS FixedLeadTime,
		IFNULL(SourceInfo.CancellationLeadTime,0)                          AS CancellationLeadTime,
		IFNULL(SourceInfo.YIELD,0)										   AS YIELD,
		IFNULL(SourceInfo.OrderUnitOfMeasureDSCode,'')                     AS OrderUnitOfMeasure,
		IFNULL(SourceInfo.MaximumLotSize,0 )                               AS MaximumLotSize,
		IFNULL(SourceInfo.MinimumLotSize,0)                                AS MinimumLotSize,
		IFNULL(SourceInfo.MultipleQty,0)                                   AS MultipleQuantity,
		IFNULL(SourceInfo.PriceUnit,0)                                     AS PriceUnit,
		IFNULL(SourceInfo.UnitPriceCurrent,0) AS UnitPriceCurrent, ---* IFNULL(DCDP.ExponentFactor,1) AS UnitPriceCurrent,
		IFNULL(SourceInfo.UnitPriceFuture, 0) AS UnitPriceFuture,  ---* IFNULL(DCDP.ExponentFactor,1) AS UnitPriceFuture,
		CASE 
			WHEN IFNULL(MDS.AlternateToBaseConversionRate,0) = 0 THEN SourceInfo.UnitPriceCurrent ---* IFNULL(DCDP.ExponentFactor,1)
			ELSE 
			(
				ifnull(SourceInfo.UnitPriceCurrent,0.00000) / IFNULL(MDS.AlternateToBaseConversionRate,1) 
			) ---* IFNULL(DCDP.ExponentFactor,1)
			END AS UnitPriceCurrentBaseUOM,
		CASE 
			WHEN IFNULL(MDS.AlternateToBaseConversionRate,0) = 0 THEN SourceInfo.UnitPriceFuture ---* IFNULL(DCDP.ExponentFactor,1)
			ELSE 
			(
				ifnull(SourceInfo.UnitPriceFuture,0.00000) / IFNULL(MDS.AlternateToBaseConversionRate,1)
			) ---* IFNULL(DCDP.ExponentFactor,1)
		END AS UnitPriceFutureBaseUOM,
		CASE
			WHEN SourceInfo.UnitPriceFutureEffectiveFromDate = '00000000' THEN '1900-01-01'
			ELSE IFNULL(TO_DATE(SourceInfo.UnitPriceFutureEffectiveFromDate, 'YYYYMMDD' ), '1900-01-01')
		END AS UnitPriceFutureEffectiveFromDateKey,
		CASE
			WHEN SourceInfo.UnitPriceFutureEffectiveToDate = '00000000' THEN '1900-01-01'
			ELSE IFNULL(TO_DATE(SourceInfo.UnitPriceFutureEffectiveToDate, 'YYYYMMDD' ), '1900-01-01')
		END AS UnitPriceFutureEffectiveToDateKey,
		CASE UPPER(SourceInfo.DeleteFlag) 
			WHEN 'TRUE'  THEN 1 
			WHEN 'FALSE' THEN 0 
			ELSE 0 END                                                       AS DeleteFlag,
		IFNULL(SourceInfo.BaseUnitOfMeasure,'')                              AS BaseUnitOfMeasure,
		IFNULL(SourceInfo.CurrencyCode,'')                                   AS CurrencyCode,
		LEFT(IFNULL(Currency.ExchangeRateKey,00000000),8)                    AS ExchangeRateKey,
		SourceInfo.Updated_On												 AS SRCLASTMODIFIEDDATE,
	--	LTRIM(RTRIM(SourceInfo.DSCreateDTS))                                 AS DSCreatedDate,
    	try_to_date(SourceInfo.DSCreateDTS , 'YYYYMMDD')                                 AS DSCreatedDate,
	   HASH
	   (
			IFNULL(Plant.Plantkey,0),
			IFNULL(Material.Materialkey,0),
			IFNULL(Supplier.SupplierKey,0),
			IFNULL(DimPPartSource.MaterialSourceTypeKey,0),
			IFNULL(SourceInfo.PurchasingOrganizationCode,''),
			IFNULL(AML.AMLKEY,0),
			IFNULL(MFR.Manufacturerkey,0),
			IFNULL(MFRPart.ManufacturerPartKey,0),
			IFNULL(SourceInfo.SitePartSourceInformationReference,0),
			IFNULL(SourceInfo.FixedLeadTime,0),
			IFNULL(SourceInfo.CancellationLeadTime,0),
			IFNULL(SourceInfo.YIELD,0),
			IFNULL(SourceInfo.MaximumLotSize,0),
			IFNULL(SourceInfo.MinimumLotSize,0),
			IFNULL(SourceInfo.MultipleQty,0),
			IFNULL(SourceInfo.PriceUnit,0),
			IFNULL(SourceInfo.UnitPriceCurrent,0),
			IFNULL(MDS.AlternateToBaseConversionRate,0),
			IFNULL(SourceInfo.UnitPriceFuture, 0),
			IFNULL(SourceInfo.UnitPriceFutureEffectiveFromDate,''),
			IFNULL(SourceInfo.UnitPriceFutureEffectiveToDate,''),
			IFNULL(SourceInfo.DeleteFlag,''),
			IFNULL(SourceInfo.BaseUnitOfMeasure,''),
			IFNULL(SourceInfo.CurrencyCode,''),
			IFNULL(SourceInfo.DSCreateDTS, ''), 
			IFNULL(Currency.ExchangeRateKey,0)
		) AS HASH_VALUE  
	FROM 
		CONFORMED.V_HCC_HA_FactMaterialSourceInformation SourceInfo 
		LEFT OUTER JOIN SAP.DIMPLANTS Plant ON  LTRIM(RTRIM(SourceInfo.SiteCode)) = Plant.PlantCode 
			AND Plant.DataSourceKey = SourceInfo.DataSourceKey
		INNER JOIN  SAP.DIMMATERIALS Material ON  LTRIM(RTRIM(SourceInfo.SitePartCode)) = Material.MaterialCode 
			AND Plant.PlantKey = Material.PlantKey
			AND Material.DataSourceKey = SourceInfo.DataSourceKey
		LEFT OUTER JOIN SAP.DIMMATERIALSOURCETYPES  DimPPartSource ON DimPPartSource.MaterialSourceTypeCode = LTRIM(RTRIM(SourceInfo.SitePartSourceTypeCode))
			AND DimPPartSource.DataSourceKey = SourceInfo.DataSourceKey
		LEFT OUTER JOIN SAP.DIMSUPPLIERS Supplier ON  Supplier.SupplierCode = LTRIM(RTRIM(SourceInfo.SupplierCorporationDsCode))
			AND Supplier.SupplierTypeCode = LTRIM(RTRIM(SourceInfo.CorporationdSTypeCode  ))
			AND Supplier.DataSourceKey = SourceInfo.DataSourceKey
		LEFT OUTER JOIN 
		(
			SELECT 
				* 
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
					SAP.DIMAML DAI
			) DIMAMLINTERNAL
			WHERE 
				DIMAMLINTERNAL.rn = 1
		) AML ON  LTRIM(RTRIM(SourceInfo.AMLReference)) = AML.AMLReference 
			AND Plant.Plantkey = AML.PlantKey 
			AND AML.EffectiveFromDateKey <= LTRIM(RTRIM(SourceInfo.DSCreateDTS)) 
			AND AML.EffectiveToDateKey > LTRIM(RTRIM(SourceInfo.DSCreateDTS))
			AND AML.DataSourceKey = SourceInfo.DataSourceKey
		LEFT OUTER JOIN SAP.DIMMANUFACTURERS MFR         
			ON  LTRIM(RTRIM(SourceInfo.MfrCorporationDsCode)) = MFR.ManufacturerCode
			AND MFR.DataSourceKey = SourceInfo.DataSourceKey
		LEFT OUTER JOIN SAP.DimManufacturerParts MFRPart 
			ON  LTRIM(RTRIM(SourceInfo.SupplierPartCode)) = MFRPart.ManufacturerPartCode
			AND AML.ManufacturerPartKey = MFRPart.ManufacturerPartKey
			AND MFRPart.DataSourceKey = SourceInfo.DataSourceKey
		LEFT OUTER JOIN 
		(
			SELECT 
				* 
			FROM 
			(
				SELECT 
					DRI.ExchangeRateKey,
					DRI.CurrencyCode,
					DRI.ToCurrencyCode,
					DRI.EffectiveFromDateKey,
					DRI.DataSourceKey,
					ROW_NUMBER() OVER 
					(
						PARTITION BY 
							DRI.CurrencyCode, 
							DRI.ToCurrencyCode, 
							DRI.DataSourceKey, 
							DRI.EffectiveFromDateKey 
						ORDER BY 
							DRI.EffectiveFromDateKey DESC,
							DRI.ExchangeRateKey DESC 
					) as rn 
				FROM 
					SAP.DIMEXCHANGERATES DRI
			) DER 
			WHERE 
				DER.Rn = 1 
		) Currency ON Currency.CurrencyCode = LTRIM(RTRIM(SourceInfo.CurrencyCode)) 
			AND Currency.ToCurrencyCode = 'USD' 
			AND Currency.EffectiveFromDateKey = ifnull( try_to_date( SourceInfo.DSCreateDTS , 'YYYYMMDD' ) , '1900-01-01')
			AND Currency.DataSourceKey = SourceInfo.DataSourceKey
		LEFT OUTER JOIN  sap.DIMMATERIALSUNITOFMEASURES MDS ON  LTRIM(RTRIM(SourceInfo.SitePartCode))  = LTRIM(RTRIM(MDS.MaterialCode)) 
			AND LTRIM(RTRIM(SourceInfo.SiteCode)) = LTRIM(RTRIM(MDS.PlantCode)) 
			AND LTRIM(RTRIM(SourceInfo.OrderUnitOfMeasureDsCode)) = LTRIM(RTRIM(MDS.AlternateUnitOfMeasureDSCode))
		LEFT OUTER JOIN SAP.DimCurrencyDecimalPlaces AS DCDP ON DCDP.CurrencyCode = IFNULL(SourceInfo.CurrencyCode,'') AND DCDP.ExponentFactor > 0
			AND DCDP.DataSourceKey = SourceInfo.DataSourceKey			
)a;