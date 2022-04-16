create or replace TABLE SCMDB_CLASSMAP (
	CLASSMAPID NUMBER(38,0),
	CLASSID NUMBER(38,0),
	CHARACTERID NUMBER(38,0),
	PARENT NUMBER(38,0),
	LVL NUMBER(38,0),
	COSTDRIVER VARCHAR(1),
	EDITFLAG VARCHAR(1),
	DATATYPEID NUMBER(38,0),
	BASEUOM NUMBER(38,0),
	FRMW_EXTRACTED_ON TIMESTAMP_NTZ(9),
	SNFLK_UPDATEDON TIMESTAMP_NTZ(9)
);