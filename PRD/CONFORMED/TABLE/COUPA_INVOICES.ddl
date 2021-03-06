create or replace TABLE COUPA_INVOICES (
	INVOICENUMBER VARCHAR(50),
	INVOICEID NUMBER(38,0),
	LASTEXPORTEDAT TIMESTAMP_NTZ(9),
	CREATEDDATE TIMESTAMP_NTZ(9),
	SUPPLIERNUMBER VARCHAR(255),
	NETDUEDATE TIMESTAMP_NTZ(9),
	TOTALTAX NUMBER(30,6),
	TOTAL NUMBER(30,6),
	CURRENCY VARCHAR(50),
	IMPORTEDINTOSAP VARCHAR(50),
	STATUS VARCHAR(50),
	DOCUMENTTYPE VARCHAR(50),
	CHARTOFACCOUNT VARCHAR(50),
	COMPANYCODE VARCHAR(50),
	FRMW_EXTRACTED_ON TIMESTAMP_NTZ(9),
	SNFLK_UPDATEDON TIMESTAMP_NTZ(9)
);