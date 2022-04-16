create or replace TABLE SCMDB_MFRPRODUCTFAMILY (
	MFRPRODUCTFAMILYID NUMBER(38,0),
	MFRPRODUCTFAMILY VARCHAR(150),
	MFRPRODUCTFAMILYDESCRIPTION VARCHAR(500),
	DELETEFLAG BOOLEAN,
	CREATEUSER VARCHAR(25),
	CREATEDTS TIMESTAMP_NTZ(9),
	UPDATEUSER VARCHAR(25),
	UPDATEDTS TIMESTAMP_NTZ(9),
	FRMW_EXTRACTED_ON TIMESTAMP_NTZ(9),
	SNFLK_UPDATEDON TIMESTAMP_NTZ(9)
);