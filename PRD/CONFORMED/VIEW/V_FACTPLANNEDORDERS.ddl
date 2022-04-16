create or replace view V_FACTPLANNEDORDERS(
	DATASOURCEKEY,
	PLANNEDORDERNUMBER,
	PLANNINGMATERIAL,
	PLANNINGPLANT,
	PRODUCTIONPLANT,
	SALESDOCUMENTNUMBER,
	SALESDOCUMENTITEM,
	TOTALPLANNEDQUANTITY,
	QUANTITYGOODSRECEIVED,
	STARTDATE,
	FINISHDATE,
	COMMITEDQUANTITY,
	FIXEDVENDOR,
	SPECIALSTOCKSCODEINDICATOR,
	UNITOFMEASURE,
	STORAGELOCATION,
	PRODUCTIONVERSION,
	ORDERTYPE,
	MRPCONTROLLER,
	MPN,
	PRODUCTIONSTARTDATE,
	PRODUCTIONFINISHDATE,
	ISSUEDQUANTITY,
	SRCLASTMODIFIEDDATE
) as
/*--------------------------------------------------------------------

This view is used to ADD data into SAP.FACTPLANNEDORDERS table
-----------------------------------------------------------------------
Revision History
-----------------------------------------------------------------------
Date            Developer               Comments
-----------------------------------------------------------------------
2021-04-22      Noel San Juan          Initial Revision
*/
SELECT
    1                AS DataSourceKey,
    IFNULL(plnum,'') AS PlannedOrderNumber,
    IFNULL(matnr,'') AS PlanningMaterial,
    IFNULL(plwrk,'') AS PlanningPlant,
    IFNULL(pwwrk,'') AS ProductionPlant,
    IFNULL(kdauf,'') AS SalesDocumentNumber,
    IFNULL(kdpos,0)  AS SalesDocumentItem,
    IFNULL(gsmng,0)  AS TotalPlannedQuantity,
    IFNULL(wemng,0)  AS QuantityGoodsReceived,
	CASE
		WHEN psttr = '00000000' THEN '1900-01-01'
		ELSE IFNULL(TRY_TO_DATE(psttr, 'YYYYMMDD' ), '1900-01-01')
	END AS StartDate,
	CASE
		WHEN pedtr = '00000000' THEN '1900-01-01'
		ELSE IFNULL(TRY_TO_DATE(pedtr, 'YYYYMMDD' ), '1900-01-01')
	END AS FinishDate,
    IFNULL(vfmng,0)  AS CommitedQuantity,
    IFNULL(flief,'') AS FixedVendor,
    IFNULL(sobkz,'') AS SpecialStocksCodeIndicator,
    IFNULL(meins,'') AS UnitOfMeasure,
    IFNULL(lgort,'') AS StorageLocation,
    IFNULL(verid,'') AS ProductionVersion,
    IFNULL(paart,'') AS OrderType,
    IFNULL(dispo,'') AS MRPController,
    IFNULL(ematn,'') AS MPN,
	CASE
		WHEN terst = '00000000' THEN '1900-01-01'
		ELSE IFNULL(TRY_TO_DATE(terst, 'YYYYMMDD' ), '1900-01-01')
	END AS ProductionStartDate,
	CASE
		WHEN tered = '00000000' THEN '1900-01-01'
		ELSE IFNULL(TRY_TO_DATE(tered, 'YYYYMMDD' ), '1900-01-01')
	END AS ProductionFinishDate,
    IFNULL(wamng,0)  AS IssuedQuantity,
    SNFLK_UPDATEDON  AS SRCLASTMODIFIEDDATE
FROM 
    CONFORMED.BW_HA_PLAF;