create or replace TABLE DIMSELLERS_CONFORMED (
	SELLERNAME VARCHAR(50),
	PHONE1 VARCHAR(20),
	DATASOURCEKEY NUMBER(38,0),
	SELLERKEY NUMBER(38,0),
	LASTNAME VARCHAR(20),
	FIRSTNAME VARCHAR(20),
	DELETEFLAG BOOLEAN
);