create or replace TABLE FACTHISTORICALSPEND_CONFORMED (
	PURCHASEDOCUMENTNUMBER VARCHAR(12) NOT NULL DEFAULT '',
	PURCHASEDOCUMENTITEM NUMBER(38,0) NOT NULL DEFAULT 0,
	DATASOURCEKEY NUMBER(38,0) NOT NULL DEFAULT 0,
	MATERIALDOCUMENTNUMBER VARCHAR(40) NOT NULL DEFAULT '',
	MATERIALDOCUMENTITEM NUMBER(38,0) NOT NULL DEFAULT 0,
	MATERIALDOCUMENTYEAR NUMBER(38,0) NOT NULL DEFAULT 0,
	AMLKEY NUMBER(38,0) NOT NULL DEFAULT 0,
	SUPPLIERKEY NUMBER(38,0) NOT NULL DEFAULT 0,
	MANUFACTURERKEY NUMBER(38,0) NOT NULL DEFAULT 0,
	SPECIALSTOCKSKEY NUMBER(38,0) NOT NULL DEFAULT 0,
	PURCHASINGORGANIZATIONCODE VARCHAR(8) NOT NULL DEFAULT '',
	PLANTKEY NUMBER(38,0) NOT NULL DEFAULT 0,
	MATERIALKEY NUMBER(38,0) NOT NULL DEFAULT 0,
	QUANTITY FLOAT NOT NULL DEFAULT 0,
	QUANTITYINVOICED FLOAT NOT NULL DEFAULT 0,
	RECEIPTDATEKEY DATE NOT NULL DEFAULT CAST('1900-01-01' AS DATE),
	CURRENCYCODE VARCHAR(5) NOT NULL DEFAULT '',
	EXCHANGERATEKEY NUMBER(38,0) NOT NULL DEFAULT 0,
	INVOICEDFLAG VARCHAR(5) NOT NULL DEFAULT '',
	CONSIGNEDFLAG NUMBER(38,0) NOT NULL DEFAULT 0,
	PURCHASEDOCUMENTTYPEKEY NUMBER(38,0) NOT NULL DEFAULT 0,
	UNITCOSTINLOCALCURRENCY FLOAT NOT NULL DEFAULT 0,
	CREATEDBY VARCHAR(100) NOT NULL DEFAULT '',
	CREATEDON TIMESTAMP_NTZ(9) NOT NULL DEFAULT CURRENT_TIMESTAMP(),
	UPDATEDBY VARCHAR(100) NOT NULL DEFAULT '',
	UPDATEDON TIMESTAMP_NTZ(9) NOT NULL DEFAULT CURRENT_TIMESTAMP(),
	HASH_VALUE NUMBER(19,0) NOT NULL DEFAULT 0,
	SRCLASTMODIFIEDDATE TIMESTAMP_NTZ(9) NOT NULL DEFAULT CAST('1900-01-01' AS TIMESTAMP_NTZ(9)),
	COSTCENTER VARCHAR(10) NOT NULL DEFAULT '',
	ORDERNUMBER VARCHAR(12) NOT NULL DEFAULT '',
	ASSETNUMBER VARCHAR(12) NOT NULL DEFAULT '',
	DOCUMENTCURRENCYCODE VARCHAR(5) NOT NULL DEFAULT '',
	AMOUNTINLOCALCURRENCY FLOAT DEFAULT 0,
	AMOUNTINDOCUMENTCURRENCY FLOAT DEFAULT 0,
	WBSELEMENT VARCHAR(12) NOT NULL DEFAULT ''
);