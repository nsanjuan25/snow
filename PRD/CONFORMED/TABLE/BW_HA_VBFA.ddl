create or replace TABLE BW_HA_VBFA (
	VBTYP_N VARCHAR(10),
	POSNN VARCHAR(6),
	POSNV VARCHAR(6),
	VBELV VARCHAR(10),
	VBELN VARCHAR(10),
	ERDAT VARCHAR(8),
	ERZET VARCHAR(6),
	VBTYP_V VARCHAR(10),
	FKTYP VARCHAR(1),
	MATNR VARCHAR(18),
	BWART VARCHAR(3),
	ZZDATE VARCHAR(10),
	SEQGEN NUMBER(38,0),
	FRMW_EXTRACTED_ON TIMESTAMP_NTZ(9),
	SNFLK_UPDATEDON TIMESTAMP_NTZ(9)
);