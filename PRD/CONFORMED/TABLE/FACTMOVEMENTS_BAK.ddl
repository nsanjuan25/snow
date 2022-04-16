create or replace TABLE FACTMOVEMENTS_BAK (
	DATASOURCEKEY NUMBER(38,0) NOT NULL DEFAULT 0,
	MOVEMENTDOCUMENTNUMBER VARCHAR(40) NOT NULL DEFAULT ' ',
	MOVEMENTDOCUMENTITEM NUMBER(38,0) NOT NULL DEFAULT 0,
	MOVEMENTTYPEKEY NUMBER(38,0) NOT NULL DEFAULT 0,
	PLANTKEY NUMBER(38,0) NOT NULL DEFAULT 0,
	MATERIALKEY NUMBER(38,0) NOT NULL DEFAULT 0,
	POSTEDDATEKEY DATE NOT NULL DEFAULT CAST('1900-01-01' AS DATE),
	INVENTORYLOCATIONKEY NUMBER(38,0) NOT NULL DEFAULT 0,
	INVENTORYTYPEKEY NUMBER(38,0) NOT NULL DEFAULT 0,
	SPECIALSTOCKSKEY NUMBER(38,0) NOT NULL DEFAULT 0,
	AMLKEY NUMBER(38,0) NOT NULL DEFAULT 0,
	TRANSACTIONDATEKEY DATE NOT NULL DEFAULT CAST('1900-01-01' AS DATE),
	REASONTYPEKEY NUMBER(38,0) NOT NULL DEFAULT 0,
	SUPPLIERKEY NUMBER(38,0) NOT NULL DEFAULT 0,
	MATERIALGROUPKEY NUMBER(38,0) NOT NULL DEFAULT 0,
	MANUFACTURERKEY NUMBER(38,0) NOT NULL DEFAULT 0,
	MOVEMENTDOCUMENTTYPE VARCHAR(2) NOT NULL DEFAULT ' ',
	MOVEMENTYEAR NUMBER(38,0) NOT NULL DEFAULT 0,
	REFERENCEDOCUMENTNUMBER VARCHAR(20) NOT NULL DEFAULT ' ',
	BILLOFLADING VARCHAR(50) NOT NULL DEFAULT ' ',
	MOVEMENTCOMMENTS VARCHAR(50) NOT NULL DEFAULT ' ',
	QUANTITY NUMBER(18,6) NOT NULL DEFAULT 0,
	MATERIALCOST NUMBER(18,6) NOT NULL DEFAULT 0,
	CURRENCYCODE VARCHAR(5) NOT NULL DEFAULT ' ',
	EXCHANGERATEKEY NUMBER(38,0) NOT NULL DEFAULT 0,
	COMPANYORGANIZATIONCODE VARCHAR(8) NOT NULL DEFAULT ' ',
	SALESDOCUMENTNUMBER VARCHAR(12) NOT NULL DEFAULT ' ',
	SALESDOCUMENTITEM NUMBER(38,0) NOT NULL DEFAULT 0,
	PURCHASEDOCUMENTNUMBER VARCHAR(12) NOT NULL DEFAULT ' ',
	PURCHASEDOCUMENTITEM NUMBER(38,0) NOT NULL DEFAULT 0,
	DEBOOLEANCREDITINDICATOR VARCHAR(1) NOT NULL DEFAULT ' ',
	UNITOFMEASURE VARCHAR(6) NOT NULL DEFAULT ' ',
	BATCHNUMBER VARCHAR(20) NOT NULL DEFAULT ' ',
	MOVEMENTINDICATOR VARCHAR(1) NOT NULL DEFAULT ' ',
	MOVEMENTITEMCOMMENTS VARCHAR(50) NOT NULL DEFAULT ' ',
	CREATEDON TIMESTAMP_NTZ(9) NOT NULL DEFAULT CAST('1900-01-01' AS TIMESTAMP_NTZ(9)),
	CREATEDBY VARCHAR(100) NOT NULL DEFAULT ' ',
	UPDATEDON TIMESTAMP_NTZ(9) NOT NULL DEFAULT CAST('1900-01-01' AS TIMESTAMP_NTZ(9)),
	UPDATEDBY VARCHAR(100) NOT NULL DEFAULT ' ',
	SRCLASTMODIFIEDDATE TIMESTAMP_NTZ(9) NOT NULL DEFAULT CAST('1900-01-01' AS TIMESTAMP_NTZ(9)),
	ASSETNUMBER VARCHAR(20) NOT NULL DEFAULT ' ',
	ORDERNUMBER VARCHAR(20) NOT NULL DEFAULT ' ',
	COSTCENTER VARCHAR(20) NOT NULL DEFAULT ' ',
	WBSELEMENT VARCHAR(24) NOT NULL DEFAULT ' ',
	DEBITCREDITINDICATOR VARCHAR(1),
	constraint BKEY unique (DATASOURCEKEY, MOVEMENTDOCUMENTNUMBER, MOVEMENTDOCUMENTITEM),
	constraint FAMLKEY foreign key (AMLKEY) references PRD.SAP.DIMAML(AMLKEY),
	constraint FEXCHANGERATEKEY foreign key (EXCHANGERATEKEY) references PRD.SAP.DIMEXCHANGERATES(EXCHANGERATEKEY),
	constraint FMATERIALGROUPKEY foreign key (MATERIALGROUPKEY) references PRD.SAP.DIMMATERIALGROUPS(MATERIALGROUPKEY),
	constraint FSUPPLIERKEY foreign key (SUPPLIERKEY) references PRD.SAP.DIMSUPPLIERS(SUPPLIERKEY)
);