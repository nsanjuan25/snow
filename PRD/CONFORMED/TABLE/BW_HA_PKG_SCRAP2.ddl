create or replace TABLE BW_HA_PKG_SCRAP2 (
	WERKS VARCHAR(4),
	MATNR VARCHAR(18),
	CALDAY VARCHAR(8),
	MAT_PLANT VARCHAR(18),
	KOKRS VARCHAR(4),
	PRCTR VARCHAR(10),
	KST01 NUMBER(38,3),
	KST02 NUMBER(38,3),
	KST03 NUMBER(38,3),
	WAERS VARCHAR(5),
	SEQGEN NUMBER(38,0),
	FRMW_EXTRACTED_ON TIMESTAMP_NTZ(9),
	SNFLK_UPDATEDON TIMESTAMP_NTZ(9)
);