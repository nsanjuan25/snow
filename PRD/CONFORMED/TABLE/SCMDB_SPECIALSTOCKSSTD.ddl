create or replace TABLE SCMDB_SPECIALSTOCKSSTD (
	SPECIALSTOCKSSTDID NUMBER(38,0),
	SPECIALSTOCKSSTDCODE VARCHAR(15),
	DESCRIPTION VARCHAR(50),
	UPDATEUSER VARCHAR(25),
	UPDATEDTS TIMESTAMP_NTZ(9),
	FRMW_EXTRACTED_ON TIMESTAMP_NTZ(9),
	SNFLK_UPDATEDON TIMESTAMP_NTZ(9)
);