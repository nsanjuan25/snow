create or replace TABLE DEMANDBYMATERIAL (
	MRPCURRENTDATEKEY DATE,
	DATASOURCEKEY NUMBER(38,0),
	MATERIALKEY NUMBER(38,0),
	ONHANDQUANTITY NUMBER(31,5),
	ONORDERQUANTITY NUMBER(31,5),
	DEMANDQUANTITY NUMBER(31,5),
	DEMANDQUANTITY90DAYS NUMBER(31,5)
);