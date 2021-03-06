create or replace TABLE HCC_HA_AFKO (
	MANDT VARCHAR(3),
	AUFNR VARCHAR(12),
	GLTRP VARCHAR(8),
	GSTRP VARCHAR(8),
	FTRMS VARCHAR(8),
	GLTRS VARCHAR(8),
	GSTRS VARCHAR(8),
	GSTRI VARCHAR(8),
	GETRI VARCHAR(8),
	GLTRI VARCHAR(8),
	FTRMI VARCHAR(8),
	FTRMP VARCHAR(8),
	RSNUM VARCHAR(10),
	GASMG NUMBER(38,3),
	GAMNG NUMBER(38,3),
	GMEIN VARCHAR(3),
	PLNBEZ VARCHAR(18),
	PLNTY VARCHAR(1),
	PLNNR VARCHAR(8),
	PLNAW VARCHAR(1),
	PLNAL VARCHAR(2),
	PVERW VARCHAR(3),
	PLAUF VARCHAR(8),
	PLSVB NUMBER(38,3),
	PLNME VARCHAR(3),
	PLSVN NUMBER(38,3),
	PDATV VARCHAR(8),
	PAENR VARCHAR(12),
	PLGRP VARCHAR(3),
	LODIV NUMBER(38,3),
	STLTY VARCHAR(1),
	STLBEZ VARCHAR(18),
	STLST VARCHAR(2),
	STLNR VARCHAR(8),
	SDATV VARCHAR(8),
	SBMNG NUMBER(38,3),
	SBMEH VARCHAR(3),
	SAENR VARCHAR(12),
	STLAL VARCHAR(2),
	STLAN VARCHAR(1),
	SLSVN NUMBER(38,3),
	SLSBS NUMBER(38,3),
	AUFLD VARCHAR(8),
	DISPO VARCHAR(3),
	AUFPL VARCHAR(10),
	FEVOR VARCHAR(3),
	FHORI VARCHAR(3),
	TERKZ VARCHAR(1),
	REDKZ VARCHAR(1),
	APRIO VARCHAR(1),
	NTZUE VARCHAR(12),
	VORUE VARCHAR(4),
	PROFID VARCHAR(7),
	VORGZ VARCHAR(3),
	SICHZ VARCHAR(3),
	FREIZ VARCHAR(3),
	UPTER VARCHAR(1),
	BEDID VARCHAR(12),
	PRONR VARCHAR(8),
	ZAEHL VARCHAR(8),
	MZAEHL VARCHAR(8),
	ZKRIZ VARCHAR(7),
	PRUEFLOS VARCHAR(12),
	KLVARP VARCHAR(4),
	KLVARI VARCHAR(4),
	RGEKZ VARCHAR(1),
	PLART VARCHAR(1),
	FLG_AOB VARCHAR(1),
	FLG_ARBEI VARCHAR(1),
	GLTPP VARCHAR(8),
	GSTPP VARCHAR(8),
	GLTPS VARCHAR(8),
	GSTPS VARCHAR(8),
	FTRPS VARCHAR(8),
	RDKZP VARCHAR(1),
	TRKZP VARCHAR(1),
	RUECK VARCHAR(10),
	RMZHL VARCHAR(8),
	IGMNG NUMBER(38,3),
	RATID VARCHAR(12),
	GROID VARCHAR(12),
	CUOBJ VARCHAR(18),
	GLUZS VARCHAR(6),
	GSUZS VARCHAR(6),
	REVLV VARCHAR(2),
	RSHTY VARCHAR(2),
	RSHID VARCHAR(8),
	RSNTY VARCHAR(2),
	RSNID VARCHAR(8),
	NAUTERM VARCHAR(1),
	NAUCOST VARCHAR(1),
	STUFE NUMBER(38,0),
	WEGXX NUMBER(38,0),
	VWEGX NUMBER(38,0),
	ARSNR VARCHAR(10),
	ARSPS VARCHAR(4),
	MAUFNR VARCHAR(12),
	LKNOT VARCHAR(12),
	RKNOT VARCHAR(12),
	PRODNET VARCHAR(1),
	IASMG NUMBER(38,3),
	ABARB VARCHAR(3),
	AUFNT VARCHAR(12),
	AUFPT VARCHAR(10),
	APLZT VARCHAR(8),
	NO_DISP VARCHAR(1),
	CSPLIT VARCHAR(4),
	AENNR VARCHAR(12),
	CY_SEQNR VARCHAR(14),
	BREAKS VARCHAR(1),
	VORGZ_TRM NUMBER(38,3),
	SICHZ_TRM NUMBER(38,3),
	TRMDT VARCHAR(8),
	GLUZP VARCHAR(6),
	GSUZP VARCHAR(6),
	GSUZI VARCHAR(6),
	GEUZI VARCHAR(6),
	GLUPP VARCHAR(6),
	GSUPP VARCHAR(6),
	GLUPS VARCHAR(6),
	GSUPS VARCHAR(6),
	CHSCH VARCHAR(6),
	KAPT_VORGZ VARCHAR(3),
	KAPT_SICHZ VARCHAR(3),
	LEAD_AUFNR VARCHAR(12),
	PNETSTARTD VARCHAR(8),
	PNETSTARTT VARCHAR(6),
	PNETENDD VARCHAR(8),
	PNETENDT VARCHAR(6),
	KBED VARCHAR(1),
	KKALKR VARCHAR(1),
	SFCPF VARCHAR(6),
	RMNGA NUMBER(38,3),
	GSBTR VARCHAR(8),
	VFMNG NUMBER(38,3),
	NOPCOST VARCHAR(1),
	NETZKONT VARCHAR(1),
	ATRKZ VARCHAR(1),
	OBJTYPE VARCHAR(1),
	CH_PROC VARCHAR(1),
	KAPVERSA VARCHAR(2),
	COLORDPROC VARCHAR(1),
	KZERB VARCHAR(1),
	CONF_KEY VARCHAR(8),
	ST_ARBID VARCHAR(8),
	VSNMR_V VARCHAR(12),
	TERHW VARCHAR(1),
	SPLSTAT VARCHAR(1),
	COSTUPD VARCHAR(1),
	MAX_GAMNG NUMBER(38,3),
	MES_ROUTINGID VARCHAR(64),
	ADPSP VARCHAR(40),
	RMANR VARCHAR(10),
	POSNR_RMA VARCHAR(6),
	POSNV_RMA VARCHAR(6),
	CFB_MAXLZ NUMBER(38,0),
	CFB_LZEIH VARCHAR(3),
	CFB_ADTDAYS NUMBER(38,0),
	CFB_DATOFM VARCHAR(8),
	CFB_BBDPI VARCHAR(8),
	OIHANTYP VARCHAR(2),
	MILL_RATIO NUMBER(38,0),
	BMEINS VARCHAR(3),
	BMENGE NUMBER(38,3),
	MILL_OC_ZUSKZ VARCHAR(1),
	FRMW_EXTRACTED_ON TIMESTAMP_NTZ(9),
	SNFLK_UPDATEDON TIMESTAMP_NTZ(9)
);