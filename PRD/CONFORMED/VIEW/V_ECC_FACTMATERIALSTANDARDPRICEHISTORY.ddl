create or replace view V_ECC_FACTMATERIALSTANDARDPRICEHISTORY(
	MATERIALKEY,
	STDUNITCOSTP0,
	P0EFFECTIVEFROMDATEKEY,
	EFFECTIVEFROMDATEKEY,
	EFFECTIVETODATEKEY,
	LOCALCURRENCYTOUSDEXCHANGERATE,
	SRCLASTMODIFIEDDATE,
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

SELECT DISTINCT
           IFNULL(dpp.Materialkey , 0)				MaterialKey
         , IFNULL(spstd.StdUnitCostP0 ,0.000000)		StdUnitCostP0
         , to_varchar(spstd.P0EffectiveFromDate,'YYYYMMDD')	P0EffectiveFromDateKey
         , to_varchar(spstd.EffectiveFromDate,'YYYYMMDD')	EffectiveFromDateKey
         , to_varchar(spstd.EffectiveToDate,'YYYYMMDD')		EffectiveToDateKey
         , spstd.LocalCurrencyToUSDExchangeRate	    LocalCurrencyToUSDExchangeRate	
         , spstd.SNFLK_UPDATEDON                          SrcLastModifiedDate
          
		, dp.DataSourceKey as DataSourceKey
    FROM 
        conformed.SCMDB_SITEPARTSTDPRICEHISTORY  spstd
        LEFT OUTER JOIN (select * from conformed.SCMDB_SitePart where DatasourceID=6) sp
            ON spstd.SitePartID= sp.SitePartID
        INNER JOIN conformed.SCMDB_Site site
            ON site.SiteID = sp.SiteID
        INNER JOIN SAP.DimPlants dp
            ON dp.PlantCode = Site.SiteCode
			 
        INNER JOIN SAP.dimMaterials dpp
            ON dpp.plantkey = dp.plantkey 
			AND dpp.MaterialCode = sp.SitePartCode;