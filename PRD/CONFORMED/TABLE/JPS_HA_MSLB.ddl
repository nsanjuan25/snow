create or replace TABLE JPS_HA_MSLB (
	MANDT VARCHAR(3),
	MATNR VARCHAR(40),
	WERKS VARCHAR(4),
	CHARG VARCHAR(10),
	SOBKZ VARCHAR(1),
	LIFNR VARCHAR(10),
	LFGJA VARCHAR(4),
	LFMON VARCHAR(2),
	LBSPR VARCHAR(1),
	LBLAB NUMBER(38,3),
	LBINS NUMBER(38,3),
	LBVLA NUMBER(38,3),
	LBVIN NUMBER(38,3),
	LBILL VARCHAR(3),
	LBILQ VARCHAR(3),
	LBVLL VARCHAR(3),
	LBVLQ VARCHAR(3),
	LBFLL VARCHAR(3),
	LBFLQ VARCHAR(3),
	LBDLL VARCHAR(8),
	LBEIN NUMBER(38,3),
	LBVEI NUMBER(38,3),
	ERSDA VARCHAR(8),
	LBJIN VARCHAR(4),
	LBRUE VARCHAR(1),
	LBUML NUMBER(38,3),
	SGT_SCAT VARCHAR(40),
	CWM_LBLAB NUMBER(38,3),
	CWM_LBINS NUMBER(38,3),
	CWM_LBEIN NUMBER(38,3),
	CWM_LBUML NUMBER(38,3),
	CWM_LBVLA NUMBER(38,3),
	CWM_LBVIN NUMBER(38,3),
	CWM_LBVEI NUMBER(38,3),
	FRMW_EXTRACTED_ON TIMESTAMP_NTZ(9),
	SNFLK_UPDATEDON TIMESTAMP_NTZ(9)
);