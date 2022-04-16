create or replace view V_DIMMATERIALSOURCETYPES(
	DATASOURCEKEY,
	MATERIALSOURCETYPECODE,
	DESCRIPTION,
	EFFECTIVITYRULE,
	TRANSITRULE,
	PLANNEDORDERSUPPLYTYPECODE,
	PLANNEDORDERSUPPLYTYPESTDCODE,
	PLANNEDORDERSUPPLYSTATUSCODE,
	PLANNEDORDERSUPPLYSTATUSSTDCODE,
	PLANNEDORDERTOSRSUPPLYTYPECODE,
	PLANNEDORDERTOSRSUPPLYTYPESTDCODE,
	PLANNEDORDERTOSRSUPPLYSTATUSCODE,
	PLANNEDORDERTOSRSUPPLYSTATUSSTDCODE,
	DELETEFLAG,
	SITEPARTSOURCETYPEUPDATEDON,
	SUPPLYTYPEUPDATEDON,
	SUPPLYTYPESTDUPDATEDON,
	SUPPLYSTATUSUPDATEDON,
	SUPPLYSTATUSSTDUPDATEDON,
	HASH_VALUE
) as
/*--------------------------------------------------------------------

This view is used to ADD data into DimMaterialSourceTypes table
-----------------------------------------------------------------------
Revision History
-----------------------------------------------------------------------
Date            Developer               Comments
-----------------------------------------------------------------------
2021-02-11      Noel San Juan          Initial Revision
*/
SELECT 
    1 AS DataSourceKey,
    IFNULL(a.SitePartSourceTypeCode,'') AS MaterialSourceTypeCode,
    IFNULL(a.Description,'')            AS Description,
    IFNULL(a.EffectivityRule,'')        AS EffectivityRule,
    IFNULL(a.TransitRule,'')            AS TransitRule,
    IFNULL(b.SupplyTypeCode,'')         AS PlannedOrderSupplyTypeCode,
    IFNULL(c.SupplyTypeStdCode,'')      AS PlannedOrderSupplyTypeStdCode,
    IFNULL(d.SupplyStatusCode,'')       AS PlannedOrderSupplyStatusCode,
    IFNULL(e.SupplyStatusStdCode,'')    AS PlannedOrderSupplyStatusStdCode,
    IFNULL(f.SupplyTypeCode,'')         AS PlannedOrderToSRSupplyTypeCode,
    IFNULL(g.SupplyTypeStdCode,'')      AS PlannedOrderToSRSupplyTypeStdCode,
    IFNULL(h.SupplyStatusCode,'')       AS PlannedOrderToSRSupplyStatusCode,
    IFNULL(i.SupplyStatusStdCode,'')    AS PlannedOrderToSRSupplyStatusStdCode,
    IFNULL(a.DeleteFlag,'FALSE')        AS DeleteFlag,
    IFNULL(a.UpdateDTS, '1900-01-01')   AS SitePartSourceTypeUpdatedOn,
    b.UpdateDTS                         AS SupplyTypeUpdatedOn,
    c.SNFLK_UPDATEDON                   AS SupplyTypeStdUpdatedOn,
    d.UpdateDTS                         AS SupplyStatusUpdatedOn,
    e.SNFLK_UPDATEDON                   AS SupplyStatusStdUpdatedOn,
    HASH
    (
        IFNULL(a.SitePartSourceTypeCode,''),
        IFNULL(a.Description,''),
        IFNULL(b.SupplyTypeCode,''),
        IFNULL(a.EffectivityRule,''),
        IFNULL(a.TransitRule,''),
        IFNULL(a.DeleteFlag, 'FALSE'),
        IFNULL(c.SupplyTypeStdCode,''),
        IFNULL(d.SupplyStatusCode,''),
        IFNULL(e.SupplyStatusStdCode,''),
        IFNULL(f.SupplyTypeCode,''),
        IFNULL(g.SupplyTypeStdCode,''),
        IFNULL(h.SupplyStatusCode,''),
        IFNULL(i.SupplyStatusStdCode,'')
     ) AS HASH_VALUE
FROM 
    CONFORMED.SCMDB_SITEPARTSOURCETYPE a
    LEFT JOIN CONFORMED.SCMDB_SUPPLYTYPE b
	    ON a.PlannedOrderSupplyTypeID = b.SupplyTypeID
    LEFT JOIN CONFORMED.SCMDB_SUPPLYTYPESTD c
	    ON b.SupplyTypeStdID = c.SupplyTypeStdID
    LEFT JOIN CONFORMED.SCMDB_SUPPLYSTATUS d
	    ON a.PlannedOrderSupplyStatusID = d.SupplyStatusID 
    LEFT JOIN CONFORMED.SCMDB_SUPPLYSTATUSSTD e
	    ON d.SupplyStatusStdID = e.SupplyStatusStdID
    LEFT JOIN CONFORMED.SCMDB_SUPPLYTYPE f
	    ON a.PlannedOrderToSRSupplyTypeID = f.SupplyTypeID
    LEFT JOIN CONFORMED.SCMDB_SUPPLYTYPESTD g
	    ON f.SupplyTypeStdID = g.SupplyTypeStdID
    LEFT JOIN CONFORMED.SCMDB_SUPPLYSTATUS h
	on a.PlannedOrderToSRSupplyStatusID = h.SupplyStatusID
    LEFT JOIN CONFORMED.SCMDB_SUPPLYSTATUSSTD i
	    ON h.SupplyStatusStdID = i.SupplyStatusStdID
WHERE 
    a.DataSourceID= 6;