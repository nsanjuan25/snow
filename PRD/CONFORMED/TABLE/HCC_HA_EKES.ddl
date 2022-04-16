create or replace TABLE HCC_HA_EKES (
	MANDT VARCHAR(3),
	EBELN VARCHAR(10),
	EBELP VARCHAR(5),
	ETENS VARCHAR(4),
	EBTYP VARCHAR(2),
	EINDT VARCHAR(8),
	LPEIN VARCHAR(1),
	UZEIT VARCHAR(6),
	ERDAT VARCHAR(8),
	EZEIT VARCHAR(6),
	MENGE NUMBER(38,3),
	DABMG NUMBER(38,3),
	ESTKZ VARCHAR(1),
	LOEKZ VARCHAR(1),
	KZDIS VARCHAR(1),
	XBLNR VARCHAR(35),
	VBELN VARCHAR(10),
	VBELP VARCHAR(6),
	MPROF VARCHAR(4),
	EMATN VARCHAR(18),
	MAHNZ NUMBER(38,0),
	CHARG VARCHAR(10),
	UECHA VARCHAR(6),
	REF_ETENS VARCHAR(4),
	IMWRK VARCHAR(1),
	VBELN_ST VARCHAR(10),
	VBELP_ST VARCHAR(6),
	HANDOVERDATE VARCHAR(8),
	HANDOVERTIME VARCHAR(6),
	SEQGEN NUMBER(38,0),
	FRMW_EXTRACTED_ON TIMESTAMP_NTZ(9),
	SNFLK_UPDATEDON TIMESTAMP_NTZ(9)
);