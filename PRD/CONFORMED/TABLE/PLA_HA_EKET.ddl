create or replace TABLE PLA_HA_EKET (
	MANDT VARCHAR(3),
	EBELN VARCHAR(10),
	EBELP VARCHAR(5),
	ETENR VARCHAR(4),
	EINDT VARCHAR(8),
	SLFDT VARCHAR(8),
	LPEIN VARCHAR(1),
	MENGE NUMBER(38,3),
	AMENG NUMBER(38,3),
	WEMNG NUMBER(38,3),
	WAMNG NUMBER(38,3),
	UZEIT VARCHAR(6),
	BANFN VARCHAR(10),
	BNFPO VARCHAR(5),
	ESTKZ VARCHAR(1),
	QUNUM VARCHAR(10),
	QUPOS VARCHAR(3),
	MAHNZ NUMBER(38,0),
	BEDAT VARCHAR(8),
	RSNUM VARCHAR(10),
	SERNR VARCHAR(8),
	FIXKZ VARCHAR(1),
	GLMNG NUMBER(38,3),
	DABMG NUMBER(38,3),
	CHARG VARCHAR(10),
	LICHA VARCHAR(15),
	CHKOM VARCHAR(1),
	VERID VARCHAR(4),
	ABART VARCHAR(1),
	MNG02 NUMBER(38,3),
	DAT01 VARCHAR(8),
	ALTDT VARCHAR(8),
	AULWE VARCHAR(10),
	MBDAT VARCHAR(8),
	MBUHR VARCHAR(6),
	LDDAT VARCHAR(8),
	LDUHR VARCHAR(6),
	TDDAT VARCHAR(8),
	TDUHR VARCHAR(6),
	WADAT VARCHAR(8),
	WAUHR VARCHAR(6),
	ELDAT VARCHAR(8),
	ELUHR VARCHAR(6),
	KEY_ID VARCHAR(16),
	OTB_VALUE NUMBER(38,2),
	OTB_CURR VARCHAR(5),
	OTB_RES_VALUE NUMBER(38,2),
	OTB_SPEC_VALUE NUMBER(38,2),
	SPR_RSN_PROFILE VARCHAR(4),
	BUDG_TYPE VARCHAR(2),
	OTB_STATUS VARCHAR(1),
	OTB_REASON VARCHAR(3),
	CHECK_TYPE VARCHAR(1),
	DL_ID VARCHAR(22),
	HANDOVER_DATE VARCHAR(8),
	NO_SCEM VARCHAR(1),
	DNG_DATE VARCHAR(8),
	DNG_TIME VARCHAR(6),
	CNCL_ANCMNT_DONE VARCHAR(1),
	DATESHIFT_NUMBER NUMBER(38,0),
	WERKS VARCHAR(4),
	FRMW_EXTRACTED_ON TIMESTAMP_NTZ(9),
	SNFLK_UPDATEDON TIMESTAMP_NTZ(9)
);