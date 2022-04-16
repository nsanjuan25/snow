create or replace TABLE SCMDB_BILLOFMATERIALTYPE (
	DATASOURCEID NUMBER(38,0),
	BOMTYPECODE VARCHAR(1),
	BOMTYPESTDID NUMBER(38,0),
	DESCRIPTION VARCHAR(65),
	IMPORTJOBID NUMBER(38,0),
	DELETEFLAG BOOLEAN,
	CREATEUSER VARCHAR(25),
	CREATEDTS TIMESTAMP_NTZ(9),
	UPDATEUSER VARCHAR(25),
	UPDATEDTS TIMESTAMP_NTZ(9),
	FRMW_EXTRACTED_ON TIMESTAMP_NTZ(9),
	SNFLK_UPDATEDON TIMESTAMP_NTZ(9)
);