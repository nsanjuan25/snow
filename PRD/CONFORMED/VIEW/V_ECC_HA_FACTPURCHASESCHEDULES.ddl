create or replace view V_ECC_HA_FACTPURCHASESCHEDULES(
	PURCHASEDOCUMENTNUMBER,
	PURCHASEDOCUMENTITEM,
	PURCHASESCHEDULELINE,
	PURCHASESCHEDULETYPECODE,
	SCHEDULEDDTS,
	SCHEDULEDQUANTITY,
	RECEIVEDQUANTITY,
	FIXEDFLAG,
	DSCREATEDTS,
	DELETEFLAG,
	MRPRELEVANTFLAG,
	QUANTITYDELIVERED,
	ISSUEDQUANTITY,
	UPDATED_ON
) as
/*--------------------------------------------------------------------

This view is used in V.FACTPURCHASESCHEDULES
-----------------------------------------------------------------------
Revision History
-----------------------------------------------------------------------
Date            Developer               Comments
-----------------------------------------------------------------------
2021-03-02      Noel San Juan          Initial Revision
*/
SELECT * 
FROM 
( 
	SELECT 
		IFNULL(EKET.ebeln,'') AS PurchaseDocumentNumber,
		IFNULL(EKET.ebelp,0)  AS PurchaseDocumentItem,
		IFNULL(EKET.etenr,0)  AS PurchASeScheduleLine,
		IFNULL(EKET.abart,'') AS PurchaseScheduleTypeCode,
		CASE
			WHEN EKET.eindt = '00000000' THEN '1900-01-01'
			ELSE IFNULL ( TRY_TO_DATE(EKET.eindt, 'YYYYMMDD' ), '1900-01-01')
		END AS ScheduledDTS,
		IFNULL(EKET.menge,0) AS ScheduledQuantity,
		IFNULL(EKET.wemng,0) AS ReceivedQuantity,
		CASE
			WHEN eket.fixkz = 'X' THEN 'TRUE'
			ELSE 'FALSE'
		END AS FixedFlag,
		CASE
			WHEN EKET.bedat = '00000000' THEN '1900-01-01'
			ELSE IFNULL ( TRY_TO_DATE(EKET.bedat, 'YYYYMMDD' ), '1900-01-01')
		END AS DSCreateDTS,
		'FALSE'	   AS DeleteFlag, 
		'TRUE'     AS MRPRelevantFlag,
		IFNULL(EKET.glmng,0) AS QuantityDelivered,
		IFNULL(EKET.wamng,0) AS IssuedQuantity, 
		current_timestamp AS updated_on  
	FROM 
		CONFORMED.ECC_HA_EKET AS EKET 

	UNION ALL 

	SELECT 
		IFNULL(EKES.ebeln,'') AS PurchaseDocumentNumber,
		IFNULL(EKES.ebelp,0)  AS PurchASeDocumentItem,
		IFNULL(EKES.etens,0)  AS PurchaseScheduleLine,
		IFNULL(EKES.ebtyp,'') AS PurchASeScheduleTypeCode,
        CASE
			WHEN EKES.eindt = '00000000' THEN '1900-01-01'
			ELSE IFNULL ( TRY_TO_DATE(EKES.eindt, 'YYYYMMDD' ), '1900-01-01') 
		END AS ScheduledDTS, 
		IFNULL(EKES.menge,0) AS ScheduledQuantity,
		IFNULL(EKES.dabmg,0) AS ReceivedQuantity,
		'FALSE' AS FixedFlag,
       CASE
			WHEN EKES.erdat = '00000000' THEN '1900-01-01'
			ELSE IFNULL ( TRY_TO_DATE(EKES.erdat, 'YYYYMMDD' ), '1900-01-01')
		END AS DSCreateDTS,
		CASE
			WHEN EKES.loekz = 'X' THEN 'TRUE'
			ELSE 'FALSE'
		END AS DeleteFlag,
		CASE
			WHEN EKES.kzdis = 'X' THEN 'TRUE'
			ELSE 'FALSE'
		END AS MRPRelevantFlag,
		0 AS QuantityDelivered,
		0 AS IssuedQuantity, 
		current_timestamp AS updated_on 
	FROM 
		CONFORMED.ECC_HA_EKES AS EKES
) a;