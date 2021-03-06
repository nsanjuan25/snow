create or replace TABLE SCMDB_DEMANDTYPE (
	DEMANDTYPEID NUMBER(38,0),
	DATASOURCEID NUMBER(38,0),
	DEMANDTYPECODE VARCHAR(30),
	DEMANDTYPESTDID NUMBER(38,0),
	DESCRIPTION VARCHAR(65),
	PROCESSINGRULE VARCHAR(20),
	ALLOTMENTORDER NUMBER(38,0),
	IMPORTJOBID NUMBER(38,0),
	DELETEFLAG BOOLEAN,
	CREATEUSER VARCHAR(25),
	CREATEDTS TIMESTAMP_NTZ(9),
	UPDATEUSER VARCHAR(25),
	UPDATEDTS TIMESTAMP_NTZ(9),
	PARENTSUPPLYTYPEID NUMBER(38,0),
	FRMW_EXTRACTED_ON TIMESTAMP_NTZ(9),
	SNFLK_UPDATEDON TIMESTAMP_NTZ(9)
);