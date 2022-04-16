create or replace view V_FACTORDERS(
	SNAPSHOTDATEKEY,
	DATASOURCEKEY,
	PLANTKEY,
	ORDERTYPEKEY,
	ORDERCATEGORYKEY,
	MATERIALKEY,
	PLANNERKEY,
	INVENTORYLOCATIONKEY,
	TECHNICALCOMPLETIONDATEKEY,
	DSCREATEDDATEKEY,
	BASICSTARTDATEKEY,
	BASICFINISHDATEKEY,
	SCHEDULEFINISHDATEKEY,
	ACTUALSTARTDATEKEY,
	SCHEDULESTARTDATEKEY,
	DELIVERYDATEKEY,
	PLANNEDDELIVERYDATEKEY,
	ORDERNUMBER,
	ORDERITEM,
	DSCREATEDBY,
	REFERENCEORDERNUMBER,
	COMPANYCODE,
	CURRENCYCODE,
	PROFITCENTER,
	RESERVATIONNUMBER,
	PRODUCTIONSUPERVISOR,
	UNITOFMEASURE,
	PRODUCTIONVERSION,
	UNLOADINGPOINT,
	GOODRECIPIENT,
	UNLIMITEDOVERDELIVERY,
	PLANNEDORDERNUMBER,
	STOCKTYPE,
	DELETIONFLAG,
	ISDELIVERYCOMPLETED,
	DELETED,
	RECEIVEDQUANTITY,
	TOTALORDERQUANTITY,
	CONFIRMEDYIELD,
	PLANNEDORDERQUANTITY,
	OVERDELIVERYTOLERANCELIMIT,
	UNDERDELIVERYTOLERANCELIMIT,
	ORDERITEMQUANTITY,
	GOODSRECEIVEDQUANTITY,
	SCRAPFIXEDQUANTITY,
	PRODUCTIONORDERSTATUS,
	SALESDOCUMENTNUMBER,
	SALESDOCUMENTITEM,
	UPDATEDON,
	FULLORDERSTATUS
) as
/*--------------------------------------------------------------------

This view is used to ADD data into SAP.FACTORDERS table
-----------------------------------------------------------------------
Revision History
-----------------------------------------------------------------------
Date            Developer               Comments
-----------------------------------------------------------------------
2021-03-12      Noel San Juan          Initial Revision
*/
SELECT 
	CURRENT_DATE						AS SNAPSHOTDATEKEY,
	ESO.DATASOURCEKEY					AS DATASOURCEKEY,
	IFNULL(DM.PLANTKEY,0)				AS PLANTKEY,
	IFNULL(DOT.ORDERTYPEKEY,0)			AS ORDERTYPEKEY,
	IFNULL(DOC.ORDERCATEGORYKEY,0)		AS ORDERCATEGORYKEY,
	IFNULL(DM.MATERIALKEY,0)			AS MATERIALKEY,
	IFNULL(DP2.PLANNERKEY,0)			AS PLANNERKEY,
	IFNULL(DIL.INVENTORYLOCATIONKEY,0)	AS INVENTORYLOCATIONKEY,
	CASE
		WHEN ESO.TECHNICALCOMPLETIONDATE = '00000000' THEN '1900-01-01'
		ELSE IFNULL(TRY_TO_DATE(ESO.TECHNICALCOMPLETIONDATE, 'YYYYMMDD' ), '1900-01-01')
	END AS TECHNICALCOMPLETIONDATEKEY,
	CASE 
		WHEN ESO.DSCREATEDON = '00000000' THEN '1900-01-01'
		ELSE IFNULL(TRY_TO_DATE(ESO.DSCREATEDON, 'YYYYMMDD' ), '1900-01-01')
	END	AS DSCREATEDDATEKEY,
	CASE 
		WHEN ESO.BASICSTARTDATE = '00000000' THEN '1900-01-01'
		ELSE IFNULL(TRY_TO_DATE(ESO.BASICSTARTDATE, 'YYYYMMDD' ), '1900-01-01')
	END	AS BASICSTARTDATEKEY,
	CASE 
		WHEN ESO.SCHEDULEFINISHDATE = '00000000' THEN '1900-01-01'
		ELSE IFNULL(TRY_TO_DATE(ESO.SCHEDULEFINISHDATE, 'YYYYMMDD' ), '1900-01-01')
	END	AS BASICFINISHDATEKEY,
	CASE 
		WHEN ESO.SCHEDULEFINISHDATE = '00000000' THEN '1900-01-01'
		ELSE IFNULL(TRY_TO_DATE(ESO.SCHEDULEFINISHDATE, 'YYYYMMDD' ), '1900-01-01')
	END	AS SCHEDULEFINISHDATEKEY,
	CASE 
		WHEN ESO.ACTUALSTARTDATE = '00000000' THEN '1900-01-01'
		ELSE IFNULL(TRY_TO_DATE(ESO.ACTUALSTARTDATE, 'YYYYMMDD' ), '1900-01-01')
	END	AS ACTUALSTARTDATEKEY,
	CASE 
		WHEN ESO.SCHEDULESTARTDATE = '00000000' THEN '1900-01-01'
		ELSE IFNULL(TRY_TO_DATE(ESO.SCHEDULESTARTDATE, 'YYYYMMDD' ), '1900-01-01')
	END	AS SCHEDULESTARTDATEKEY,
	CASE 
		WHEN ESO.DELIVERYDATE = '00000000' THEN '1900-01-01'
		ELSE IFNULL(TRY_TO_DATE(ESO.DELIVERYDATE, 'YYYYMMDD' ), '1900-01-01')
	END	AS DELIVERYDATEKEY,
	CASE 
		WHEN ESO.PLANNEDDELIVERYDATE = '00000000' THEN '1900-01-01'
		ELSE IFNULL(TRY_TO_DATE(ESO.PLANNEDDELIVERYDATE, 'YYYYMMDD' ), '1900-01-01')
	END	AS PLANNEDDELIVERYDATEKEY,
	IFNULL(ESO.ORDERNUMBER,'')				AS ORDERNUMBER,
	IFNULL(ESO.ORDERITEM,0)					AS ORDERITEM,
	IFNULL(ESO.DSCREATEDBY,'')				AS DSCREATEDBY,
	IFNULL(ESO.REFERENCEORDERNUMBER,'')		AS REFERENCEORDERNUMBER,
	IFNULL(ESO.COMPANYCODE,'')				AS COMPANYCODE,
	IFNULL(ESO.CURRENCYCODE,'')				AS CURRENCYCODE,
	IFNULL(ESO.PROFITCENTER,'')				AS PROFITCENTER,
	IFNULL(ESO.RESERVATIONNUMBER,'')		AS RESERVATIONNUMBER,
	IFNULL(ESO.PRODUCTIONSUPERVISOR,'')		AS PRODUCTIONSUPERVISOR,
	IFNULL(ESO.UNITOFMEASURE,'')			AS UNITOFMEASURE,
	IFNULL(ESO.PRODUCTIONVERSION,'')		AS PRODUCTIONVERSION,
	IFNULL(ESO.UNLOADINGPOINT,'')			AS UNLOADINGPOINT,
	IFNULL(ESO.GOODRECIPIENT,'')			AS GOODRECIPIENT,
	IFNULL(ESO.UNLIMITEDOVERDELIVERY,'')	AS UNLIMITEDOVERDELIVERY,
	IFNULL(ESO.PLANNEDORDERNUMBER,'')		AS PLANNEDORDERNUMBER,
	IFNULL(ESO.STOCKTYPE,'')				AS STOCKTYPE,
	CASE
		WHEN ESO.DELETIONFLAG = 'X' THEN 'TRUE'
		WHEN ESO.DELETIONFLAG = '1' THEN 'TRUE'
		ELSE 'FALSE'
	END AS DELETIONFLAG, 
	CASE
		WHEN ESO.ISDELIVERYCOMPLETED = 'X' THEN 'TRUE'
		WHEN ESO.ISDELIVERYCOMPLETED = '1' THEN 'TRUE'
		ELSE 'FALSE'
	END AS ISDELIVERYCOMPLETED, 
	CASE
		WHEN ESO.DELETED = 'X' THEN 'TRUE'
		WHEN ESO.DELETED = '1' THEN 'TRUE'
		ELSE 'FALSE'
	END AS DELETED, 
	IFNULL(ESO.RECEIVEDQUANTITY,0)			AS RECEIVEDQUANTITY,
	IFNULL(ESO.TOTALORDERQUANTITY,0)		AS TOTALORDERQUANTITY,
	IFNULL(ESO.CONFIRMEDYIELD,0)			AS CONFIRMEDYIELD,
	IFNULL(ESO.PLANNEDORDERQUANTITY,0)		AS PLANNEDORDERQUANTITY,
	IFNULL(ESO.OVERDELIVERYTOLERANCELIMIT,0)	AS OVERDELIVERYTOLERANCELIMIT,
	IFNULL(ESO.UNDERDELIVERYTOLERANCELIMIT,0)	AS UNDERDELIVERYTOLERANCELIMIT,
	IFNULL(ESO.ORDERITEMQUANTITY,0)			AS ORDERITEMQUANTITY,
	IFNULL(ESO.GOODSRECEIVEDQUANTITY,0)		AS GOODSRECEIVEDQUANTITY,
	IFNULL(ESO.SCRAPFIXEDQUANTITY,0)		AS SCRAPFIXEDQUANTITY,
	IFNULL(ESO.PRODUCTIONORDERSTATUS,'')	AS PRODUCTIONORDERSTATUS,
	IFNULL(ESO.SALESDOCUMENTNUMBER,'')		AS SALESDOCUMENTNUMBER,
	IFNULL(ESO.SALESDOCUMENTITEM,0)			AS SALESDOCUMENTITEM,
	CURRENT_TIMESTAMP						AS UPDATEDON,
	IFNULL(ESO.FULLORDERSTATUS,'')			AS FULLORDERSTATUS
FROM 
    CONFORMED.SAP_ORDERS AS ESO
    LEFT OUTER JOIN SAP.DIMPLANTS AS DP ON ESO.PLANTCODE = DP.PLANTCODE
        AND DP.DATASOURCEKEY = ESO.DATASOURCEKEY
    LEFT OUTER JOIN SAP.DIMORDERTYPES AS DOT ON ESO.ORDERTYPE = DOT.ORDERTYPECODE
        AND DOT.DATASOURCEKEY = ESO.DATASOURCEKEY
    LEFT OUTER JOIN SAP.DIMORDERCATEGORIES AS DOC ON ESO.ORDERCATEGORY = DOC.ORDERCATEGORYCODE
        AND  DOC.DATASOURCEKEY = ESO.DATASOURCEKEY
    LEFT OUTER JOIN SAP.DIMMATERIALS AS DM ON ESO.MATERIALNUMBER = DM.MATERIALCODE
        AND DP.PLANTKEY = DM.PLANTKEY
        AND DM.DATASOURCEKEY = ESO.DATASOURCEKEY
    LEFT OUTER JOIN SAP.DIMPLANNERS AS DP2 ON ESO.PLANNERCODE = DP2.PLANNERCODE
        AND DP2.DATASOURCEKEY = ESO.DATASOURCEKEY
    LEFT OUTER JOIN SAP.DIMINVENTORYLOCATIONS AS DIL ON ESO.STORAGELOCATION = DIL.INVENTORYLOCATIONCODE
        AND ESO.PLANTCODE = DIL.PLANTCODE
        AND DIL.DATASOURCEKEY = ESO.DATASOURCEKEY;