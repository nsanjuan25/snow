create or replace view V_BSEG_BKPF(
	EBELN,
	BELNR,
	GJAHR,
	BUKRS,
	BUZID,
	DMBE2,
	MENGE,
	PRCTR,
	XREF1,
	ZTERM,
	LIFNR,
	EBELP,
	AWKEY,
	BLDAT,
	BUDAT,
	HKONT,
	AUGBL,
	BLART,
	ZUONR,
	WRBTR,
	XREF1_HD,
	XBLNR,
	WAERS,
	UPDATED_ON,
	BUZEI,
	HWAE2,
	XREF2_HD,
	KTOSL,
	KOART,
	BSCHL
) as SELECT   
    BS.ebeln,
    BS.belnr,
    BS.gjahr,
    BS.bukrs,
    BS.buzid,
    BS.dmbe2,
    BS.menge,
    BS.prctr, BS.xref1,
    BS.zterm,
    BS.lifnr,
    BS.ebelp, 
    BS.awkey,
    BS.bldat, 
    BS.budat,
    BS.hkont, 
    BS.augbl, 
    BS.BLART, 
    BS.ZUONR, 
    BS.WRBTR, 
    ifnull(BK.XREF1_HD, '') AS XREF1_HD,
    ifnull(BK.XBLNR, '') AS XBLNR,
    ifnull(BK.WAERS, '') AS WAERS, 
    bs.SNFLK_UPDATEDON as updated_on, 
    bs.BUZEI, 
    bk.HWAE2, 
    bk.XREF2_HD,
    CASE WHEN bs.ktosl = 'NULL' THEN ''
    ELSE IFNULL(bs.ktosl,'')
    END AS ktosl ,
    bs.koart,
    bs.BSCHL

 

FROM            CONFORMED.BW_HA_BSEG BS LEFT JOIN
                         CONFORMED.ecc_ha_bkpf BK ON bk.bukrs = bs.bukrs AND bk.belnr = bs.belnr AND bk.gjahr = bs.gjahr
WHERE           bs.BLART IN ('ZK', 'ZG') 
             or (BS.bukrs = '0606' and BS.blart in ('KE','KF','KI','KR','KX','Y6'))
             or ((BS.bukrs in ('1301','1302') and BS.blart in ('KF','KI','Z3','Z4','Y6','KR','ZE','KG','Y4','KA','KE','EX','RE','KX'))) AND bs.SNFLK_UPDATEDON>= '2020-01-01'
union all
SELECT        
    BS.ebeln,
    BS.belnr, 
    BS.gjahr, 
    BS.bukrs, 
    BS.buzid, 
    BS.dmbe2, 
    BS.menge, 
    BS.prctr, 
    BS.xref1, 
    BS.zterm, 
    BS.lifnr, 
    BS.ebelp, 
    BS.awkey, 
    BS.bldat, 
    BS.budat, 
    BS.hkont, 
    BS.augbl, 
    BS.BLART, 
    BS.ZUONR, 
    BS.WRBTR, 
    ifnull(BK.XREF1_HD, '') AS XREF1_HD, 
    ifnull(BK.XBLNR, '') AS XBLNR, 
    ifnull(BK.WAERS, '') AS WAERS, 
    bs.SNFLK_UPDATEDON as updated_on,
    bs.BUZEI, 
    bk.HWAE2, 
    bk.XREF2_HD,
    CASE WHEN bs.ktosl = 'NULL' THEN ''
    ELSE IFNULL(bs.ktosl,'')
    END AS ktosl ,
    bs.koart,
    bs.BSCHL 
FROM           CONFORMED.BW_HA_BSEG BS LEFT JOIN
                         CONFORMED.ecc_ha_bkpf BK ON bk.bukrs = bs.bukrs AND bk.belnr = bs.belnr AND bk.gjahr = bs.gjahr
WHERE        (bs.hkont = '0000020100') AND (bs.augbl = '') 

 

AND bs.SNFLK_UPDATEDON>= '2020-01-01' ;