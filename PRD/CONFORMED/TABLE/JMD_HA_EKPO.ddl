create or replace TABLE JMD_HA_EKPO (
	MANDT VARCHAR(3),
	EBELN VARCHAR(10),
	EBELP VARCHAR(5),
	LOEKZ VARCHAR(1),
	STATU VARCHAR(1),
	AEDAT VARCHAR(8),
	TXZ01 VARCHAR(40),
	MATNR VARCHAR(18),
	EMATN VARCHAR(18),
	BUKRS VARCHAR(4),
	WERKS VARCHAR(4),
	LGORT VARCHAR(4),
	BEDNR VARCHAR(10),
	MATKL VARCHAR(9),
	INFNR VARCHAR(10),
	IDNLF VARCHAR(35),
	KTMNG NUMBER(38,3),
	MENGE NUMBER(38,3),
	MEINS VARCHAR(3),
	BPRME VARCHAR(3),
	BPUMZ NUMBER(38,0),
	BPUMN NUMBER(38,0),
	UMREZ NUMBER(38,0),
	UMREN NUMBER(38,0),
	NETPR NUMBER(38,2),
	PEINH NUMBER(38,0),
	NETWR NUMBER(38,2),
	BRTWR NUMBER(38,2),
	AGDAT VARCHAR(8),
	WEBAZ NUMBER(38,0),
	MWSKZ VARCHAR(2),
	BONUS VARCHAR(2),
	INSMK VARCHAR(1),
	SPINF VARCHAR(1),
	PRSDR VARCHAR(1),
	SCHPR VARCHAR(1),
	MAHNZ NUMBER(38,0),
	MAHN1 NUMBER(38,0),
	MAHN2 NUMBER(38,0),
	MAHN3 NUMBER(38,0),
	UEBTO NUMBER(38,1),
	UEBTK VARCHAR(1),
	UNTTO NUMBER(38,1),
	BWTAR VARCHAR(10),
	BWTTY VARCHAR(1),
	ABSKZ VARCHAR(1),
	AGMEM VARCHAR(3),
	ELIKZ VARCHAR(1),
	EREKZ VARCHAR(1),
	PSTYP VARCHAR(1),
	KNTTP VARCHAR(1),
	KZVBR VARCHAR(1),
	VRTKZ VARCHAR(1),
	TWRKZ VARCHAR(1),
	WEPOS VARCHAR(1),
	WEUNB VARCHAR(1),
	REPOS VARCHAR(1),
	WEBRE VARCHAR(1),
	KZABS VARCHAR(1),
	LABNR VARCHAR(20),
	KONNR VARCHAR(10),
	KTPNR VARCHAR(5),
	ABDAT VARCHAR(8),
	ABFTZ NUMBER(38,3),
	ETFZ1 NUMBER(38,0),
	ETFZ2 NUMBER(38,0),
	KZSTU VARCHAR(1),
	NOTKZ VARCHAR(1),
	LMEIN VARCHAR(3),
	EVERS VARCHAR(2),
	ZWERT NUMBER(38,2),
	NAVNW NUMBER(38,2),
	ABMNG NUMBER(38,3),
	PRDAT VARCHAR(8),
	BSTYP VARCHAR(1),
	EFFWR NUMBER(38,2),
	XOBLR VARCHAR(1),
	KUNNR VARCHAR(10),
	ADRNR VARCHAR(10),
	EKKOL VARCHAR(4),
	SKTOF VARCHAR(1),
	STAFO VARCHAR(6),
	PLIFZ NUMBER(38,0),
	NTGEW NUMBER(38,3),
	GEWEI VARCHAR(3),
	TXJCD VARCHAR(15),
	ETDRK VARCHAR(1),
	SOBKZ VARCHAR(1),
	ARSNR VARCHAR(10),
	ARSPS VARCHAR(4),
	INSNC VARCHAR(1),
	SSQSS VARCHAR(8),
	ZGTYP VARCHAR(4),
	EAN11 VARCHAR(18),
	BSTAE VARCHAR(4),
	REVLV VARCHAR(2),
	GEBER VARCHAR(10),
	FISTL VARCHAR(16),
	FIPOS VARCHAR(14),
	KO_GSBER VARCHAR(4),
	KO_PARGB VARCHAR(4),
	KO_PRCTR VARCHAR(10),
	KO_PPRCTR VARCHAR(10),
	MEPRF VARCHAR(1),
	BRGEW NUMBER(38,3),
	VOLUM NUMBER(38,3),
	VOLEH VARCHAR(3),
	INCO1 VARCHAR(3),
	INCO2 VARCHAR(28),
	VORAB VARCHAR(1),
	KOLIF VARCHAR(10),
	LTSNR VARCHAR(6),
	PACKNO VARCHAR(10),
	FPLNR VARCHAR(10),
	GNETWR NUMBER(38,2),
	STAPO VARCHAR(1),
	UEBPO VARCHAR(5),
	LEWED VARCHAR(8),
	EMLIF VARCHAR(10),
	LBLKZ VARCHAR(1),
	SATNR VARCHAR(18),
	ATTYP VARCHAR(2),
	KANBA VARCHAR(1),
	ADRN2 VARCHAR(10),
	CUOBJ VARCHAR(18),
	XERSY VARCHAR(1),
	EILDT VARCHAR(8),
	DRDAT VARCHAR(8),
	DRUHR VARCHAR(6),
	DRUNR VARCHAR(4),
	AKTNR VARCHAR(10),
	ABELN VARCHAR(10),
	ABELP VARCHAR(5),
	ANZPU NUMBER(38,3),
	PUNEI VARCHAR(3),
	SAISO VARCHAR(4),
	SAISJ VARCHAR(4),
	EBON2 VARCHAR(2),
	EBON3 VARCHAR(2),
	EBONF VARCHAR(1),
	MLMAA VARCHAR(1),
	MHDRZ NUMBER(38,0),
	ANFNR VARCHAR(10),
	ANFPS VARCHAR(5),
	KZKFG VARCHAR(1),
	USEQU VARCHAR(1),
	UMSOK VARCHAR(1),
	BANFN VARCHAR(10),
	BNFPO VARCHAR(5),
	MTART VARCHAR(4),
	UPTYP VARCHAR(1),
	UPVOR VARCHAR(1),
	KZWI1 NUMBER(38,2),
	KZWI2 NUMBER(38,2),
	KZWI3 NUMBER(38,2),
	KZWI4 NUMBER(38,2),
	KZWI5 NUMBER(38,2),
	KZWI6 NUMBER(38,2),
	SIKGR VARCHAR(3),
	MFZHI NUMBER(38,3),
	FFZHI NUMBER(38,3),
	RETPO VARCHAR(1),
	AUREL VARCHAR(1),
	BSGRU VARCHAR(3),
	LFRET VARCHAR(4),
	MFRGR VARCHAR(8),
	NRFHG VARCHAR(1),
	J_1BNBM VARCHAR(16),
	J_1BMATUSE VARCHAR(1),
	J_1BMATORG VARCHAR(1),
	J_1BOWNPRO VARCHAR(1),
	J_1BINDUST VARCHAR(2),
	ABUEB VARCHAR(4),
	NLABD VARCHAR(8),
	NFABD VARCHAR(8),
	KZBWS VARCHAR(1),
	BONBA NUMBER(38,2),
	FABKZ VARCHAR(1),
	J_1AINDXP VARCHAR(5),
	J_1AIDATEP VARCHAR(8),
	MPROF VARCHAR(4),
	EGLKZ VARCHAR(1),
	KZTLF VARCHAR(1),
	KZFME VARCHAR(1),
	RDPRF VARCHAR(4),
	TECHS VARCHAR(12),
	CHG_SRV VARCHAR(1),
	CHG_FPLNR VARCHAR(1),
	MFRPN VARCHAR(40),
	MFRNR VARCHAR(10),
	EMNFR VARCHAR(10),
	NOVET VARCHAR(1),
	AFNAM VARCHAR(12),
	TZONRC VARCHAR(6),
	IPRKZ VARCHAR(1),
	LEBRE VARCHAR(1),
	BERID VARCHAR(10),
	XCONDITIONS VARCHAR(1),
	APOMS VARCHAR(1),
	CCOMP VARCHAR(1),
	GRANT_NBR VARCHAR(20),
	FKBER VARCHAR(16),
	STATUS VARCHAR(1),
	RESLO VARCHAR(4),
	KBLNR VARCHAR(10),
	KBLPOS VARCHAR(3),
	WEORA VARCHAR(1),
	SRV_BAS_COM VARCHAR(1),
	PRIO_URG VARCHAR(2),
	PRIO_REQ VARCHAR(3),
	EMPST VARCHAR(25),
	DIFF_INVOICE VARCHAR(2),
	TRMRISK_RELEVANT VARCHAR(2),
	SPE_ABGRU VARCHAR(2),
	SPE_CRM_SO VARCHAR(10),
	SPE_CRM_SO_ITEM VARCHAR(6),
	SPE_CRM_REF_SO VARCHAR(35),
	SPE_CRM_REF_ITEM VARCHAR(6),
	SPE_CRM_FKREL VARCHAR(1),
	SPE_CHNG_SYS VARCHAR(1),
	SPE_INSMK_SRC VARCHAR(1),
	SPE_CQ_CTRLTYPE VARCHAR(1),
	SPE_CQ_NOCQ VARCHAR(1),
	REASON_CODE VARCHAR(4),
	CQU_SAR NUMBER(38,3),
	ANZSN NUMBER(38,0),
	SPE_EWM_DTC VARCHAR(1),
	EXLIN VARCHAR(40),
	EXSNR VARCHAR(5),
	EHTYP VARCHAR(4),
	RETPC NUMBER(38,2),
	DPTYP VARCHAR(4),
	DPPCT NUMBER(38,2),
	DPAMT NUMBER(38,2),
	DPDAT VARCHAR(8),
	FLS_RSTO VARCHAR(1),
	EXT_RFX_NUMBER VARCHAR(35),
	EXT_RFX_ITEM VARCHAR(10),
	EXT_RFX_SYSTEM VARCHAR(10),
	SRM_CONTRACT_ID VARCHAR(10),
	SRM_CONTRACT_ITM VARCHAR(10),
	BLK_REASON_ID VARCHAR(4),
	BLK_REASON_TXT VARCHAR(40),
	ITCONS VARCHAR(1),
	FIXMG VARCHAR(1),
	WABWE VARCHAR(1),
	TC_AUT_DET VARCHAR(2),
	MANUAL_TC_REASON VARCHAR(2),
	FISCAL_INCENTIVE VARCHAR(4),
	TAX_SUBJECT_ST VARCHAR(1),
	FISCAL_INCENTIVE_ID VARCHAR(4),
	BEV1_NEGEN_ITEM VARCHAR(1),
	BEV1_NEDEPFREE VARCHAR(1),
	BEV1_NESTRUCCAT VARCHAR(1),
	ADVCODE VARCHAR(2),
	BUDGET_PD VARCHAR(10),
	EXCPE VARCHAR(2),
	FMFGUS_KEY VARCHAR(22),
	IUID_RELEVANT VARCHAR(1),
	MRPIND VARCHAR(1),
	ZZM_REGMS VARCHAR(11),
	REFSITE VARCHAR(4),
	REF_ITEM VARCHAR(5),
	SOURCE_ID VARCHAR(3),
	SOURCE_KEY VARCHAR(32),
	PUT_BACK VARCHAR(1),
	POL_ID VARCHAR(10),
	CONS_ORDER VARCHAR(1),
	FRMW_EXTRACTED_ON TIMESTAMP_NTZ(9),
	SNFLK_UPDATEDON TIMESTAMP_NTZ(9)
);