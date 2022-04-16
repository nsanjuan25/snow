create or replace view V_SAT_SITEPARTQUOTELIST(
	SITEPARTID,
	QUOTEITEMNBR
) as 
 /*-------------------------------------------------------------------------------------------------

This view is used to insert data into FactSATQuotes
-----------------------------------------------------------------------------------------------
Revision History
-----------------------------------------------------------------------------------------------
Date            Developer               Comments
----------------------------------------------------------------------------------------------
2021-03-11      Venkata             Initial Revision
  */
SELECT DISTINCT satsp.SitePartID,
                qitsp.QuoteItemNbr
FROM
    SCMDB_SAT_SITEPART satsp
    INNER JOIN
        (
            SELECT B.SITEID
            FROM SCMDB_SITEGROUP a
            INNER JOIN
              (SELECT *
               FROM SCMDB_SITEGROUPTOSITE) b ON A.SITEGROUPID = B.SITEGROUPID   
        )sl ON satsp.siteid = sl.siteid
    INNER JOIN SCMDB_SAT_QUOTEITEMTOSITEPART qitsp ON satsp.sitepartid = qitsp.sitepartid
    INNER JOIN SCMDB_QUOTEITEM qi ON qitsp.QuoteItemNbr = qi.QuoteItemNbr
    INNER JOIN SCMDB_MFRPART mp ON qi.MfrPartID = mp.MfrPartID
    INNER JOIN SCMDB_CORPORATIONDSTOMARKETSECTOR cms ON cms.siteid = satsp.siteid
        AND cms.corporationdsid = satsp.MaterialGroupCorporationDSID
    INNER JOIN SCMDB_MARKETSECTOR msc ON msc.MarketSectorID = cms.MarketSectorID
    INNER JOIN SCMDB_MARKETSECTORTOSEGMENT msts ON msts.MarketSectorID = msc.MarketSectorID
    INNER JOIN SCMDB_MARKETSEGMENT msg ON msg.MarketSegmentID = msts.MarketSegmentID;