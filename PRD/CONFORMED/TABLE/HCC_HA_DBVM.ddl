create or replace TABLE HCC_HA_DBVM (
	MANDT VARCHAR(3),
	MAFID VARCHAR(1),
	DISST VARCHAR(3),
	MATNR VARCHAR(18),
	BERID VARCHAR(10),
	GSAEN VARCHAR(1),
	AKKEN VARCHAR(1),
	RESDT VARCHAR(1),
	ERDAT VARCHAR(8),
	RESAL VARCHAR(1),
	MPSKZ VARCHAR(1),
	RHYTD VARCHAR(8),
	USTMP NUMBER(38,0),
	DSTMP NUMBER(38,0),
	SEQGEN NUMBER(38,0),
	FRMW_EXTRACTED_ON TIMESTAMP_NTZ(9),
	SNFLK_UPDATEDON TIMESTAMP_NTZ(9)
);