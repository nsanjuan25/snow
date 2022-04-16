create or replace TABLE SCMDB_SITEPARTTYPE (
	SITEPARTTYPEID NUMBER(38,0),
	DATASOURCEID NUMBER(38,0),
	SITEPARTTYPECODE VARCHAR(12),
	SITEPARTTYPESTDID NUMBER(38,0),
	DESCRIPTION VARCHAR(50),
	PROCESSINGRULE VARCHAR(12),
	SAFETYSTOCKRULE VARCHAR(12),
	SAFETYSTOCKDATERULE VARCHAR(12),
	USESAFETYLEADTIME BOOLEAN,
	DEPENDENTDEMANDUSAGE VARCHAR(12),
	USENEGATIVEONHAND BOOLEAN,
	USELEADTIMEADJUST BOOLEAN,
	MAKEBUY VARCHAR(12),
	FLEXPART BOOLEAN,
	PLANNEDORDERSUPPLYTYPEID NUMBER(38,0),
	PLANNEDORDERSUPPLYSTATUSID NUMBER(38,0),
	PLANNEDORDERTOSRSUPPLYTYPEID NUMBER(38,0),
	PLANNEDORDERTOSRSUPPLYSTATUSID NUMBER(38,0),
	IMPORTJOBID NUMBER(38,0),
	DELETEFLAG BOOLEAN,
	CREATEUSER VARCHAR(25),
	CREATEDTS TIMESTAMP_NTZ(9),
	UPDATEUSER VARCHAR(25),
	UPDATEDTS TIMESTAMP_NTZ(9),
	FRMW_EXTRACTED_ON TIMESTAMP_NTZ(9),
	SNFLK_UPDATEDON TIMESTAMP_NTZ(9)
);