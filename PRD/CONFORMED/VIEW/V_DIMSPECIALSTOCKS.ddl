create or replace view V_DIMSPECIALSTOCKS(
	SPECIALSTOCKSCODE,
	DATASOURCEKEY,
	SPECIALSTOCKSDESCRIPTION,
	SPECIALSTOCKSSTANDARDCODE,
	SPECIALSTOCKSSTANDARDDESCRIPTION,
	DELETEFLAG,
	SRCLASTMODIFIEDDATE,
	HASH_VALUE
) as
 /*-------------------------------------------------------------------------------------------------

This view is used to insert data into SAP.DIMREGIONS AND  SAP.DimSpecialStocks
-----------------------------------------------------------------------------------------------
Revision History
-----------------------------------------------------------------------------------------------
Date            Developer               Comments
----------------------------------------------------------------------------------------------
2021-02-18      Carlos Carrillo         Initial Revision
  */
    SELECT
		  IFNULL(  LTRIM(RTRIM( SpecialStocks.SpecialStocksCode )),'')  AS SpecialStocksCode
		, (Select DataSourceKey From PUBLIC.DimDataSources Where DataSourceName = 'SAP') as DataSourceKey
		, SpecialStocks.Description AS SpecialStocksDescription
		, IFNULL(SpecialStocksStd.SpecialStocksStdCode,'Undefined') AS SpecialStocksStandardCode
		, IFNULL(SpecialStocksStd.Description,'Undefined') AS SpecialStocksStandardDescription
		, SpecialStocks.DeleteFlag
		, SpecialStocks.SNFLK_UpdatedOn as SrclastModifiedDate
		, HASH(SpecialStocks.Description,SpecialStocksStd.SpecialStocksStdCode ,SpecialStocksStd.Description ,SpecialStocks.DeleteFlag) AS HASH_VALUE
	FROM 
		CONFORMED.SCMDB_SpecialStocks as SpecialStocks 
		LEFT OUTER JOIN	CONFORMED.SCMDB_SpecialStocksStd as SpecialStocksStd 
			ON (SpecialStocks.SpecialStocksStdId = SpecialStocksStd.SpecialStocksStdId)
			AND SpecialStocks.DataSourceID = 6
	WHERE 
		SpecialStocks.DataSourceID = 6;