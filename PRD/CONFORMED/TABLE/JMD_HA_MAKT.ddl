create or replace TABLE JMD_HA_MAKT (
	MANDT VARCHAR(3),
	MATNR VARCHAR(18),
	SPRAS VARCHAR(1),
	MAKTX VARCHAR(40),
	MAKTG VARCHAR(40),
	FRMW_EXTRACTED_ON TIMESTAMP_NTZ(9),
	SNFLK_UPDATEDON TIMESTAMP_NTZ(9)
);