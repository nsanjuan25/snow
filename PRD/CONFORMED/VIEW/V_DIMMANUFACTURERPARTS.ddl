create or replace view V_DIMMANUFACTURERPARTS(
	DATASOURCEKEY,
	SRCMFRPARTID,
	TEMPCORPORATIONID,
	MANUFACTURERPARTCODE,
	MANUFACTURERPARTDESCRIPTION,
	COMMODITY,
	COMMODITYCATEGORY,
	INTERNALSTATUS,
	CLASSIFICATIONSTATUSCODE,
	DELETEFLAG,
	LOCALMANUFACTURERNAME,
	SRCLASTMODIFIEDDATE,
	HASH_VALUE
) as
/*--------------------------------------------------------------------

This view is used to ADD data into DimManufacturerParts table
-----------------------------------------------------------------------
Revision History
-----------------------------------------------------------------------
Date            Developer               Comments
-----------------------------------------------------------------------
2021-02-24      Noel San Juan          Initial Revision
*/
SELECT
    1 as DataSourceKey ,
    srcMfrPartID,
    TempCorporationID,
    ManufacturerPartCode,
    ManufacturerPartDescription,
    Commodity,
    CommodityCategory,
    InternalStatus,    
    ClassificationStatusCode,
    DeleteFlag,
    LocalManufacturerName,
    SRCLASTMODIFIEDDATE,
    HASH_VALUE
FROM 
    conformed.V_ecc_ha_DIMMANUFACTURERPARTS;