create or replace TABLE SCMCOMPLIANCE_FACILITIESANDFACILITYTYPES (
	FACILITY_ID NUMBER(38,0),
	FACILITYTYPE_ID NUMBER(38,0),
	UPDATEDBY VARCHAR(100),
	VALIDFROM TIMESTAMP_NTZ(9),
	VALIDTO TIMESTAMP_NTZ(9),
	FRMW_EXTRACTED_ON TIMESTAMP_NTZ(9),
	SNFLK_UPDATEDON TIMESTAMP_NTZ(9)
);