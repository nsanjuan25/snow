create or replace TABLE SCMDB_BILLOFMATERIALUSAGE (
	DATASOURCEID NUMBER(38,0),
	BOMUSAGECODE VARCHAR(1),
	BOMUSAGESTDID NUMBER(38,0),
	DESCRIPTION VARCHAR(65),
	IMPORTJOBID NUMBER(38,0),
	CREATEUSER VARCHAR(25),
	CREATEDTS TIMESTAMP_NTZ(9),
	UPDATEUSER VARCHAR(25),
	UPDATEDTS TIMESTAMP_NTZ(9),
	FRMW_EXTRACTED_ON TIMESTAMP_NTZ(9),
	SNFLK_UPDATEDON TIMESTAMP_NTZ(9)
);