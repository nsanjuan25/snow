create or replace view V_DIMMARKETSECTORS(
	MARKETSECTOR,
	MARKETSEGMENT,
	DATASOURCEKEY,
	DELETEFLAG,
	SRCLASTMODIFIEDDATE,
	HASH_VALUE
) as
/*--------------------------------------------------------------------

This view is used to ADD data into DimMarketSectors table
-----------------------------------------------------------------------
Revision History
-----------------------------------------------------------------------
Date            Developer               Comments
-----------------------------------------------------------------------
2021-02-11      Noel San Juan          Initial Revision
*/
SELECT
    IFNULL(LTRIM(RTRIM(a.MarketSector)),'') AS MarketSector,
    IFNULL(b.MarketSegment , 'Undefined')   AS MarketSegment,
    1                                       AS DataSourceKey,
	IFNULL(a.DeleteFlag,'FALSE')            AS DeleteFlag,
	IFNULL(a.UpdateDTS, '1900-01-01')       AS SrcLastModifiedDate,
    HASH
    ( 
        IFNULL(b.MarketSegment , 'Undefined'),
        IFNULL(a.DeleteFlag , 'FALSE')
    ) AS HASH_VALUE
FROM 
    CONFORMED.SCMDB_MARKETSECTOR a
	LEFT OUTER JOIN CONFORMED.SCMDB_MARKETSECTORTOSEGMENT c
        ON a.MarketSectorID = c.MarketSectorID 
    LEFT OUTER JOIN CONFORMED.SCMDB_MARKETSEGMENT b
	    ON b.MarketSegmentID = c.MarketSegmentID;