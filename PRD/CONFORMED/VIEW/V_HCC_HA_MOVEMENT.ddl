create or replace view V_HCC_HA_MOVEMENT(
	DATASOURCEKEY,
	MOVEMENTDOCUMENTTYPE,
	MOVEMENTYEAR,
	MOVEMENTDOCUMENTNUMBER,
	MOVEMENTDOCUMENTITEM,
	SITECODE,
	SITEPARTCODE,
	POSTEDDTS,
	REFERENCEDOCUMENTNUMBER,
	MOVEMENTTYPECODE,
	BILLOFLADING,
	MOVEMENTCOMMENTS,
	STORAGELOCATION,
	BATCHNUMBER,
	INVENTORYTYPECODE,
	QUANTITY,
	MATERIALCOST,
	COMPANYORGANIZATIONCODE,
	SALESDOCUMENTNUMBER,
	SALESDOCUMENTITEM,
	PURCHASEDOCUMENTNUMBER,
	PURCHASEDOCUMENTITEM,
	DSCREATEUSER,
	DEBITCREDITINDICATOR,
	OWNERCORPORATIONDSCODE,
	CURRENCYCODE,
	SPECIALSTOCKSCODE,
	UNITOFMEASUREDSCODE,
	AMLREFERENCENUMBER,
	TRANSACTIONDTS,
	REASONTYPECODE,
	MOVEMENTITEMCOMMENTS,
	MOVEMENTINDICATOR,
	CORPORATIONDSTYPECODE,
	CORPORATIONDSTYPESTDCODE,
	UPDATED_ON,
	LOAD_TYPE
) as
/*--------------------------------------------------------------------

This view is used to spend_analytics 
-----------------------------------------------------------------------
Revision History
-----------------------------------------------------------------------
Date            Developer               Comments
-----------------------------------------------------------------------
2021-03-01      Noel San Juan          Initial Revision
*/
SELECT
	2          datasourcekey,
	mkpf.blart movementdocumenttype, 
	mkpf.mjahr movementyear, 
	mkpf.mblnr movementdocumentnumber, 
	mseg.zeile movementdocumentitem, 
	mseg.werks sitecode, 
	mseg.matnr sitepartcode, 
	mkpf.budat posteddts, 
	mkpf.xblnr referencedocumentnumber, 
	mseg.bwart movementtypecode, 
	mkpf.frbnr billoflading, 
	mkpf.bktxt movementcomments, 
	mseg.lgort storagelocation, 
	mseg.charg batchnumber, 
	mseg.insmk inventorytypecode, 
	mseg.menge quantity, 
	CASE 
		WHEN TCURX.currkey = mseg.waers THEN mseg.dmbtr * power(10, (2 - currdec)) 
		ELSE mseg.dmbtr 
	END materialcost, 
	mseg.bukrs companyorganizationcode, 
	mseg.kdauf salesdocumentnumber, 
	mseg.kdpos salesdocumentitem, 
	mseg.ebeln purchasedocumentnumber, 
	mseg.ebelp purchasedocumentitem, 
	mkpf.usnam dscreateuser, 
	CASE
		WHEN mseg.shkzg = 'H' THEN '+'
		ELSE '-'
	END debitcreditindicator,
	mseg.lifnr ownercorporationdscode, 
	mseg.waers currencycode, 
	mseg.sobkz specialstockscode, 
	mseg.meins unitofmeasuredscode, 
	mseg.ematn amlreferencenumber, 
	mkpf.cpudt transactiondts, 
	mseg.grund reasontypecode, 
	mseg.sgtxt movementitemcomments, 
	mseg.kzbew movementindicator, 
	lfa1.ktokk corporationdstypecode, 
	CASE 
		WHEN NOT (lfa1.lifnr IS NULL 
					OR lfa1.lifnr = '') THEN CASE 
												WHEN upper(lfa1.ktokk) LIKE '%INT%' THEN 'Jabil' 
												WHEN upper(lfa1.ktokk) LIKE '%MF%' THEN 'Manufacturer' 
												ELSE 'Supplier' 
											END 
		ELSE '' 
	END corporationdstypestdcode, 
	mseg.SNFLK_UPDATEDON updated_on, 
	'FR' load_type 
FROM 
	CONFORMED.HCC_HA_MKPF mkpf 
	INNER JOIN CONFORMED.HCC_HA_MSEG mseg ON mkpf.mblnr = mseg.mblnr 
	    AND mkpf.mjahr = mseg.mjahr 
	LEFT OUTER JOIN CONFORMED.HCC_HA_LFA1 lfa1 ON mseg.lifnr = lfa1.lifnr 
	LEFT OUTER JOIN CONFORMED.HCC_HA_TCURX tcurx ON mseg.waers = TCURX.currkey;