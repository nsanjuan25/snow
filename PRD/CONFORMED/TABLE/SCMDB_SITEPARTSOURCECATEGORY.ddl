create or replace TABLE SCMDB_SITEPARTSOURCECATEGORY (
	SITEPARTSOURCECATEGORYCODE VARCHAR(10),
	DESCRIPTION VARCHAR(50),
	SITEPARTSOURCECATEGORYSTDID NUMBER(38,0),
	IMPORTJOBID NUMBER(38,0),
	DELETEFLAG BOOLEAN,
	CREATEUSER VARCHAR(25),
	CREATEDTS TIMESTAMP_NTZ(9),
	UPDATEUSER VARCHAR(25),
	UPDATEDTS TIMESTAMP_NTZ(9),
	FRMW_EXTRACTED_ON TIMESTAMP_NTZ(9),
	SNFLK_UPDATEDON TIMESTAMP_NTZ(9)
);