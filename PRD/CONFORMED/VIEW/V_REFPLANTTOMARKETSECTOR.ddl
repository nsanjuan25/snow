create or replace view V_REFPLANTTOMARKETSECTOR(
	DATASOURCEKEY,
	MATERIALGROUPCODE,
	MARKETSECTOR,
	SITECODE,
	SNFLK_UPDATEDON
) as 
/*-------------------------------------------------------------------------------------------------

This view is used to insert data into v_RefPlantToMarketSector
-----------------------------------------------------------------------------------------------
Revision History
-----------------------------------------------------------------------------------------------
Date            Developer               Comments
----------------------------------------------------------------------------------------------
2021-03-05     SRIDHAR                 Initial Revision            
*/       
                               
                                      
SELECT 
		  (SELECT DataSourceKey FROM PUBLIC.DimDataSources WHERE DataSourceName = 'SAP') as DataSourceKey
		, CorporationDSCode AS MaterialGroupCode
		, MarketSector
		, SiteCode
		, MAPCDSMS.SNFLK_UPDATEDON 
 	FROM 
		CONFORMED.SCMDB_CORPORATIONDSTOMARKETSECTOR MAPCDSMS,
		CONFORMED.SCMDB_CORPORATIONDS CDS,
		CONFORMED.SCMDB_SITE Site,
		CONFORMED.SCMDB_MARKETSECTOR MS
	WHERE 
		MAPCDSMS.CorporationDSID = CDS.CorporationDSID 
		AND MAPCDSMS.SiteId = Site.SiteId
		AND MAPCDSMS.MarketSectorId = MS.MarketSectorId;