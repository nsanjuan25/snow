create or replace view V_FACTSHIPMENTS(
	TKNUM,
	TPNUM,
	VBELN,
	TPRFO,
	ERNAM,
	ERDAT,
	ERZET,
	PKSTA,
	KZHULFG,
	ZZDATE,
	ZZTIME,
	VBTYP,
	SHTYP,
	TPLST,
	AENAM,
	AEDAT,
	AEZET,
	STERM,
	ABFER,
	ABWST,
	BFART,
	VSART,
	VSAVL,
	VSANL,
	LAUFK,
	VSBED,
	ROUTE,
	SIGNI,
	EXTI1,
	EXTI2,
	TPBEZ,
	STDIS,
	DTDIS,
	UZDIS,
	STREG,
	DPREG,
	UPREG,
	DAREG,
	UAREG,
	STLBG,
	DPLBG,
	UPLBG,
	DALBG,
	UALBG,
	STLAD,
	DPLEN,
	UPLEN,
	DALEN,
	UALEN,
	STABF,
	DPABF,
	UPABF,
	DTABF,
	UZABF,
	STTBG,
	DPTBG,
	UPTBG,
	DATBG,
	UATBG,
	STTEN,
	DPTEN,
	UPTEN,
	DATEN,
	UATEN,
	STTRG,
	TDLNR,
	TERNR,
	PKSTK,
	DTMEG,
	DTMEV,
	DISTZ,
	MEDST,
	FAHZT,
	GESZT,
	MEIZT,
	STAFO,
	FBSTA,
	FBGST,
	ARSTA,
	ARGST,
	STERM_DONE,
	VSE_FRK,
	KKALSM,
	SDABW,
	FRKRL,
	GESZTD,
	FAHZTD,
	GESZTDA,
	FAHZTDA,
	ROCPY_DONE,
	HANDLE,
	TSEGFL,
	TSEGTP,
	ADD01,
	ADD02,
	ADD03,
	ADD04,
	TEXT1,
	TEXT2,
	TEXT3,
	TEXT4,
	PROLI,
	DGTLOCK,
	DGMDDAT,
	CONT_DG,
	WARZTD,
	WARZTDA,
	AULWE,
	TNDRST,
	TNDRRC,
	TNDR_TEXT,
	TNDRDAT,
	TNDRZET,
	TNDR_MAXP,
	TNDR_MAXC,
	TNDR_ACTP,
	TNDR_ACTC,
	TNDR_CARR,
	TNDR_CRNM,
	TNDR_TRKID,
	TNDR_EXPD,
	TNDR_EXPT,
	TNDR_ERPD,
	TNDR_ERPT,
	TNDR_LTPD,
	TNDR_LTPT,
	TNDR_ERDD,
	TNDR_ERDT,
	TNDR_LTDD,
	TNDR_LTDT,
	TNDR_LDLG,
	TNDR_LDLU,
	KZHULFR,
	ALLOWED_TWGT,
	VLSTK,
	VERURSYS,
	CM_IDENT,
	CM_SEQUENCE,
	EXT_FREIGHT_ORD,
	EXT_TM_SYS,
	BEV1_RPFAR1,
	BEV1_RPFAR2,
	BEV1_RPMOWA,
	BEV1_RPANHAE,
	BEV1_RPFLGNR,
	VSO_R_STATUS
) as
SELECT vttp.TKNUM,
     vttp.TPNUM,
     vttp.VBELN,
     vttp.TPRFO,
     vttp.ERNAM,
     vttp.ERDAT,
     vttp.ERZET,
     vttp.PKSTA,
     vttp.KZHULFG,
     vttp.ZZDATE,
     vttp.ZZTIME,
     COALESCE(vttk.VBTYP,'') AS VBTYP,
     COALESCE(vttk.SHTYP,'') AS SHTYP,
     COALESCE(vttk.TPLST,'') AS TPLST,
     COALESCE(vttk.AENAM,'') AS AENAM,
     CASE WHEN vttk.AEDAT='00000000' OR vttk.AEDAT IS NULL THEN '1900-01-01'
		ELSE 
		CAST ( CONCAT( LEFT( vttk.AEDAT , 4) , '-' ,  SUBSTRING(vttk.AEDAT, 5,2) , '-', RIGHT( vttk.AEDAT, 2) ) AS DATE )
		END AS AEDAT,
     COALESCE(vttk.AEZET,'') AS AEZET,
     COALESCE(vttk.STERM,'') AS STERM,
     COALESCE(vttk.ABFER,'') AS ABFER,
     COALESCE(vttk.ABWST,'') AS ABWST,
     COALESCE(vttk.BFART,'') AS BFART,
     COALESCE(vttk.VSART,'') AS VSART,
     COALESCE(vttk.VSAVL,'') AS VSAVL,
     COALESCE(vttk.VSANL,'') AS VSANL,
     COALESCE(vttk.LAUFK,'') AS LAUFK,
     COALESCE(vttk.VSBED,'') AS VSBED,
     COALESCE(vttk.ROUTE,'') AS ROUTE,
     COALESCE(vttk.SIGNI,'') AS SIGNI,
     COALESCE(vttk.EXTI1,'') AS EXTI1,
     COALESCE(vttk.EXTI2,'') AS EXTI2,
     COALESCE(vttk.TPBEZ,'') AS TPBEZ,
     COALESCE(vttk.STDIS,'') AS STDIS,
     CASE WHEN vttk.DTDIS='00000000' OR vttk.DTDIS IS NULL THEN '1900-01-01'
		ELSE 
		CAST ( CONCAT( LEFT( vttk.DTDIS , 4) , '-' ,  SUBSTRING(vttk.DTDIS, 5,2) , '-', RIGHT( vttk.DTDIS, 2) ) AS DATE )
		END AS DTDIS,  --
     COALESCE(vttk.UZDIS,'') AS UZDIS,
     COALESCE(vttk.STREG,'') AS STREG,
     CASE WHEN vttk.DPREG='00000000' OR vttk.DPREG IS NULL THEN '1900-01-01'
		ELSE 
		CAST ( CONCAT( LEFT( vttk.DPREG , 4) , '-' ,  SUBSTRING(vttk.DPREG, 5,2) , '-', RIGHT( vttk.DPREG, 2) ) AS DATE )
		END AS DPREG,
     COALESCE(vttk.UPREG,'') AS UPREG,
     CASE WHEN vttk.DAREG='00000000' OR vttk.DAREG IS NULL THEN '1900-01-01'
		ELSE 
		CAST ( CONCAT( LEFT( vttk.DAREG , 4) , '-' ,  SUBSTRING(vttk.DAREG, 5,2) , '-', RIGHT( vttk.DAREG, 2) ) AS DATE )
		END AS DAREG,
     COALESCE(vttk.UAREG,'') AS UAREG,
     COALESCE(vttk.STLBG,'') AS STLBG,
     CASE WHEN vttk.DPLBG='00000000' OR vttk.DPLBG IS NULL THEN '1900-01-01'
		ELSE 
		CAST ( CONCAT( LEFT( vttk.DPLBG , 4) , '-' ,  SUBSTRING(vttk.DPLBG, 5,2) , '-', RIGHT( vttk.DPLBG, 2) ) AS DATE )
		END AS DPLBG,
     COALESCE(vttk.UPLBG,'') AS UPLBG,
     CASE WHEN vttk.DALBG='00000000' OR vttk.DALBG IS NULL THEN '1900-01-01'
		ELSE 
		CAST ( CONCAT( LEFT( vttk.DALBG , 4) , '-' ,  SUBSTRING(vttk.DALBG, 5,2) , '-', RIGHT( vttk.DALBG, 2) ) AS DATE )
		END AS DALBG,
     COALESCE(vttk.UALBG,'') AS UALBG,
     COALESCE(vttk.STLAD,'') AS STLAD,
     CASE WHEN vttk.DPLEN='00000000' OR vttk.DPLEN IS NULL THEN '1900-01-01'
		ELSE 
		CAST ( CONCAT( LEFT( vttk.DPLEN , 4) , '-' ,  SUBSTRING(vttk.DPLEN, 5,2) , '-', RIGHT( vttk.DPLEN, 2) ) AS DATE )
		END AS DPLEN,
     COALESCE(vttk.UPLEN,'') AS UPLEN,
     CASE WHEN vttk.DALEN='00000000' OR vttk.DALEN IS NULL THEN '1900-01-01'
		ELSE 
		CAST ( CONCAT( LEFT( vttk.DALEN , 4) , '-' ,  SUBSTRING(vttk.DALEN, 5,2) , '-', RIGHT( vttk.DALEN, 2) ) AS DATE )
		END AS DALEN,
     COALESCE(vttk.UALEN,'') AS UALEN,
     COALESCE(vttk.STABF,'') AS STABF,
     CASE WHEN vttk.DPABF='00000000' OR vttk.DPABF IS NULL THEN '1900-01-01'
		ELSE 
		CAST ( CONCAT( LEFT( vttk.DPABF , 4) , '-' ,  SUBSTRING(vttk.DPABF, 5,2) , '-', RIGHT( vttk.DPABF, 2) ) AS DATE )
		END AS DPABF,
     COALESCE(vttk.UPABF,'') AS UPABF,
     CASE WHEN vttk.DTABF='00000000' OR vttk.DTABF IS NULL THEN '1900-01-01'
		ELSE 
		CAST ( CONCAT( LEFT( vttk.DTABF , 4) , '-' ,  SUBSTRING(vttk.DTABF, 5,2) , '-', RIGHT( vttk.DTABF, 2) ) AS DATE )
		END AS DTABF,
     COALESCE(vttk.UZABF,'') AS UZABF,
     COALESCE(vttk.STTBG,'') AS STTBG,
     CASE WHEN vttk.DPTBG='00000000' OR vttk.DPTBG IS NULL THEN '1900-01-01'
		ELSE 
		CAST ( CONCAT( LEFT( vttk.DPTBG , 4) , '-' ,  SUBSTRING(vttk.DPTBG, 5,2) , '-', RIGHT( vttk.DPTBG, 2) ) AS DATE )
		END AS DPTBG,
     COALESCE(vttk.UPTBG,'') AS UPTBG,
     CASE WHEN vttk.DATBG='00000000' OR vttk.DATBG IS NULL THEN '1900-01-01'
		ELSE 
		CAST ( CONCAT( LEFT( vttk.DATBG , 4) , '-' ,  SUBSTRING(vttk.DATBG, 5,2) , '-', RIGHT( vttk.DATBG, 2) ) AS DATE )
		END AS DATBG,
     COALESCE(vttk.UATBG,'') AS UATBG,
     COALESCE(vttk.STTEN,'') AS STTEN,
     CASE WHEN vttk.DPTEN='00000000' OR vttk.DPTEN IS NULL THEN '1900-01-01'
		ELSE 
		CAST ( CONCAT( LEFT( vttk.DPTEN , 4) , '-' ,  SUBSTRING(vttk.DPTEN, 5,2) , '-', RIGHT( vttk.DPTEN, 2) ) AS DATE )
		END AS DPTEN,
     COALESCE(vttk.UPTEN,'') AS UPTEN,
     CASE WHEN vttk.DATEN='00000000' OR vttk.DATEN IS NULL THEN '1900-01-01'
		ELSE 
		CAST ( CONCAT( LEFT( vttk.DATEN , 4) , '-' ,  SUBSTRING(vttk.DATEN, 5,2) , '-', RIGHT( vttk.DATEN, 2) ) AS DATE )
		END AS DATEN,
     COALESCE(vttk.UATEN,'') AS UATEN,
     COALESCE(vttk.STTRG,'') AS STTRG,
     COALESCE(vttk.TDLNR,'') AS TDLNR,
     COALESCE(vttk.TERNR,'') AS TERNR,
     COALESCE(vttk.PKSTK,'') AS PKSTK,
     COALESCE(vttk.DTMEG,'') AS DTMEG,
     COALESCE(vttk.DTMEV,'') AS DTMEV,
     COALESCE(vttk.DISTZ,0)  AS DISTZ,
     COALESCE(vttk.MEDST,'') AS MEDST,
     COALESCE(vttk.FAHZT,0)  AS FAHZT,
     COALESCE(vttk.GESZT,0)  AS GESZT,
     COALESCE(vttk.MEIZT,'') AS MEIZT,
     COALESCE(vttk.STAFO,'') AS STAFO,
     COALESCE(vttk.FBSTA,'') AS FBSTA,
     COALESCE(vttk.FBGST,'') AS FBGST,
     COALESCE(vttk.ARSTA,'') AS ARSTA,
     COALESCE(vttk.ARGST,'') AS ARGST,
     COALESCE(vttk.STERM_DONE,'') AS STERM_DONE,
     COALESCE(vttk.VSE_FRK,'') AS VSE_FRK,
     COALESCE(vttk.KKALSM,'') AS KKALSM,
     COALESCE(vttk.SDABW,'') AS SDABW,
     COALESCE(vttk.FRKRL,'') AS FRKRL,
     COALESCE(vttk.GESZTD,0) AS GESZTD,
     COALESCE(vttk.FAHZTD,0) AS FAHZTD,
     COALESCE(vttk.GESZTDA,0) AS GESZTDA,
     COALESCE(vttk.FAHZTDA,0) AS FAHZTDA,
     COALESCE(vttk.ROCPY_DONE,'') AS ROCPY_DONE,
     COALESCE(vttk.HANDLE,'') AS HANDLE,
     COALESCE(vttk.TSEGFL,'') AS TSEGFL,
     COALESCE(vttk.TSEGTP,'') AS TSEGTP,
     COALESCE(vttk.ADD01,'') AS ADD01,
     COALESCE(vttk.ADD02,'') AS ADD02,
     COALESCE(vttk.ADD03,'') AS ADD03,
     COALESCE(vttk.ADD04,'') AS ADD04,
     COALESCE(vttk.TEXT1,'') AS TEXT1,
     COALESCE(vttk.TEXT2,'') AS TEXT2,
     COALESCE(vttk.TEXT3,'') AS TEXT3,
     COALESCE(vttk.TEXT4,'') AS TEXT4,
     COALESCE(vttk.PROLI,'') AS PROLI,
     COALESCE(vttk.DGTLOCK,'') AS DGTLOCK,
     CASE WHEN vttk.DGMDDAT='00000000' OR vttk.DGMDDAT IS NULL THEN '1900-01-01'
		ELSE 
		CAST ( CONCAT( LEFT( vttk.DGMDDAT , 4) , '-' ,  SUBSTRING(vttk.DGMDDAT, 5,2) , '-', RIGHT( vttk.DGMDDAT, 2) ) AS DATE )
		END AS DGMDDAT,
     COALESCE(vttk.CONT_DG,'') AS CONT_DG,
     COALESCE(vttk.WARZTD,0) AS WARZTD,
     COALESCE(vttk.WARZTDA,0) AS WARZTDA,
     COALESCE(vttk.AULWE,'') AS AULWE,
     COALESCE(vttk.TNDRST,'') AS TNDRST,
     COALESCE(vttk.TNDRRC,'') AS TNDRRC,
     COALESCE(vttk.TNDR_TEXT,'') AS TNDR_TEXT,
     CASE WHEN vttk.TNDRDAT='00000000' OR vttk.TNDRDAT IS NULL THEN '1900-01-01'
		ELSE 
		CAST ( CONCAT( LEFT( vttk.TNDRDAT , 4) , '-' ,  SUBSTRING(vttk.TNDRDAT, 5,2) , '-', RIGHT( vttk.TNDRDAT, 2) ) AS DATE )
		END AS TNDRDAT,
     COALESCE(vttk.TNDRZET,'') AS TNDRZET,
     COALESCE(vttk.TNDR_MAXP,0) AS TNDR_MAXP,
     COALESCE(vttk.TNDR_MAXC,'') AS TNDR_MAXC,
     COALESCE(vttk.TNDR_ACTP,0) AS TNDR_ACTP,
     COALESCE(vttk.TNDR_ACTC,'') AS TNDR_ACTC,
     COALESCE(vttk.TNDR_CARR,'') AS TNDR_CARR,
     COALESCE(vttk.TNDR_CRNM,'') AS TNDR_CRNM,
     COALESCE(vttk.TNDR_TRKID,'') AS TNDR_TRKID,
     CASE WHEN vttk.TNDR_EXPD='00000000' OR vttk.TNDR_EXPD IS NULL THEN '1900-01-01'
		ELSE 
		CAST ( CONCAT( LEFT( vttk.TNDR_EXPD , 4) , '-' ,  SUBSTRING(vttk.TNDR_EXPD, 5,2) , '-', RIGHT( vttk.TNDR_EXPD, 2) ) AS DATE )
		END AS TNDR_EXPD,
     COALESCE(vttk.TNDR_EXPT,'') AS TNDR_EXPT,
     CASE WHEN vttk.TNDR_ERPD='00000000' OR vttk.TNDR_ERPD IS NULL THEN '1900-01-01'
		ELSE 
		CAST ( CONCAT( LEFT( vttk.TNDR_ERPD , 4) , '-' ,  SUBSTRING(vttk.TNDR_ERPD, 5,2) , '-', RIGHT( vttk.TNDR_ERPD, 2) ) AS DATE )
		END AS TNDR_ERPD,
     COALESCE(vttk.TNDR_ERPT,'') AS TNDR_ERPT,
     CASE WHEN vttk.TNDR_LTPD='00000000' OR vttk.TNDR_LTPD IS NULL THEN '1900-01-01'
		ELSE 
		CAST ( CONCAT( LEFT( vttk.TNDR_LTPD , 4) , '-' ,  SUBSTRING(vttk.TNDR_LTPD, 5,2) , '-', RIGHT( vttk.TNDR_LTPD, 2) ) AS DATE )
		END AS TNDR_LTPD,
     COALESCE(vttk.TNDR_LTPT,'') AS TNDR_LTPT,
     CASE WHEN vttk.TNDR_ERDD='00000000' OR vttk.TNDR_ERDD IS NULL THEN '1900-01-01'
		ELSE 
		CAST ( CONCAT( LEFT( vttk.TNDR_ERDD , 4) , '-' ,  SUBSTRING(vttk.TNDR_ERDD, 5,2) , '-', RIGHT( vttk.TNDR_ERDD, 2) ) AS DATE )
		END AS TNDR_ERDD,
     COALESCE(vttk.TNDR_ERDT,'') AS TNDR_ERDT,
     CASE WHEN vttk.TNDR_LTDD='00000000' OR vttk.TNDR_LTDD IS NULL THEN '1900-01-01'
		ELSE 
		CAST ( CONCAT( LEFT( vttk.TNDR_LTDD , 4) , '-' ,  SUBSTRING(vttk.TNDR_LTDD, 5,2) , '-', RIGHT( vttk.TNDR_LTDD, 2) ) AS DATE )
		END AS TNDR_LTDD,
     COALESCE(vttk.TNDR_LTDT,'') AS TNDR_LTDT,
     COALESCE(vttk.TNDR_LDLG,0) AS TNDR_LDLG,
     COALESCE(vttk.TNDR_LDLU,'') AS TNDR_LDLU,
     COALESCE(vttk.KZHULFR,'') AS KZHULFR,
     COALESCE(vttk.ALLOWED_TWGT,0) AS ALLOWED_TWGT,
     COALESCE(vttk.VLSTK,'') AS VLSTK,
     COALESCE(vttk.VERURSYS,'') AS VERURSYS,
     COALESCE(vttk.CM_IDENT,'') AS CM_IDENT,
     COALESCE(vttk.CM_SEQUENCE,'') CM_SEQUENCE,
     COALESCE(vttk.EXT_FREIGHT_ORD,'') AS EXT_FREIGHT_ORD,
     COALESCE(vttk.EXT_TM_SYS,'') AS EXT_TM_SYS,
     COALESCE(vttk.BEV1_RPFAR1,'') AS BEV1_RPFAR1,
     COALESCE(vttk.BEV1_RPFAR2,'') AS BEV1_RPFAR2,
     COALESCE(vttk.BEV1_RPMOWA,'') AS BEV1_RPMOWA,
     COALESCE(vttk.BEV1_RPANHAE,'') AS BEV1_RPANHAE,
     COALESCE(vttk.BEV1_RPFLGNR,'') AS BEV1_RPFLGNR,
     COALESCE(vttk.VSO_R_STATUS,'') AS VSO_R_STATUS
FROM Conformed.ecc_ha_vttp vttp  --Items
LEFT OUTER JOIN
     CONFORMED.ECC_HA_VTTK  vttk  --header
         on vttp.TKNUM = vttk.TKNUM
;