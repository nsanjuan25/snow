create or replace TABLE SCMDB_CORPORATIONDSTOORGANIZATION (
	CORPORATIONDSID NUMBER(38,0),
	DATASOURCEID NUMBER(38,0),
	ORGANIZATIONCODE VARCHAR(4),
	ORGANIZATIONTYPEID NUMBER(38,0),
	QUALIFICATIONSTATUS VARCHAR(20),
	PAYMENTTERMS VARCHAR(50),
	INCOTERM1 VARCHAR(3),
	INCOTERM2 VARCHAR(50),
	CURRENCYCODE VARCHAR(4),
	ACCOUNTINGCORPORATIONID NUMBER(38,0),
	IMPORTJOBID NUMBER(38,0),
	DELETEFLAG BOOLEAN,
	CREATEUSER VARCHAR(25),
	CREATEDTS TIMESTAMP_NTZ(9),
	UPDATEUSER VARCHAR(25),
	UPDATEDTS TIMESTAMP_NTZ(9),
	MINORITYINDICATOR VARCHAR(3),
	MINORITYTEXT VARCHAR(30),
	CERTIFICATIONDATE TIMESTAMP_NTZ(9),
	VENDORMASTERPAYMENTTERMS VARCHAR(5),
	FRMW_EXTRACTED_ON TIMESTAMP_NTZ(9),
	SNFLK_UPDATEDON TIMESTAMP_NTZ(9)
);