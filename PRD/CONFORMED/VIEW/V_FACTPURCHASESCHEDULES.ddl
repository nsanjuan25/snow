create or replace view V_FACTPURCHASESCHEDULES(
	DATASOURCEKEY,
	PURCHASEDOCUMENTNUMBER,
	PURCHASEDOCUMENTITEM,
	PURCHASESCHEDULELINE,
	PURCHASESCHEDULETYPEKEY,
	SCHEDULEDDATEKEY,
	SCHEDULEDQUANTITY,
	RECEIVEDQUANTITY,
	FIXEDFLAG,
	DSCREATEDTS,
	DELETEFLAG,
	MRPRELEVANTFLAG,
	QUANTITYDELIVERED,
	ISSUEDQUANTITY,
	SRCLASTMODIFIEDDATE,
	ROW_ID,
	HASH_VALUE
) as
/*--------------------------------------------------------------------

This view is used to insert data into SAP.FACTPURCHASESCHEDULES
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
		a.DataSourceKey,
		a.PurchaseDocumentNumber,
		a.PurchaseDocumentItem,
		a.PurchaseScheduleLine,
		a.PurchaseScheduleTypekey,
		a.ScheduledDateKey,
		a.ScheduledQuantity,
		a.ReceivedQuantity,
		a.FixedFlag,
		a.DSCreateDTS,
		a.DeleteFlag,
		a.MRPRelevantFlag,
		a.QuantityDelivered,
		a.IssuedQuantity,
		a.SrcLastModifiedDate,
		a.Row_Id,
		a.HASH_VALUE 
	FROM
	(
		SELECT  
			1												  AS DataSourceKey,
			LTRIM(RTRIM(sch.PurchaseDocumentNumber))          AS PurchaseDocumentNumber,
			LTRIM(RTRIM(sch.PurchaseDocumentItem))            AS PurchaseDocumentItem,
			LTRIM(RTRIM(sch.PurchaseScheduleLine))            AS PurchaseScheduleLine,
			IFNULL( pst.PurchaseScheduleTypekey , 0 )         AS PurchaseScheduleTypekey,
			sch.ScheduledDTS                                  AS ScheduledDateKey,
			sch.ScheduledQuantity                             AS ScheduledQuantity,
			sch.ReceivedQuantity                              AS ReceivedQuantity,
			sch.FixedFlag                                     AS FixedFlag,
			sch.DSCreateDTS                                   AS DSCreateDTS,
			sch.DeleteFlag                                    AS DeleteFlag,
			sch.MRPRelevantFlag                               AS MRPRelevantFlag,
			sch.QuantityDelivered                             AS QuantityDelivered,
			sch.IssuedQuantity                                AS IssuedQuantity,
			sch.updated_on                                    AS SrcLastModifiedDate,
			ROW_NUMBER() OVER 
			( PARTITION BY 
        			sch.PurchaseDocumentNumber,
					sch.PurchaseDocumentItem,
					sch.PurchaseScheduleLine,
					pst.PurchaseScheduleTypekey ORDER BY DSCreateDTS DESC
			) AS Row_Id,
			HASH
			(
				IFNULL(pst.PurchaseScheduleTypekey,0),
				IFNULL(sch.ScheduledDTS,''),
				IFNULL(sch.ScheduledQuantity,0),
				IFNULL(sch.ReceivedQuantity,0),
				IFNULL(sch.FixedFlag,'FALSE'),
				IFNULL(sch.DSCreateDTS,''),
				IFNULL(sch.DeleteFlag,'FALSE'),
				IFNULL(sch.MRPRelevantFlag,'FALSE'),
				IFNULL(sch.QuantityDelivered,0),
				IFNULL(sch.IssuedQuantity,0) 
			) AS HASH_VALUE
		FROM  
			CONFORMED.V_ECC_HA_FACTPURCHASESCHEDULES sch
			LEFT OUTER JOIN SAP.DIMPURCHASESCHEDULETYPES pst ON sch.PurchaseScheduleTypeCode = pst.PurchaseScheduleTypeCode
				AND pst.DataSourceKey = 1
	) a
	WHERE 
		a.Row_Id =1

	UNION ALL

	SELECT
		a.DataSourceKey,
		a.PurchaseDocumentNumber,
		a.PurchaseDocumentItem,
		a.PurchaseScheduleLine,
		a.PurchaseScheduleTypekey,
		a.ScheduledDateKey,
		a.ScheduledQuantity,
		a.ReceivedQuantity,
		a.FixedFlag,
		a.DSCreateDTS,
		a.DeleteFlag,
		a.MRPRelevantFlag,
		a.QuantityDelivered,
		a.IssuedQuantity,
		a.SrcLastModifiedDate,
		a.Row_Id,
		a.HASH_VALUE 
	FROM
	(
		SELECT  
			2												  AS DataSourceKey,
			LTRIM(RTRIM(sch.PurchaseDocumentNumber))          AS PurchaseDocumentNumber,
			LTRIM(RTRIM(sch.PurchaseDocumentItem))            AS PurchaseDocumentItem,
			LTRIM(RTRIM(sch.PurchaseScheduleLine))            AS PurchaseScheduleLine,
			IFNULL( pst.PurchaseScheduleTypekey , 0 )         AS PurchaseScheduleTypekey,
			sch.ScheduledDTS                                  AS ScheduledDateKey,
			sch.ScheduledQuantity                             AS ScheduledQuantity,
			sch.ReceivedQuantity                              AS ReceivedQuantity,
			sch.FixedFlag                                     AS FixedFlag,
			sch.DSCreateDTS                                   AS DSCreateDTS,
			sch.DeleteFlag                                    AS DeleteFlag,
			sch.MRPRelevantFlag                               AS MRPRelevantFlag,
			sch.QuantityDelivered                             AS QuantityDelivered,
			sch.IssuedQuantity                                AS IssuedQuantity,
			sch.updated_on                                    AS SrcLastModifiedDate,
			ROW_NUMBER() OVER 
			( PARTITION BY 
        			sch.PurchaseDocumentNumber,
					sch.PurchaseDocumentItem,
					sch.PurchaseScheduleLine,
					pst.PurchaseScheduleTypekey ORDER BY DSCreateDTS DESC
			) AS Row_Id,
			HASH
			(
				IFNULL(pst.PurchaseScheduleTypekey,0),
				IFNULL(sch.ScheduledDTS,''),
				IFNULL(sch.ScheduledQuantity,0),
				IFNULL(sch.ReceivedQuantity,0),
				IFNULL(sch.FixedFlag,'FALSE'),
				IFNULL(sch.DSCreateDTS,''),
				IFNULL(sch.DeleteFlag,'FALSE'),
				IFNULL(sch.MRPRelevantFlag,'FALSE'),
				IFNULL(sch.QuantityDelivered,0),
				IFNULL(sch.IssuedQuantity,0) 
			) AS HASH_VALUE
		FROM  
			CONFORMED.V_HCC_HA_FACTPURCHASESCHEDULES sch
			LEFT OUTER JOIN SAP.DIMPURCHASESCHEDULETYPES pst ON sch.PurchaseScheduleTypeCode = pst.PurchaseScheduleTypeCode
				AND pst.DataSourceKey = 2
	) a
	WHERE 
		a.Row_Id =1
) b;