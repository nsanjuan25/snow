create or replace TABLE JPS_HA_MARC (
	MANDT VARCHAR(3),
	MATNR VARCHAR(40),
	WERKS VARCHAR(4),
	PSTAT VARCHAR(15),
	LVORM VARCHAR(1),
	BWTTY VARCHAR(1),
	XCHAR VARCHAR(1),
	MMSTA VARCHAR(2),
	MMSTD VARCHAR(8),
	MAABC VARCHAR(1),
	KZKRI VARCHAR(1),
	EKGRP VARCHAR(3),
	AUSME VARCHAR(3),
	DISPR VARCHAR(4),
	DISMM VARCHAR(2),
	DISPO VARCHAR(3),
	KZDIE VARCHAR(1),
	PLIFZ NUMBER(38,0),
	WEBAZ NUMBER(38,0),
	PERKZ VARCHAR(1),
	AUSSS NUMBER(38,2),
	DISLS VARCHAR(2),
	BESKZ VARCHAR(1),
	SOBSL VARCHAR(2),
	MINBE NUMBER(38,3),
	EISBE NUMBER(38,3),
	BSTMI NUMBER(38,3),
	BSTMA NUMBER(38,3),
	BSTFE NUMBER(38,3),
	BSTRF NUMBER(38,3),
	MABST NUMBER(38,3),
	LOSFX NUMBER(38,2),
	SBDKZ VARCHAR(1),
	LAGPR VARCHAR(1),
	ALTSL VARCHAR(1),
	KZAUS VARCHAR(1),
	AUSDT VARCHAR(8),
	NFMAT VARCHAR(40),
	KZBED VARCHAR(1),
	MISKZ VARCHAR(1),
	FHORI VARCHAR(3),
	PFREI VARCHAR(1),
	FFREI VARCHAR(1),
	RGEKZ VARCHAR(1),
	FEVOR VARCHAR(3),
	BEARZ NUMBER(38,2),
	RUEZT NUMBER(38,2),
	TRANZ NUMBER(38,2),
	BASMG NUMBER(38,3),
	DZEIT NUMBER(38,0),
	MAXLZ NUMBER(38,0),
	LZEIH VARCHAR(3),
	KZPRO VARCHAR(1),
	GPMKZ VARCHAR(1),
	UEETO NUMBER(38,1),
	UEETK VARCHAR(1),
	UNETO NUMBER(38,1),
	WZEIT NUMBER(38,0),
	ATPKZ VARCHAR(1),
	VZUSL NUMBER(38,2),
	HERBL VARCHAR(2),
	INSMK VARCHAR(1),
	SPROZ NUMBER(38,1),
	QUAZT NUMBER(38,0),
	SSQSS VARCHAR(8),
	MPDAU NUMBER(38,0),
	KZPPV VARCHAR(1),
	KZDKZ VARCHAR(1),
	WSTGH NUMBER(38,0),
	PRFRQ NUMBER(38,0),
	NKMPR VARCHAR(8),
	UMLMC NUMBER(38,3),
	LADGR VARCHAR(4),
	XCHPF VARCHAR(1),
	USEQU VARCHAR(1),
	LGRAD NUMBER(38,1),
	AUFTL VARCHAR(1),
	PLVAR VARCHAR(2),
	OTYPE VARCHAR(2),
	OBJID VARCHAR(8),
	MTVFP VARCHAR(2),
	PERIV VARCHAR(2),
	KZKFK VARCHAR(1),
	VRVEZ NUMBER(38,2),
	VBAMG NUMBER(38,3),
	VBEAZ NUMBER(38,2),
	LIZYK VARCHAR(4),
	BWSCL VARCHAR(1),
	KAUTB VARCHAR(1),
	KORDB VARCHAR(1),
	STAWN VARCHAR(17),
	HERKL VARCHAR(3),
	HERKR VARCHAR(3),
	EXPME VARCHAR(3),
	MTVER VARCHAR(4),
	PRCTR VARCHAR(10),
	TRAME NUMBER(38,3),
	MRPPP VARCHAR(3),
	SAUFT VARCHAR(1),
	FXHOR VARCHAR(3),
	VRMOD VARCHAR(1),
	VINT1 VARCHAR(3),
	VINT2 VARCHAR(3),
	VERKZ VARCHAR(1),
	STLAL VARCHAR(2),
	STLAN VARCHAR(1),
	PLNNR VARCHAR(8),
	APLAL VARCHAR(2),
	LOSGR NUMBER(38,3),
	SOBSK VARCHAR(2),
	FRTME VARCHAR(3),
	LGPRO VARCHAR(4),
	DISGR VARCHAR(4),
	KAUSF NUMBER(38,2),
	QZGTP VARCHAR(4),
	QMATV VARCHAR(1),
	TAKZT NUMBER(38,0),
	RWPRO VARCHAR(3),
	COPAM VARCHAR(10),
	ABCIN VARCHAR(1),
	AWSLS VARCHAR(6),
	SERNP VARCHAR(4),
	CUOBJ VARCHAR(18),
	STDPD VARCHAR(40),
	SFEPR VARCHAR(4),
	XMCNG VARCHAR(1),
	QSSYS VARCHAR(4),
	LFRHY VARCHAR(3),
	RDPRF VARCHAR(4),
	VRBMT VARCHAR(40),
	VRBWK VARCHAR(4),
	VRBDT VARCHAR(8),
	VRBFK NUMBER(38,2),
	AUTRU VARCHAR(1),
	PREFE VARCHAR(1),
	PRENC VARCHAR(1),
	PRENO VARCHAR(8),
	PREND VARCHAR(8),
	PRENE VARCHAR(1),
	PRENG VARCHAR(8),
	ITARK VARCHAR(1),
	SERVG VARCHAR(1),
	KZKUP VARCHAR(1),
	STRGR VARCHAR(2),
	CUOBV VARCHAR(18),
	LGFSB VARCHAR(4),
	SCHGT VARCHAR(1),
	CCFIX VARCHAR(1),
	EPRIO VARCHAR(4),
	QMATA VARCHAR(6),
	RESVP NUMBER(38,0),
	PLNTY VARCHAR(1),
	UOMGR VARCHAR(3),
	UMRSL VARCHAR(4),
	ABFAC NUMBER(38,1),
	SFCPF VARCHAR(6),
	SHFLG VARCHAR(1),
	SHZET VARCHAR(2),
	MDACH VARCHAR(2),
	KZECH VARCHAR(1),
	MEGRU VARCHAR(4),
	MFRGR VARCHAR(8),
	PROFIL VARCHAR(4),
	VKUMC NUMBER(38,2),
	VKTRW NUMBER(38,2),
	KZAGL VARCHAR(1),
	FVIDK VARCHAR(4),
	FXPRU VARCHAR(1),
	LOGGR VARCHAR(4),
	FPRFM VARCHAR(3),
	GLGMG NUMBER(38,3),
	VKGLG NUMBER(38,2),
	INDUS VARCHAR(2),
	MOWNR VARCHAR(12),
	MOGRU VARCHAR(6),
	CASNR VARCHAR(15),
	GPNUM VARCHAR(9),
	STEUC VARCHAR(16),
	FABKZ VARCHAR(1),
	MATGR VARCHAR(20),
	VSPVB VARCHAR(10),
	DPLFS VARCHAR(2),
	DPLPU VARCHAR(1),
	DPLHO NUMBER(38,0),
	MINLS NUMBER(38,3),
	MAXLS NUMBER(38,3),
	FIXLS NUMBER(38,3),
	LTINC NUMBER(38,3),
	COMPL VARCHAR(2),
	CONVT VARCHAR(2),
	SHPRO VARCHAR(3),
	AHDIS VARCHAR(1),
	DIBER VARCHAR(1),
	KZPSP VARCHAR(1),
	OCMPF VARCHAR(6),
	APOKZ VARCHAR(1),
	MCRUE VARCHAR(1),
	LFMON VARCHAR(2),
	LFGJA VARCHAR(4),
	EISLO NUMBER(38,3),
	NCOST VARCHAR(1),
	ROTATION_DATE VARCHAR(1),
	UCHKZ VARCHAR(1),
	UCMAT VARCHAR(40),
	BWESB NUMBER(38,3),
	SGT_COVS VARCHAR(8),
	SGT_STATC VARCHAR(1),
	SGT_SCOPE VARCHAR(1),
	SGT_MRPSI VARCHAR(1),
	SGT_PRCM VARCHAR(1),
	SGT_CHINT VARCHAR(1),
	SGT_STK_PRT VARCHAR(1),
	SGT_DEFSC VARCHAR(40),
	SGT_MRP_ATP_STATUS VARCHAR(2),
	SGT_MMSTD VARCHAR(8),
	FSH_MG_ARUN_REQ VARCHAR(1),
	FSH_SEAIM VARCHAR(1),
	FSH_VAR_GROUP VARCHAR(2),
	FSH_KZECH VARCHAR(1),
	FSH_CALENDAR_GROUP VARCHAR(4),
	ARUN_FIX_BATCH VARCHAR(1),
	PPSKZ VARCHAR(1),
	CONS_PROCG VARCHAR(1),
	GI_PR_TIME NUMBER(38,0),
	MULTIPLE_EKGRP VARCHAR(1),
	REF_SCHEMA VARCHAR(2),
	MIN_TROC VARCHAR(3),
	MAX_TROC VARCHAR(3),
	TARGET_STOCK NUMBER(38,3),
	NF_FLAG VARCHAR(1),
	CWM_UMLMC NUMBER(38,3),
	CWM_TRAME NUMBER(38,3),
	CWM_BWESB NUMBER(38,3),
	SCM_MATLOCID_GUID16 BINARY(8388608),
	SCM_MATLOCID_GUID22 VARCHAR(22),
	SCM_GRPRT NUMBER(38,0),
	SCM_GIPRT NUMBER(38,0),
	SCM_SCOST NUMBER(38,3),
	SCM_RELDT NUMBER(38,0),
	SCM_RRP_TYPE VARCHAR(1),
	SCM_HEUR_ID VARCHAR(12),
	SCM_PACKAGE_ID VARCHAR(12),
	SCM_SSPEN NUMBER(38,3),
	SCM_GET_ALERTS VARCHAR(1),
	SCM_RES_NET_NAME VARCHAR(40),
	SCM_CONHAP NUMBER(38,3),
	SCM_HUNIT VARCHAR(3),
	SCM_CONHAP_OUT NUMBER(38,3),
	SCM_HUNIT_OUT VARCHAR(3),
	SCM_SHELF_LIFE_LOC VARCHAR(1),
	SCM_SHELF_LIFE_DUR NUMBER(38,0),
	SCM_MATURITY_DUR NUMBER(38,0),
	SCM_SHLF_LFE_REQ_MIN NUMBER(38,0),
	SCM_SHLF_LFE_REQ_MAX NUMBER(38,0),
	SCM_LSUOM VARCHAR(3),
	SCM_REORD_DUR NUMBER(38,0),
	SCM_TARGET_DUR NUMBER(38,0),
	SCM_TSTRID VARCHAR(10),
	SCM_STRA1 VARCHAR(2),
	SCM_PEG_PAST_ALERT NUMBER(38,0),
	SCM_PEG_FUTURE_ALERT NUMBER(38,0),
	SCM_PEG_STRATEGY VARCHAR(2),
	SCM_PEG_WO_ALERT_FST VARCHAR(1),
	SCM_FIXPEG_PROD_SET VARCHAR(1),
	SCM_WHATBOM VARCHAR(1),
	SCM_RRP_SEL_GROUP VARCHAR(2),
	SCM_INTSRC_PROF VARCHAR(10),
	SCM_PRIO NUMBER(38,0),
	SCM_MIN_PASS_AMOUNT NUMBER(38,3),
	SCM_PROFID VARCHAR(12),
	SCM_GES_MNG_USE VARCHAR(1),
	SCM_GES_BST_USE VARCHAR(1),
	DUMMY_PLNT_INCL_EEW_PS VARCHAR(1),
	TOLPRPL NUMBER(38,1),
	TOLPRMI NUMBER(38,1),
	R_PKGRP VARCHAR(18),
	R_LANE_NUM VARCHAR(3),
	R_PAL_VEND VARCHAR(40),
	R_FORK_DIR VARCHAR(1),
	IUID_RELEVANT VARCHAR(1),
	IUID_TYPE VARCHAR(10),
	UID_IEA VARCHAR(1),
	DPCBT VARCHAR(1),
	ZZ_JPS_NOTIF_STATUS VARCHAR(5),
	ZZ_JPS_RISK_LEVEL VARCHAR(3),
	ZZ_JPS_PU_SPEC_NO VARCHAR(30),
	ZZ_JPS_PU_SPEC_REV VARCHAR(3),
	ZZ_JPS_PU_SPEC_DATE VARCHAR(8),
	FRMW_EXTRACTED_ON TIMESTAMP_NTZ(9),
	SNFLK_UPDATEDON TIMESTAMP_NTZ(9)
);