create or replace view V_PLA_HA_DIMPLANNERS(
	PLANNERCODE,
	PLANTCODE,
	MRPCONTROLLER,
	FULLNAME,
	PHONE1,
	PROFITCENTER
) as
/*--------------------------------------------------------------------------------------------

This view is used to insert data into SAP.v_dimplanners
----------------------------------------------------------------------------------------------
Revision History
----------------------------------------------------------------------------------------------
Date            Developer               Comments
----------------------------------------------------------------------------------------------
2021-09-21      Jagan                   Initial Revision
*/
SELECT 
       ifnull(dispo,'')||'-'||ifnull(werks,'') as plannercode
     , ifnull(werks,'')                        as plantcode
     , ifnull(dispo,'')                        as mrpcontroller
     , ifnull(dsnam,'')                        as fullname
     , ifnull(dstel,'')                        as phone1
     , ifnull(prctr,'')                        as profitcenter
FROM   conformed.PLA_ha_t024d;