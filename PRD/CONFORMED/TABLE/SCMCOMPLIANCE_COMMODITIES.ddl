create or replace TABLE SCMCOMPLIANCE_COMMODITIES (
	COMMODITY_ID NUMBER(38,0),
	NAME VARCHAR(50),
	CATEGORY VARCHAR(50),
	CLASSID NUMBER(38,0),
	FRMW_EXTRACTED_ON TIMESTAMP_NTZ(9),
	SNFLK_UPDATEDON TIMESTAMP_NTZ(9)
);