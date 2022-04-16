create or replace TABLE SCMDB_REASONTYPE (
	REASONTYPEID NUMBER(38,0),
	REASONTYPECODE NUMBER(38,0),
	MOVEMENTTYPECODE VARCHAR(10),
	LANGUAGE VARCHAR(2),
	DESCRIPTION VARCHAR(20),
	REASONTYPESTDID NUMBER(38,0),
	IMPORTJOBID NUMBER(38,0),
	CREATEUSER VARCHAR(25),
	CREATEDTS TIMESTAMP_NTZ(9),
	UPDATEUSER VARCHAR(25),
	UPDATEDTS TIMESTAMP_NTZ(9),
	DATASOURCEID NUMBER(38,0),
	FRMW_EXTRACTED_ON TIMESTAMP_NTZ(9),
	SNFLK_UPDATEDON TIMESTAMP_NTZ(9)
);