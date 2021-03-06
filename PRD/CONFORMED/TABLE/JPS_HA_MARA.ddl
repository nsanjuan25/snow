create or replace TABLE JPS_HA_MARA (
	MANDT VARCHAR(3),
	MATNR VARCHAR(40),
	ERSDA VARCHAR(8),
	ERNAM VARCHAR(12),
	LAEDA VARCHAR(8),
	AENAM VARCHAR(12),
	VPSTA VARCHAR(15),
	PSTAT VARCHAR(15),
	LVORM VARCHAR(1),
	MTART VARCHAR(4),
	MBRSH VARCHAR(1),
	MATKL VARCHAR(9),
	BISMT VARCHAR(40),
	MEINS VARCHAR(3),
	BSTME VARCHAR(3),
	ZEINR VARCHAR(22),
	ZEIAR VARCHAR(3),
	ZEIVR VARCHAR(2),
	ZEIFO VARCHAR(4),
	AESZN VARCHAR(6),
	BLATT VARCHAR(3),
	BLANZ VARCHAR(3),
	FERTH VARCHAR(18),
	FORMT VARCHAR(4),
	GROES VARCHAR(32),
	WRKST VARCHAR(48),
	NORMT VARCHAR(18),
	LABOR VARCHAR(3),
	EKWSL VARCHAR(4),
	BRGEW NUMBER(38,3),
	NTGEW NUMBER(38,3),
	GEWEI VARCHAR(3),
	VOLUM NUMBER(38,3),
	VOLEH VARCHAR(3),
	BEHVO VARCHAR(2),
	RAUBE VARCHAR(2),
	TEMPB VARCHAR(2),
	DISST VARCHAR(3),
	TRAGR VARCHAR(4),
	STOFF VARCHAR(40),
	SPART VARCHAR(2),
	KUNNR VARCHAR(10),
	EANNR VARCHAR(13),
	WESCH NUMBER(38,3),
	BWVOR VARCHAR(1),
	BWSCL VARCHAR(1),
	SAISO VARCHAR(4),
	ETIAR VARCHAR(2),
	ETIFO VARCHAR(2),
	ENTAR VARCHAR(1),
	EAN11 VARCHAR(18),
	NUMTP VARCHAR(2),
	LAENG NUMBER(38,3),
	BREIT NUMBER(38,3),
	HOEHE NUMBER(38,3),
	MEABM VARCHAR(3),
	PRDHA VARCHAR(18),
	AEKLK VARCHAR(1),
	CADKZ VARCHAR(1),
	QMPUR VARCHAR(1),
	ERGEW NUMBER(38,3),
	ERGEI VARCHAR(3),
	ERVOL NUMBER(38,3),
	ERVOE VARCHAR(3),
	GEWTO NUMBER(38,1),
	VOLTO NUMBER(38,1),
	VABME VARCHAR(1),
	KZREV VARCHAR(1),
	KZKFG VARCHAR(1),
	XCHPF VARCHAR(1),
	VHART VARCHAR(4),
	FUELG NUMBER(38,0),
	STFAK NUMBER(38,0),
	MAGRV VARCHAR(4),
	BEGRU VARCHAR(4),
	DATAB VARCHAR(8),
	LIQDT VARCHAR(8),
	SAISJ VARCHAR(4),
	PLGTP VARCHAR(2),
	MLGUT VARCHAR(1),
	EXTWG VARCHAR(18),
	SATNR VARCHAR(40),
	ATTYP VARCHAR(2),
	KZKUP VARCHAR(1),
	KZNFM VARCHAR(1),
	PMATA VARCHAR(40),
	MSTAE VARCHAR(2),
	MSTAV VARCHAR(2),
	MSTDE VARCHAR(8),
	MSTDV VARCHAR(8),
	TAKLV VARCHAR(1),
	RBNRM VARCHAR(9),
	MHDRZ NUMBER(38,0),
	MHDHB NUMBER(38,0),
	MHDLP NUMBER(38,0),
	INHME VARCHAR(3),
	INHAL NUMBER(38,3),
	VPREH NUMBER(38,0),
	ETIAG VARCHAR(18),
	INHBR NUMBER(38,3),
	CMETH VARCHAR(1),
	CUOBF VARCHAR(18),
	KZUMW VARCHAR(1),
	KOSCH VARCHAR(18),
	SPROF VARCHAR(1),
	NRFHG VARCHAR(1),
	MFRPN VARCHAR(40),
	MFRNR VARCHAR(10),
	BMATN VARCHAR(40),
	MPROF VARCHAR(4),
	KZWSM VARCHAR(1),
	SAITY VARCHAR(2),
	PROFL VARCHAR(3),
	IHIVI VARCHAR(1),
	ILOOS VARCHAR(1),
	SERLV VARCHAR(1),
	KZGVH VARCHAR(1),
	XGCHP VARCHAR(1),
	KZEFF VARCHAR(1),
	COMPL VARCHAR(2),
	IPRKZ VARCHAR(1),
	RDMHD VARCHAR(1),
	PRZUS VARCHAR(1),
	MTPOS_MARA VARCHAR(4),
	BFLME VARCHAR(1),
	MATFI VARCHAR(1),
	CMREL VARCHAR(1),
	BBTYP VARCHAR(1),
	SLED_BBD VARCHAR(1),
	GTIN_VARIANT VARCHAR(2),
	GENNR VARCHAR(40),
	RMATP VARCHAR(40),
	GDS_RELEVANT VARCHAR(1),
	WEORA VARCHAR(1),
	HUTYP_DFLT VARCHAR(4),
	PILFERABLE VARCHAR(1),
	WHSTC VARCHAR(2),
	WHMATGR VARCHAR(4),
	HNDLCODE VARCHAR(4),
	HAZMAT VARCHAR(1),
	HUTYP VARCHAR(4),
	TARE_VAR VARCHAR(1),
	MAXC NUMBER(38,3),
	MAXC_TOL NUMBER(38,1),
	MAXL NUMBER(38,3),
	MAXB NUMBER(38,3),
	MAXH NUMBER(38,3),
	MAXDIM_UOM VARCHAR(3),
	HERKL VARCHAR(3),
	MFRGR VARCHAR(8),
	QQTIME NUMBER(38,0),
	QQTIMEUOM VARCHAR(3),
	QGRP VARCHAR(4),
	SERIAL VARCHAR(4),
	PS_SMARTFORM VARCHAR(30),
	LOGUNIT VARCHAR(3),
	CWQREL VARCHAR(1),
	CWQPROC VARCHAR(2),
	CWQTOLGR VARCHAR(9),
	ADPROF VARCHAR(3),
	IPMIPPRODUCT VARCHAR(40),
	ALLOW_PMAT_IGNO VARCHAR(1),
	MEDIUM VARCHAR(6),
	COMMODITY VARCHAR(18),
	ANIMAL_ORIGIN VARCHAR(1),
	TEXTILE_COMP_IND VARCHAR(1),
	LAST_CHANGED_TIME VARCHAR(6),
	SGT_CSGR VARCHAR(4),
	SGT_COVSA VARCHAR(8),
	SGT_STAT VARCHAR(1),
	SGT_SCOPE VARCHAR(1),
	SGT_REL VARCHAR(1),
	ANP VARCHAR(9),
	PSM_CODE VARCHAR(2),
	FSH_MG_AT1 VARCHAR(10),
	FSH_MG_AT2 VARCHAR(10),
	FSH_MG_AT3 VARCHAR(6),
	FSH_SEALV VARCHAR(1),
	FSH_SEAIM VARCHAR(1),
	FSH_SC_MID VARCHAR(2),
	DUMMY_PRD_INCL_EEW_PS VARCHAR(1),
	SCM_MATID_GUID16 BINARY(8388608),
	SCM_MATID_GUID22 VARCHAR(22),
	SCM_MATURITY_DUR NUMBER(38,0),
	SCM_SHLF_LFE_REQ_MIN NUMBER(38,0),
	SCM_SHLF_LFE_REQ_MAX NUMBER(38,0),
	SCM_PUOM VARCHAR(3),
	CWM_XCWMAT VARCHAR(1),
	CWM_VALUM VARCHAR(3),
	CWM_TOLGR VARCHAR(9),
	CWM_TARA VARCHAR(1),
	CWM_TARUM VARCHAR(3),
	LULEINH VARCHAR(8),
	LULDEGRP VARCHAR(3),
	NESTRUCCAT VARCHAR(1),
	SL_TOLTYP VARCHAR(4),
	SV_CNT_GRP VARCHAR(10),
	VC_GROUP VARCHAR(6),
	KADU NUMBER(38,2),
	ABMEIN VARCHAR(3),
	KADP NUMBER(38,2),
	BRAD NUMBER(38,0),
	SPBI NUMBER(38,2),
	TRAD NUMBER(38,2),
	KEDU NUMBER(38,2),
	SPTR NUMBER(38,3),
	FBDK NUMBER(38,2),
	FBHK NUMBER(38,2),
	RILI VARCHAR(1),
	FBAK VARCHAR(1),
	AHO VARCHAR(3),
	MIFRR NUMBER(38,2),
	R_TILT_IND VARCHAR(1),
	R_STACK_IND VARCHAR(1),
	R_BOT_IND VARCHAR(1),
	R_TOP_IND VARCHAR(1),
	R_STACK_NO VARCHAR(3),
	R_PAL_IND VARCHAR(1),
	R_PAL_OVR_D NUMBER(38,3),
	R_PAL_OVR_W NUMBER(38,3),
	R_PAL_B_HT NUMBER(38,3),
	R_PAL_MIN_H NUMBER(38,3),
	R_TOL_B_HT NUMBER(38,3),
	R_NO_P_GVH VARCHAR(2),
	R_QUAN_UNIT VARCHAR(3),
	R_KZGVH_IND VARCHAR(1),
	PACKCODE VARCHAR(10),
	DG_PACK_STATUS VARCHAR(10),
	MCOND VARCHAR(1),
	RETDELC VARCHAR(1),
	LOGLEV_RETO VARCHAR(1),
	NSNID VARCHAR(9),
	OVLPN VARCHAR(32),
	ADSPC_SPC VARCHAR(1),
	VARID BINARY(8388608),
	MSBOOKPARTNO VARCHAR(40),
	DPCBT VARCHAR(1),
	XGRDT VARCHAR(1),
	IMATN VARCHAR(40),
	PICNUM VARCHAR(40),
	BSTAT VARCHAR(2),
	COLOR_ATINN VARCHAR(10),
	SIZE1_ATINN VARCHAR(10),
	SIZE2_ATINN VARCHAR(10),
	COLOR VARCHAR(18),
	SIZE1 VARCHAR(18),
	SIZE2 VARCHAR(18),
	FREE_CHAR VARCHAR(18),
	CARE_CODE VARCHAR(16),
	BRAND_ID VARCHAR(4),
	FIBER_CODE1 VARCHAR(3),
	FIBER_PART1 VARCHAR(3),
	FIBER_CODE2 VARCHAR(3),
	FIBER_PART2 VARCHAR(3),
	FIBER_CODE3 VARCHAR(3),
	FIBER_PART3 VARCHAR(3),
	FIBER_CODE4 VARCHAR(3),
	FIBER_PART4 VARCHAR(3),
	FIBER_CODE5 VARCHAR(3),
	FIBER_PART5 VARCHAR(3),
	FASHGRD VARCHAR(4),
	FRMW_EXTRACTED_ON TIMESTAMP_NTZ(9),
	SNFLK_UPDATEDON TIMESTAMP_NTZ(9)
);