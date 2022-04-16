create or replace view V_HCC_HA_CONTACTS(
	CONTACTTYPE,
	SITE,
	CONTACTCODE,
	CONTACTNAME,
	PHONE1,
	FAX,
	PROFITCENTER,
	EMAILADDRESS
) as
/*--------------------------------------------------------------------

This view is used to insert data into SAP.DIMCONTACTS
-----------------------------------------------------------------------
Revision History
-----------------------------------------------------------------------
Date            Developer               Comments
-----------------------------------------------------------------------
2021-03-01      Noel San Juan          Initial Revision
*/
SELECT *
FROM
(	
	SELECT DISTINCT
		'BUYER' AS CONTACTTYPE,
		''    AS SITE,
		ekgrp AS CONTACTCODE,
		eknam AS contactname,
		ektel AS PHONE1,
		telfx AS FAX,
		'' AS PROFITCENTER,
		smtp_addr AS EMAILADDRESS
		--SNFLK_UPDATEDON
	FROM
		CONFORMED.HCC_HA_T024
    
	UNION ALL

	SELECT DISTINCT
		'PLANNER' AS CONTACTTYPE,
		werks AS SITE,
		ekgrp AS CONTACTCODE,
		dsnam AS contactname,
		dstel AS PHONE1,
		''    AS FAX,
		prctr AS PROFITCENTER,
		'' AS EMAILADDRESS
        --SNFLK_UPDATEDON
	FROM
		CONFORMED.HCC_HA_T024D
) a;