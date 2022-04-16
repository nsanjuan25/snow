create or replace view V_FACTMATERIALSOURCEPRICING(
	PLANTKEY,
	MATERIALKEY,
	SUPPLIERKEY,
	MATERIALSOURCETYPEKEY,
	PURCHASINGORGANIZATIONCODE,
	UNITPRICE,
	PRICEUNIT,
	UNITPRICECURRENTBASEUOM,
	EFFECTIVEFROMDATEKEY,
	EFFECTIVETODATEKEY,
	STATUSCODE,
	CURRENCYCODE,
	DELETEFLAG,
	HASH_VALUE,
	DATASOURCEKEY
) as
 /*-------------------------------------------------------------------------------------------------

This view is used to insert data into FactMaterialSourcePricing
-----------------------------------------------------------------------------------------------
Revision History
-----------------------------------------------------------------------------------------------
Date            Developer               Comments
----------------------------------------------------------------------------------------------
2021-03-15      Venkata             Initial Revision

*/
SELECT    
      IFNULL(Plant.Plantkey,0)                                           AS  PlantKey
    , IFNULL(Material.Materialkey,0)                                     AS  MaterialKey
    , IFNULL(Supplier.SupplierKey,0)                                     AS  SupplierKey
    , IFNULL(DimPPartSource.MaterialSourceTypeKey,0)                     AS  MaterialSourceTypeKey
    , IFNULL(LTRIM(RTRIM(SourceInfo.PurchasingOrganizationCode)),'')     AS  PurchasingOrganizationCode
    , IFNULL(SourceInfo.unitprice,0 )                                    AS  unitprice
    , IFNULL(SourceInfo.priceunit,0)                                     AS  priceunit
    , IFNULL(CASE
       WHEN IFNULL(MDS.AlternateToBaseConversionRate,0.0) = 0 THEN
           SourceInfo.priceunit * IFNULL(DCDP.ExponentFactor,1)
       ELSE
          (
              (IFNULL(SourceInfo.priceunit,0.0) /
              IFNULL(MDS.AlternateToBaseConversionRate,1.0) )
          ) * IFNULL(DCDP.ExponentFactor,1)
       END,0 )                                                            AS UnitPriceCurrentBaseUOM
    , SourceInfo.EffectiveFromDate                              AS EffectiveFromDateKey
    , SourceInfo.EffectiveToDate                                AS EffectiveToDateKey
    , IFNULL(SourceInfo.StatusCode,'')                                    AS StatusCode
    , IFNULL(SourceInfo.CurrencyCode,'')                                  AS CurrencyCode
    , IFNULL(CASE UPPER(SourceInfo.DeleteFlag)
       WHEN 'TRUE'  THEN 1
       WHEN 'FALSE' THEN 0
       ELSE 0 END,0)                                                      AS DeleteFlag
    , HASH(Plant.Plantkey,Material.Materialkey,Supplier.SupplierKey,DimPPartSource.MaterialSourceTypeKey,SourceInfo.PurchasingOrganizationCode,
       SourceInfo.unitprice,SourceInfo.priceunit,SourceInfo.EffectiveFromDate,SourceInfo.EffectiveToDate,SourceInfo.StatusCode,SourceInfo.CurrencyCode,
         SourceInfo.DeleteFlag)  AS HASH_VALUE
    , SourceInfo.DataSourceKey                                                    AS DataSourceKey
FROM
    CONFORMED.V_SITEPARTSOURCE_PRICING SourceInfo    
    LEFT OUTER JOIN SAP.DimPlants Plant                                                            
            ON  LTRIM(RTRIM(SourceInfo.SiteCode)) = Plant.PlantCode
            AND SourceInfo.DataSourceKey = Plant.DataSourceKey
    LEFT OUTER JOIN  SAP.DimMaterials Material                      
            ON  LTRIM(RTRIM(SourceInfo.sitePArtCode)) = Material.MaterialCode
            AND Plant.PlantKey = Material.PlantKey
            AND SourceInfo.DataSourceKey = Material.DataSourceKey
    LEFT OUTER JOIN SAP.DimMaterialSourceTypes  DimPPartSource  
            ON DimPPartSource.MaterialSourceTypeCode = LTRIM(RTRIM(Material.MaterialTypeCode))
            AND DimPPartSource.DataSourceKey = SourceInfo.DataSourceKey
    LEFT OUTER JOIN SAP.DimSuppliers Supplier        
            ON  Supplier.SupplierCode = LTRIM(RTRIM(SourceInfo.SupplierCorporationDsCode))
            AND Supplier.SupplierTypeCode = LTRIM(RTRIM(SourceInfo.CorporationdSTypeCode  ))
            AND SourceInfo.DataSourceKey = Supplier.DataSourceKey
    LEFT OUTER JOIN  sap.DIMMATERIALSUNITOFMEASURES MDS
            ON  LTRIM(RTRIM(SourceInfo.SitePartCode))  = LTRIM(RTRIM(MDS.materialcode))
            AND LTRIM(RTRIM(SourceInfo.SiteCode)) = LTRIM(RTRIM(MDS.plantcode))
            AND LTRIM(RTRIM(SourceInfo.unitofmeasuredscode)) = LTRIM(RTRIM(MDS.AlternateUnitOfMeasureDSCode))
            and SourceInfo.DataSourceKey = MDS.DataSourceKey
    LEFT OUTER JOIN SAP.DimCurrencyDecimalPlaces AS DCDP ON DCDP.CurrencyCode = IFNULL(SourceInfo.CurrencyCode,'') AND DCDP.ExponentFactor > 0
        and sourceinfo.datasourcekey = DCDP.datasourcekey;