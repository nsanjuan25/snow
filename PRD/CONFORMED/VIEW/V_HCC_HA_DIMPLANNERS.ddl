create or replace view V_HCC_HA_DIMPLANNERS(
	PLANNERCODE,
	PLANTCODE,
	MRPCONTROLLER,
	FULLNAME,
	PHONE1,
	PROFITCENTER
) as
SELECT
    concat(ifnull(dispo,'') , '-', ifnull(werks,'')  ) as plannercode,
    ifnull(werks,'')     as plantcode,    
    ifnull(dispo,'')     as mrpcontroller,
    ifnull(dsnam,'') as fullname,
    ifnull(dstel,'') as phone1,
    ifnull(prctr,'') as profitcenter
FROM 
    conformed.hcc_ha_t024d;