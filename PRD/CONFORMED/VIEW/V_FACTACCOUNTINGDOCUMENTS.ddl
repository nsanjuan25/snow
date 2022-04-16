create or replace view V_FACTACCOUNTINGDOCUMENTS(
	DATASOURCEKEY,
	SUPPLIERCOMPANYKEY,
	PURCHASEDOCUMENTNUMBER,
	ACCOUNTINGDOCUMENTNUMBER,
	FISCALYEAR,
	COMPANYORGANIZATIONCODE,
	LINEITEM,
	ACCOUNTINNUMBERLINEITEM,
	AMOUNTINSECONDLOCALCURRENCY,
	QUANTITY,
	PROFITCENTERCODE,
	BUSINESSPARTNERREFERENCEKEY1,
	PAYMENTTERMS,
	VENDORCREDITORACCOUNTNUMBER,
	DOCUMENTDATEINDOCUMENT,
	POSTINGDATEINDOCUMENT,
	PURCHASEDOCUMENTITEM,
	GENERALLEDGERACCOUNT,
	CLEARINGDOCUMENTNUMBER,
	DOCUMENTTYPE,
	ASSIGNMENTNUMBER,
	AMOUNTINDOCUMENTCURRENCY,
	REFKEY1,
	REFKEY2,
	REFERENCEDOCUMENTNUMBER,
	CURRENCYKEY,
	CURRENCYKEYSECONDLOCALCURRENCY,
	ACCOUNTTYPE,
	TRANSACTIONKEY,
	REFERENCEKEY,
	POSTKEY,
	HASH_VALUE,
	SRCLASTMODIFIEDDATE
) as SELECT
		  1 as  DataSourceKey    
		, IFNULL(DCS.SupplierCompanyKey,0)			AS SupplierCompanyKey
		, BS.ebeln			AS PurchaseDocumentNumber
		, BS.belnr			AS AccountingDocumentNumber
		, BS.gjahr			AS FiscalYear
		, BS.bukrs			AS CompanyOrganizationCode
		, BS.buzid			AS LineItem
		, BS.buzei			AS AccountinNumberLineItem
		, BS.dmbe2			AS AmountInSecondLocalCurrency
		, BS.menge			AS Quantity
		, BS.prctr			AS ProfitCenterCode
		, BS.xref1			AS BusinessPartnerReferencekey1
		, BS.zterm			AS PaymentTerms
		, BS.lifnr			AS VendorCreditorAccountNumber
		, BS.BLDAT			AS DocumentDateInDocument
		, BS.BUDAT			AS PostingDateInDocument
		, BS.ebelp			AS PurchaseDocumentItem
		, BS.hkont			AS GeneralLedgerAccount
		, BS.augbl			AS ClearingDocumentNumber
		, BS.blart			AS DocumentType
		, BS.zuonr			AS AssignmentNumber
		, BS.wrbtr			AS AmountInDocumentCurrency
		, BS.XREF1_HD		AS RefKey1
		, BS.XREF2_HD		AS RefKey2
		, BS.XBLNR			AS ReferenceDocumentNumber
		, BS.WAERS			AS CurrencyKey
		, BS.HWAE2			AS CurrencyKeySecondLocalCurrency
		, BS.koart			AS AccountType
		, BS.ktosl			AS TransactionKey
		, BS.awkey			AS ReferenceKey
		, BS.BSCHL			AS PostKey
		, HASH(IFNULL(BS.belnr, '') 
			, IFNULL(BS.gjahr, '') 
			, IFNULL(BS.bukrs, ' ') 
			, IFNULL(BS.buzid, ' ') 
			, IFNULL(BS.buzei, ' ') 
			, CAST(IFNULL(BS.dmbe2, 0) AS VARCHAR(20)) 
			, CAST(IFNULL(BS.menge, 0) AS VARCHAR(20)) 
			, IFNULL(BS.prctr, '') 
			, IFNULL(BS.xref1, '') 
			, IFNULL(BS.zterm, '') 
			, IFNULL(BS.lifnr, '') 
			, IFNULL(BS.BLDAT, '') 
			, IFNULL(BS.BUDAT, '') 
			, IFNULL(BS.ebelp, '') 
			, IFNULL(BS.hkont, '') 
			, IFNULL(BS.augbl, '') 
			, IFNULL(BS.blart, '') 
			, IFNULL(BS.zuonr, '') 
			, CAST(IFNULL(BS.wrbtr, 0) AS VARCHAR(20)) 
			, IFNULL(BS.XREF1_HD, '') 
			, IFNULL(BS.XREF2_HD, '') 
			, IFNULL(BS.XBLNR, '') 
			, IFNULL(BS.HWAE2, '') 
			, IFNULL(BS.koart, '') 
			, IFNULL(BS.ktosl, '') 
			, IFNULL(BS.awkey, '') 
			, IFNULL(BS.BSCHL, '') 
			, IFNULL(BS.WAERS, '')) AS HASH_VALUE
		, BS.updated_on																																																																																																																																																				AS SrcLastModifiedDate
	FROM
		CONFORMED.V_BSEG_BKPF								BS
		
		LEFT OUTER JOIN (
					SELECT ROW_NUMBER () OVER ( PARTITION BY SupplierCode ORDER BY DeleteFlag, UpdatedOn DESC) AS RNO
							,SupplierCompanyKey, SupplierCode, CompanyOrganizationCode
							FROM SAP.DimSupplierCompanies) AS DCS ON RTRIM(UPPER(IFNULL(BS.lifnr, '')))		= DCS.SupplierCode
																AND  RTRIM(UPPER(BS.bukrs))					= DCS.CompanyOrganizationCode
																AND DCS.RNO = 1;