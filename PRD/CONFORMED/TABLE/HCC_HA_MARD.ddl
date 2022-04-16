create or replace TABLE HCC_HA_MARD (
	MANDT VARCHAR(3),
	MATNR VARCHAR(18),
	WERKS VARCHAR(4),
	LGORT VARCHAR(4),
	PSTAT VARCHAR(15),
	LVORM VARCHAR(1),
	LFGJA VARCHAR(4),
	LFMON VARCHAR(2),
	SPERR VARCHAR(1),
	LABST NUMBER(38,3),
	UMLME NUMBER(38,3),
	INSME NUMBER(38,3),
	EINME NUMBER(38,3),
	SPEME NUMBER(38,3),
	RETME NUMBER(38,3),
	VMLAB NUMBER(38,3),
	VMUML NUMBER(38,3),
	VMINS NUMBER(38,3),
	VMEIN NUMBER(38,3),
	VMSPE NUMBER(38,3),
	VMRET NUMBER(38,3),
	KZILL VARCHAR(3),
	KZILQ VARCHAR(3),
	KZILE VARCHAR(3),
	KZILS VARCHAR(3),
	KZVLL VARCHAR(3),
	KZVLQ VARCHAR(3),
	KZVLE VARCHAR(3),
	KZVLS VARCHAR(3),
	DISKZ VARCHAR(1),
	LSOBS VARCHAR(2),
	LMINB NUMBER(38,3),
	LBSTF NUMBER(38,3),
	HERKL VARCHAR(3),
	EXPPG VARCHAR(1),
	EXVER VARCHAR(2),
	LGPBE VARCHAR(10),
	KLABS NUMBER(38,3),
	KINSM NUMBER(38,3),
	KEINM NUMBER(38,3),
	KSPEM NUMBER(38,3),
	DLINL VARCHAR(8),
	PRCTL VARCHAR(10),
	ERSDA VARCHAR(8),
	VKLAB NUMBER(38,2),
	VKUML NUMBER(38,2),
	LWMKB VARCHAR(3),
	BSKRF FLOAT,
	MDRUE VARCHAR(1),
	MDJIN VARCHAR(4),
	SEQGEN NUMBER(38,0),
	FRMW_EXTRACTED_ON TIMESTAMP_NTZ(9),
	SNFLK_UPDATEDON TIMESTAMP_NTZ(9)
);