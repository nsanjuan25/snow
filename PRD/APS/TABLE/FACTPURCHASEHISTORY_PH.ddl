create or replace TABLE FACTPURCHASEHISTORY_PH (
	DATASOURCEKEY VARCHAR(16777216),
	MATERIALKEY VARCHAR(16777216),
	PLANTKEY VARCHAR(16777216),
	MOVEMENTTYPEKEY VARCHAR(16777216),
	AMLKEY VARCHAR(16777216),
	QUANTITY VARCHAR(16777216),
	PURCHASEDOCUMENTITEM VARCHAR(16777216),
	CREATEDON VARCHAR(16777216),
	CREATEDBY VARCHAR(100),
	UPDATEDON VARCHAR(16777216),
	UPDATEDBY VARCHAR(100),
	SRCLASTMODIFIEDDATE VARCHAR(16777216),
	DEBITCREDITINDICATOR VARCHAR(1),
	PURCHASEDOCUMENTNUMBER VARCHAR(12),
	SEQUENCENUMBER VARCHAR(16777216),
	PURCHASEHISTORYTYPEKEY VARCHAR(16777216),
	MATERIALDOCUMENTNUMBER VARCHAR(40),
	MATERIALDOCUMENTITEM VARCHAR(16777216),
	POSTINGDATEKEY VARCHAR(16777216),
	MATERIALDOCUMENTYEAR VARCHAR(16777216),
	PURCHASEORDERHISTORYCATEGORY VARCHAR(10),
	QUANTITY2 VARCHAR(16777216),
	LOCALCURRENCYCODE VARCHAR(5),
	AMOUNTINLOCALCURRENCY VARCHAR(16777216),
	DOCUMENTCURRENCYCODE VARCHAR(5),
	AMOUNTINDOCUMENTCURRENCY VARCHAR(16777216),
	LOCALCURRENCYEXCHANGERATEKEY VARCHAR(16777216),
	DOCUMENTCURRENCYEXCHANGERATEKEY VARCHAR(16777216),
	DELIVERYCOMPLETEFLAG VARCHAR(10),
	REFERENCEDOCUMENTNUMBER VARCHAR(20),
	REFERENCEDOCUMENTITEM VARCHAR(20),
	INVOICEVALUELOCALCURRENCY VARCHAR(16777216),
	INVOICEVALUEFOREIGNCURRENCY VARCHAR(16777216),
	SHIPPINGCOMPLIANCECODE VARCHAR(10),
	PURCHASEDOCUMENTENTRYDATE VARCHAR(16777216),
	REFERENCEDOCUMENTNUMBER2 VARCHAR(40)
);