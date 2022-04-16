create or replace view V_DIMMOVEMENTTYPES(
	DATASOURCEKEY,
	MOVEMENTTYPECODE,
	MOVEMENTTYPEDESCRIPTION,
	DELETEFLAG,
	DEBITCREDITINDICATOR,
	MOVEMENTTYPESTANDARDCODE,
	DOUBLESIDEDTRANSACTION,
	ISRECEIPT,
	ISCONSUMPTION,
	ISADJUSTMENT,
	ISSALE,
	SALETYPECODE,
	NOTES,
	SRCLASTMODIFIEDDATE,
	HASH_VALUE
) as
 /*-------------------------------------------------------------------------------------------------

This view is used to insert data into SAP.DIMREGIONS AND  SAP.DIMMOVEMENTTYPES
-----------------------------------------------------------------------------------------------
Revision History
-----------------------------------------------------------------------------------------------
Date            Developer               Comments
----------------------------------------------------------------------------------------------
2021-02-05      Carlos Carrillo         Initial Revision
  */
SELECT 	
        (Select DataSourceKey From PUBLIC.DimDataSources Where DataSourceName = 'SAP') as DataSourceKey
        , a.MovementTypeCode
        , IFNULL(CAST(a.Description AS NVARCHAR),'') AS MovementTypeDescription
        , TO_BOOLEAN(a.DeleteFlag) AS DeleteFlag
        , IFNULL(CAST(a.DebitCreditIndicator AS NVARCHAR),'') AS DebitCreditIndicator
        , IFNULL(CAST(b.MovementTypestdCode AS NVARCHAR),'') AS MovementTypeStandardCode
        , IFNULL(CAST(b.DoubleSidedTransaction AS NVARCHAR),'') AS DoubleSidedTransaction
        , TO_BOOLEAN(b.Receipt) AS IsReceipt
        , TO_BOOLEAN(b.Consumption) AS IsConsumption
        , TO_BOOLEAN(b.Adjustment) AS IsAdjustment
        , TO_BOOLEAN(b.Sale) AS IsSale
        , IFNULL(TO_VARCHAR(b.SaleTypeCode),'') AS SaleTypeCode
        , IFNULL(TO_VARCHAR(b.Notes),'') AS Notes
        , a.snFLK_UpdatedOn as SrcLastModifiedDate
        , HASH(a.Description ,b.MovementTypestdCode,a.DeleteFlag) AS HASH_VALUE
    FROM 
        CONFORMED.SCMDB_MOVEMENTTYPE a
        LEFT OUTER JOIN CONFORMED.SCMDB_MOVEMENTTYPESTD b 
            ON a.MovementTypeStdID = b.MovementTypeStdID 
    WHERE 
        a.DataSourceId = 6;