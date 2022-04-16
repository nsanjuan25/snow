create or replace view V_HCC_HA_MRP(
	MANDT,
	RCOUNT,
	MATNR,
	WRK01,
	LGORT,
	DAT00,
	DELKZ,
	VRFKZ,
	PLUMI,
	MNG01,
	BAART,
	DEL12,
	UMDAT,
	AUSSL,
	SOBKZ,
	KDAUF,
	KDPOS,
	LIFNR,
	BAUGR,
	AUFVR,
	DAT01,
	DAT02,
	DELET,
	DELNR,
	DELPS,
	FIX01,
	FIX02,
	OLDSL,
	WRK02,
	MDWRK,
	DTART,
	SEQGEN,
	FRMW_EXTRACTED_ON,
	SNFLK_UPDATEDON,
	MEINS,
	DSTMP,
	DISST,
	FLIEF_EBAN,
	FLIEF_PLAF,
	PLANNINGSTRATEGYGROUP,
	DATASOURCEKEY,
	DEMAND_SNAPSHOT,
	CANCELLATIONLEADTIME
) as
/*--------------------------------------------------------------------------------------------

This view is used to insert data into SAP.FactMRP
----------------------------------------------------------------------------------------------
Revision History
----------------------------------------------------------------------------------------------
Date            Developer               Comments
----------------------------------------------------------------------------------------------
2021-03-03      Carlos Carrillo             Initial Revision
                                        
*/ 

SELECT z.MANDT,
       z.RCOUNT,
       z.MATNR,
       z.WRK01,
       z.LGORT,
       z.DAT00,
       z.DELKZ,
       z.VRFKZ,
       z.PLUMI,
       z.MNG01,
       z.BAART,
       z.DEL12,
       z.UMDAT,
       z.AUSSL,
       z.SOBKZ,
       z.KDAUF,
       z.KDPOS,
       z.LIFNR,
       z.BAUGR,
       z.AUFVR,
       z.DAT01,
       z.DAT02,
       z.DELET,
       z.DELNR,
       z.DELPS,
       z.FIX01,
       z.FIX02,
       z.OLDSL,
       z.WRK02,
       z.MDWRK,
       z.DTART,
       z.SEQGEN,
       z.FRMW_EXTRACTED_ON,
       z.SNFLK_UPDATEDON,
       m.MEINS,
       d.dstmp,
       m.disst,
       eban.flief AS flief_eban,
       plaf.flief AS flief_plaf,
       s.PlanningStrategyGroup,
       2 as DataSourceKey,
       cast(z.FRMW_EXTRACTED_ON as date)  as Demand_Snapshot,
        sub.mahn3 as cancellationleadtime                     
FROM CONFORMED.HCC_HA_ZEXTMDPSX z
    LEFT JOIN CONFORMED.HCC_HA_MARA m
        ON z.matnr = m.matnr
    LEFT JOIN CONFORMED.HCC_HA_DBVM d
        ON m.matnr = d.matnr
           AND z.wrk01 = d.berid
    LEFT JOIN CONFORMED.HCC_HA_EBAN eban
        ON eban.banfn = z.delnr
           AND eban.bnfpo = z.delps
    LEFT JOIN
    (
        SELECT ekpo.ebeln,
               ekpo.ebelp,
               ekko.lifnr,
               ekpo.ematn,
               ekpo.mahn3
        FROM CONFORMED.HCC_HA_EKKO ekko
            INNER JOIN CONFORMED.HCC_HA_EKPO ekpo
                ON ekpo.ebeln = ekko.ebeln
    ) sub
        ON sub.ebeln = z.delnr
           AND sub.ebelp = z.delps
    LEFT JOIN CONFORMED.V_HCC_HA_SITEPARTS s
        ON s.sitecode = z.wrk01
           AND s.sitepartcode = z.matnr
    LEFT JOIN CONFORMED.BW_HA_PLAF plaf
        ON plaf.plnum = z.delnr
WHERE 
         cast(z.FRMW_EXTRACTED_ON as date) >= DATEADD(day,0,current_date);