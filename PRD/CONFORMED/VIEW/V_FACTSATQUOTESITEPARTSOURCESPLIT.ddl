create or replace view V_FACTSATQUOTESITEPARTSOURCESPLIT(
	QUOTEID,
	QUOTEITEMNBR,
	SOURCEDATE,
	MATERIALKEY,
	PLANTKEY,
	ALLOTTEDPCT,
	SOURCEDTCOPRICE,
	PAYTERMMETHODID,
	UPDATEUSER,
	UPDATEDTS,
	POPRICE,
	POSUPPLIERCORPORATIONNAME,
	POTENTIALSAVINGS,
	NETDEMAND,
	MFRPARTCODE,
	SELLUNITPRICEP0,
	DISPUTESOURCE,
	DISPUTECODEID,
	DISPUTECREATEUSER,
	DISPUTEUPDATEUSER,
	DISPUTECREATEDATE,
	DISPUTEUPDATEDATE,
	DISPUTEDSCREATEDTS,
	DISPUTEDSUPDATEDTS,
	SUPPLYCHAIN,
	CREATEUSER,
	QIO_QUOTEOVERRIDE,
	QIO_CORPORATIONDSCODE,
	QIO_MINIMUMQTY,
	QIO_MULTIPLEQTY,
	QIO_PLANNEDDELIVERYTIME,
	QIO_MFRPARTID,
	QIO_RESCHEDULEWINDOW,
	QIO_CANCELATIONLEADTIME,
	QIO_TW,
	QIO_NOTES,
	QIO_CREATEUSER,
	QIO_UPDATEUSER,
	QIO_CREATEDATE,
	QIO_UPDATEDATE,
	QIO_DSCREATEDTS,
	QIO_DSUPDATEDTS,
	GCM_DISPUTE,
	GCM_DISPUTECODEID,
	GCM_DISPUTECREATEUSER,
	GCM_DISPUTEUPDATEUSER,
	GCM_DISPUTECREATEDATE,
	GCM_DISPUTEUPDATEDATE,
	GCM_DISPUTEDSCREATEDTS,
	GCM_DISPUTEDSUPDATEDTS,
	GCM_DISPUTENOTES,
	PRICE_DETERMINATION_CTRL_ID,
	SALESPURCHASESTAXCODE,
	ROUNDINGPROFILEID,
	WB_SUBMITTED,
	SNFLK_UPDATEDON,
	UNITPRICE,
	MINIMUMORDERQTY
) as
 /*-------------------------------------------------------------------------------------------------

This view is used to insert data into FactQuoteSitepartSourceSplit
-----------------------------------------------------------------------------------------------
Revision History
-----------------------------------------------------------------------------------------------
Date            Developer               Comments
----------------------------------------------------------------------------------------------
2021-03-08      Venkata             Initial Revision
  */
SELECT 
      IFNULL(QS.quoteid,0)                                              AS quoteid
    , IFNULL(QS.quoteitemnbr,0)                                         AS quoteitemnbr
    , IFNULL(QS.sourcedate,'')                                          AS sourcedate
    , IFNULL(M.MaterialKey,0)                                           AS MaterialKey
    , IFNULL(P.PlantKey,0)                                              AS PlantKey
    , IFNULL(QS.allottedpct,0)                                          AS allottedpct
    , IFNULL(QS.sourcedtcoprice,0)                                      AS sourcedtcoprice
    , IFNULL(QS.paytermmethodid,0)                                      AS paytermmethodid
    , IFNULL(QS.updateuser,'')                                          AS updateuser
    , IFNULL(QS.updatedts,'')                                           AS updatedts
    , IFNULL(QS.poprice,0)                                              AS poprice
    , IFNULL(QS.posuppliercorporationname,'')                           AS posuppliercorporationname
    , IFNULL(QS.potentialsavings,0)                                     AS potentialsavings
    , IFNULL(QS.netdemand,0)                                            AS netdemand
    , IFNULL(QS.mfrpartcode,'')                                         AS mfrpartcode
    , IFNULL(QS.sellunitpricep0,0)                                      AS sellunitpricep0
    , QS.disputesource                                                  AS disputesource
    , IFNULL(QS.disputecodeid,0)                                        AS disputecodeid
    , IFNULL(QS.disputecreateuser,'')                                   AS disputecreateuser
    , IFNULL(QS.disputeupdateuser,'')                                   AS disputeupdateuser
    , QS.disputecreatedate                                              AS disputecreatedate
    , QS.disputeupdatedate                                              AS disputeupdatedate
    , QS.disputedscreatedts                                             AS disputedscreatedts
    , QS.disputedsupdatedts                                             AS disputedsupdatedts
    , IFNULL(QS.supplychain,'')                                         AS supplychain
    , IFNULL(QS.createuser,'')                                          AS createuser
    , QS.qio_quoteoverride                                              AS qio_quoteoverride
    , IFNULL(QS.qio_corporationdscode,'')                               AS qio_corporationdscode
    , IFNULL(QS.qio_minimumqty,0)                                       AS qio_minimumqty
    , IFNULL(QS.qio_multipleqty,0)                                      AS qio_multipleqty
    , IFNULL(QS.qio_planneddeliverytime,0)                              AS qio_planneddeliverytime
    , IFNULL(QS.qio_mfrpartid,0)                                        AS qio_mfrpartid
    , IFNULL(QS.qio_reschedulewindow,0)                                 AS qio_reschedulewindow
    , IFNULL(QS.qio_cancelationleadtime,0)                              AS qio_cancelationleadtime
    , IFNULL(QS.qio_tw,0)                                               AS qio_tw
    , IFNULL(QS.qio_notes,'')                                           AS qio_notes
    , IFNULL(QS.qio_createuser,'')                                      AS qio_createuser
    , IFNULL(QS.qio_updateuser,'')                                      AS qio_updateuser
    , QS.qio_createdate                                                 AS qio_createdate
    , QS.qio_updatedate                                                 AS qio_updatedate
    , QS.qio_dscreatedts                                                AS qio_dscreatedts
    , QS.qio_dsupdatedts                                                AS qio_dsupdatedts
    , QS.gcm_dispute                                                    AS gcm_dispute
    , IFNULL(QS.gcm_disputecodeid,0)                                    AS gcm_disputecodeid
    , IFNULL(QS.gcm_disputecreateuser,'')                               AS gcm_disputecreateuser
    , IFNULL(QS.gcm_disputeupdateuser,'')                               AS gcm_disputeupdateuser
    , IFNULL(QS.gcm_disputecreatedate,CURRENT_TIMESTAMP())              AS gcm_disputecreatedate
    , IFNULL(QS.gcm_disputeupdatedate,CURRENT_TIMESTAMP())              AS gcm_disputeupdatedate
    , IFNULL(QS.gcm_disputedscreatedts,CURRENT_TIMESTAMP())             AS gcm_disputedscreatedts
    , IFNULL(QS.gcm_disputedsupdatedts,CURRENT_TIMESTAMP())             AS gcm_disputedsupdatedts
    , IFNULL(QS.gcm_disputenotes,'')                                    AS gcm_disputenotes
    , IFNULL(QS.price_determination_ctrl_id,0)                          AS price_determination_ctrl_id
    , IFNULL(QS.salespurchasestaxcode,'')                               AS salespurchasestaxcode
    , IFNULL(QS.roundingprofileid,0)                                    AS roundingprofileid
    , QS.wb_submitted                                                   AS wb_submitted
    , IFNULL(QS.SNFLK_updatedon,'')                                     AS SNFLK_updatedon
    , IFNULL(QI.UnitPrice,0)                                            AS UnitPrice
    , IFNULL(QI.MinimumQty,0)                                           AS MinimumOrderQty
FROM
  conformed.scmdb_quotesitepartsource AS Q
  INNER JOIN conformed.scmdb_QUOTESITEPARTSOURCESPLIT AS QS 
    ON  Q.SitePartID = QS.SitePartID
    AND Q.MfgSiteID = QS.MfgSiteID
    AND Q.SourceDate = QS.SourceDate
  INNER JOIN conformed.scmdb_quoteitem AS QI 
    ON QS.QuoteItemNbr = QI.QuoteItemNbr
  LEFT OUTER JOIN conformed.scmdb_SAT_SITEPART AS satsp 
    ON  Q.SitePartID = satsp.sitepartid
  LEFT OUTER JOIN SAP.DimPlants AS p 
    ON p.PlantCode = satsp.SiteCode
    AND p.DataSourceKey = 1
  LEFT OUTER JOIN SAP.DimMaterials AS m 
    ON m.MaterialCode = satsp.SitePartCode
    AND m.PlantKey = p.PlantKey;