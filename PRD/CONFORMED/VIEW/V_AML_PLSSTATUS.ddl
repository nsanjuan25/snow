create or replace view V_AML_PLSSTATUS(
	AMLREFERENCE,
	SITECODE,
	PLSAMLSTATUSSTANDARDCODE,
	SITEID
) as 
/*
/*-------------------------------------------------------------------------------------------------

This view is used to insert data into SAP.DIMAML
-----------------------------------------------------------------------------------------------
Revision History
-----------------------------------------------------------------------------------------------
Date            Developer               Comments
----------------------------------------------------------------------------------------------
2021-01-28      Venkata             Initial Revision
*/
    SELECT 
       LTRIM(RTRIM(EJA.amlreference )) AS amlreference
     , EJS.SiteCode           
     , EJASS.AMLStatusStdCode AS PLSAMLStatusStandardCode
     ,EJS.SiteID
FROM 
     conformed.scmdb_AML AS EJA  
     INNER JOIN conformed.scmdb_site AS EJS ON EJS.SiteID = EJA.siteid     
     INNER JOIN conformed.scmdb_AMLstatusstd AS EJASS ON EJA.plsamlstatusstdid = EJASS.AMLStatusStdID;