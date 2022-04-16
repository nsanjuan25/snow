create or replace TABLE SCMDB_CORPORATIONDSTYPE (
	CORPORATIONDSTYPEID NUMBER(38,0),
	DATASOURCEID NUMBER(38,0),
	CORPORATIONDSTYPECODE VARCHAR(10),
	CORPORATIONDSTYPESTDID NUMBER(38,0),
	IMPORTJOBID NUMBER(38,0),
	DELETEFLAG BOOLEAN,
	CREATEUSER VARCHAR(25),
	CREATEDTS TIMESTAMP_NTZ(9),
	UPDATEUSER VARCHAR(25),
	UPDATEDTS TIMESTAMP_NTZ(9),
	FRMW_EXTRACTED_ON TIMESTAMP_NTZ(9),
	SNFLK_UPDATEDON TIMESTAMP_NTZ(9)
);