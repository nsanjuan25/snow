create or replace view V_DIMPURCHASEHISTORYTYPES(
	PURCHASEHISTORYTYPECODE,
	DATASOURCEKEY,
	PURCHASEHISTORYTYPEDESCRIPTION,
	PURCHASEHISTORYTYPESTANDARDCODE,
	SRCLASTMODIFIEDDATE,
	HASH_VALUE
) as
/*--------------------------------------------------------------------

This view is used to ADD data into DimPurchaseHistoryType table
-----------------------------------------------------------------------
Revision History
-----------------------------------------------------------------------
Date            Developer               Comments
-----------------------------------------------------------------------
2021-02-17      Noel San Juan          Initial Revision
*/
SELECT
    IFNULL(purchasehistory.PurchaseHistoryTypeCode,'')                  AS PurchaseHistoryTypeCode,
    1                                                                   AS DataSourceKey,
    IFNULL(purchasehistory.Description,'')                              AS PurchaseHistoryTypeDescription,
    IFNULL(purchasehistorystd.PurchaseHistoryTypeStdCode,'Undefined')   AS PurchaseHistoryTypeStandardCode,
    IFNULL(purchasehistory.UpdateDTS,'1900-01-01')                      AS SrclastModifiedDate,
    HASH
    (
        IFNULL(purchasehistory.Description, ''), 
        IFNULL(purchasehistorystd.PurchaseHistoryTypeStdCode , 'Undefined')
    ) AS HASH_VALUE
FROM 
    CONFORMED.SCMDB_PurchaseHistoryType AS purchasehistory
	LEFT OUTER JOIN CONFORMED.SCMDB_PurchaseHistoryTypeStd purchasehistorystd
        ON purchasehistory.PurchaseHistoryTypeStdId = purchasehistorystd.PurchaseHistoryTypeStdId
WHERE 
    purchasehistory.DataSourceID = 6;