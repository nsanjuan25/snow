create or replace TABLE SCMDB_CHARACTERISTIC (
	CHARACTERID NUMBER(38,0),
	CHARACTERNAME VARCHAR(20),
	FRMW_EXTRACTED_ON TIMESTAMP_NTZ(9),
	SNFLK_UPDATEDON TIMESTAMP_NTZ(9)
);