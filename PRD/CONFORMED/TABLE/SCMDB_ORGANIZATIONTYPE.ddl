create or replace TABLE SCMDB_ORGANIZATIONTYPE (
	ORGANIZATIONTYPEID NUMBER(38,0),
	ORGANIZATIONTYPECODE VARCHAR(65),
	FRMW_EXTRACTED_ON TIMESTAMP_NTZ(9),
	SNFLK_UPDATEDON TIMESTAMP_NTZ(9)
);