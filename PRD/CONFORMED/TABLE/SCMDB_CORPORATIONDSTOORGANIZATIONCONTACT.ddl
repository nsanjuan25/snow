create or replace TABLE SCMDB_CORPORATIONDSTOORGANIZATIONCONTACT (
	CORPORATIONDSID NUMBER(38,0),
	DATASOURCEID NUMBER(38,0),
	ORGANIZATIONCODE VARCHAR(4),
	ORGANIZATIONTYPEID NUMBER(38,0),
	CONTACTID NUMBER(38,0),
	CONTACTTYPEID NUMBER(38,0),
	FRMW_EXTRACTED_ON TIMESTAMP_NTZ(9),
	SNFLK_UPDATEDON TIMESTAMP_NTZ(9)
);