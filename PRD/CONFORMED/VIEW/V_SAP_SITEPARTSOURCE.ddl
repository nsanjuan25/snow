create or replace view V_SAP_SITEPARTSOURCE(
	DATASOURCEKEY,
	PLANTCODE,
	MATERIALCODE,
	SUPPLIERCORPORATIONDSCODE,
	MATERIALSOURCETYPECODE,
	MATERIALSOURCECATEGORYCODE,
	SEQUENCENUMBER,
	MATERIALSOURCEREFERENCE,
	EFFECTIVEFROMDATE,
	EFFECTIVETODATE,
	MRPINDICATOR,
	FIXEDLEADTIME,
	CANCELLATIONLEADTIME,
	YIELD,
	ORDERUNITOFMEASUREDSCODE,
	MAXIMUMLOTSIZE,
	MINIMUMLOTSIZE,
	MULTIPLEQTY,
	NUMBEROFDAYSSUPPLY,
	PLANNINGTIMEFENCE,
	PRIORITY,
	TARGETRATIO,
	TODATEQTY,
	TRANSFERSITECODE,
	TRANSFERSITEPARTCODE,
	AMLREFERENCE,
	PURCHASEDOCUMENTNUMBER,
	PURCHASEDOCUMENTITEM,
	STATUSCODE,
	DSCREATEUSER,
	DSCREATEDTS,
	DELETEFLAG,
	CORPORATIONDSTYPECODE,
	PURCHASINGORGANIZATIONCODE,
	ROWNUM
) as
/*--------------------------------------------------------------------

This view is used to ADD data into CONFORMED.SAP_SITEPARTSOURCE table
-----------------------------------------------------------------------
Revision History
-----------------------------------------------------------------------
Date            Developer               Comments
-----------------------------------------------------------------------
2021-03-22      Noel San Juan          Initial Revision
*/

SELECT 
    *
FROM 
    CONFORMED.V_ECC_SAP_SITEPARTSOURCE

UNION ALL

SELECT 
    *
FROM 
    CONFORMED.V_HCC_SAP_SITEPARTSOURCE;