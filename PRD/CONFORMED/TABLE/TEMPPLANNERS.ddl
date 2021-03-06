create or replace TABLE TEMPPLANNERS (
	PLANNERKEY NUMBER(38,0),
	DATASOURCEKEY NUMBER(38,0),
	PLANNERCODE VARCHAR(10),
	PLANTCODE VARCHAR(10),
	MRPCONTROLLER VARCHAR(10),
	FULLNAME VARCHAR(60),
	PHONE1 VARCHAR(20),
	PROFITCENTER VARCHAR(20),
	CREATEDBY VARCHAR(100),
	CREATEDON TIMESTAMP_NTZ(9),
	UPDATEDBY VARCHAR(100),
	UPDATEDON TIMESTAMP_NTZ(9)
);