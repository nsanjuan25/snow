create or replace TABLE SCMDB_STORAGETYPE (
	STORAGETYPEID NUMBER(38,0),
	WAREHOUSEID NUMBER(38,0),
	DATASOURCEID NUMBER(38,0),
	STORAGETYPECODE VARCHAR(3),
	DESCRIPTION VARCHAR(50),
	IMPORTJOBID NUMBER(38,0),
	DELETEFLAG BOOLEAN,
	CREATEUSER VARCHAR(25),
	CREATEDTS TIMESTAMP_NTZ(9),
	UPDATEUSER VARCHAR(25),
	UPDATEDTS TIMESTAMP_NTZ(9),
	STORAGETYPESTDID NUMBER(38,0),
	FRMW_EXTRACTED_ON TIMESTAMP_NTZ(9),
	SNFLK_UPDATEDON TIMESTAMP_NTZ(9)
);