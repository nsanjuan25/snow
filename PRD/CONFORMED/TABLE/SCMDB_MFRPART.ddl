create or replace TABLE SCMDB_MFRPART (
	MFRPARTID NUMBER(38,0),
	CORPORATIONID NUMBER(38,0),
	CLASSID NUMBER(38,0),
	MFRPARTCODE VARCHAR(50),
	MFRPARTDESCRIPTION VARCHAR(150),
	CLASSIFICATIONSTATUSID NUMBER(38,0),
	IMPORTJOBID NUMBER(38,0),
	DELETEFLAG BOOLEAN,
	CREATEUSER VARCHAR(25),
	CREATEDTS TIMESTAMP_NTZ(9),
	UPDATEUSER VARCHAR(25),
	UPDATEDTS TIMESTAMP_NTZ(9),
	PREVCLASSID NUMBER(38,0),
	PREVCLASSIFICATIONSTATUSID NUMBER(38,0),
	CLASSIFIEDBY NUMBER(38,0),
	CLASSIFIEDON TIMESTAMP_NTZ(9),
	CLASSIFICATIONMODIFIEDBY NUMBER(38,0),
	CLASSIFICATIONMODIFIEDON TIMESTAMP_NTZ(9),
	CLASSSTATUSSETTOORFROMPENDINGON TIMESTAMP_NTZ(9),
	INTERNALSTATUSID NUMBER(38,0),
	PREVINTERNALSTATUSID NUMBER(38,0),
	FORMATTEDMPN VARCHAR(50),
	FRMW_EXTRACTED_ON TIMESTAMP_NTZ(9),
	SNFLK_UPDATEDON TIMESTAMP_NTZ(9)
);