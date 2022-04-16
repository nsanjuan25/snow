create or replace TABLE ECC_HA_T001L (
	MANDT VARCHAR(3),
	WERKS VARCHAR(4),
	LGORT VARCHAR(4),
	LGOBE VARCHAR(16),
	SPART VARCHAR(2),
	XLONG VARCHAR(1),
	XBUFX VARCHAR(1),
	DISKZ VARCHAR(1),
	XBLGO VARCHAR(1),
	XRESS VARCHAR(1),
	XHUPF VARCHAR(1),
	PARLG VARCHAR(4),
	VKORG VARCHAR(4),
	VTWEG VARCHAR(2),
	VSTEL VARCHAR(4),
	LIFNR VARCHAR(10),
	KUNNR VARCHAR(10),
	MESBS VARCHAR(60),
	MESST VARCHAR(1),
	OIH_LICNO VARCHAR(15),
	OIG_ITRFL VARCHAR(1),
	OIB_TNKASSIGN VARCHAR(1),
	SEQGEN NUMBER(38,0),
	FRMW_EXTRACTED_ON TIMESTAMP_NTZ(9),
	SNFLK_UPDATEDON TIMESTAMP_NTZ(9)
);