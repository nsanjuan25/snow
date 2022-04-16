create or replace TABLE BW_HA_PKG_SCRAP1 (
	WERKS VARCHAR(4),
	VERAN VARCHAR(10),
	PROD_DATE VARCHAR(8),
	SHIFT VARCHAR(4),
	ARBPL VARCHAR(8),
	MOLD VARCHAR(18),
	MATNR VARCHAR(18),
	A_ISM02 NUMBER(38,3),
	ZMDTHRS NUMBER(38,3),
	CALYEAR VARCHAR(4),
	CALMONTH VARCHAR(6),
	CALWEEK VARCHAR(6),
	AUFNR VARCHAR(12),
	PRCTR VARCHAR(10),
	ZLSTLOADN NUMBER(38,3),
	LMNGA NUMBER(38,3),
	XMNGA NUMBER(38,3),
	GEWEI VARCHAR(3),
	QS_QTY NUMBER(38,3),
	GEWEI2 VARCHAR(3),
	A_CAVITIES NUMBER(38,3),
	A_CYC_TIME NUMBER(38,3),
	A_OPERATORS NUMBER(38,3),
	LRPH NUMBER(38,3),
	ZSALVAL NUMBER(38,3),
	SVPT NUMBER(38,3),
	ZSTDCAVHR NUMBER(38,3),
	S_CAVITIES NUMBER(38,3),
	S_CYC_TIME NUMBER(38,3),
	ZDTCODE VARCHAR(20),
	GRUND VARCHAR(4),
	XMNGA_1 NUMBER(38,3),
	MEINH VARCHAR(3),
	WAERS VARCHAR(3),
	S_OPERATORS NUMBER(38,3),
	KOKRS VARCHAR(4),
	MAT_PLANT VARCHAR(18),
	ZDTCODE_1 VARCHAR(20),
	SEQGEN NUMBER(38,0),
	PRICEMAT NUMBER(38,3),
	PRICEUNIT NUMBER(38,3),
	FRMW_EXTRACTED_ON TIMESTAMP_NTZ(9),
	SNFLK_UPDATEDON TIMESTAMP_NTZ(9)
);