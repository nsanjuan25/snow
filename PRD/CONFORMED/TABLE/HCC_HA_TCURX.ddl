create or replace TABLE HCC_HA_TCURX (
	CURRKEY VARCHAR(5),
	CURRDEC NUMBER(38,0),
	FRMW_EXTRACTED_ON TIMESTAMP_NTZ(9),
	SNFLK_UPDATEDON TIMESTAMP_NTZ(9)
);