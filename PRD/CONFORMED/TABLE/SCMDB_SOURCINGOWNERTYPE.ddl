create or replace TABLE SCMDB_SOURCINGOWNERTYPE (
	SOURCINGOWNERTYPEID NUMBER(38,0),
	SOURCINGOWNERTYPECODE VARCHAR(10),
	DESCRIPTION VARCHAR(50),
	SOURCINGOWNERTYPESTDID NUMBER(38,0),
	IMPORTJOBID NUMBER(38,0),
	DELETEFLAG BOOLEAN,
	CREATEUSER VARCHAR(25),
	CREATEDTS TIMESTAMP_NTZ(9),
	UPDATEUSER VARCHAR(25),
	UPDATEDTS TIMESTAMP_NTZ(9),
	WB_CLOSEDATE BOOLEAN,
	WB_CLOSEDATEUPDATEDATE TIMESTAMP_NTZ(9),
	WB_CLOSEDATEUPDATEUSER VARCHAR(25),
	CONTROLLEDBY VARCHAR(10),
	FRMW_EXTRACTED_ON TIMESTAMP_NTZ(9),
	SNFLK_UPDATEDON TIMESTAMP_NTZ(9)
);