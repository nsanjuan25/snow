create or replace view V_FACTACCOUNTSRECEIVABLE(
	COMPANYORGANIZATIONKEY,
	CLEARINGDATE,
	POSTINGDATEINDOCUMENT,
	DOCUMENTDATEINDOCUMENT,
	ACCOUNTINGDOCUMENTENTRYDATE,
	BASELINEDATEDUEDATECALCULATION,
	NETPAYMENTDUEDATE,
	CASHDISCOUNTDUEDATE1,
	CASHDISCOUNTDUEDATE2,
	LASTDATEDUNNINGNOTICE,
	DOCUMENTTYPEKEY,
	BUSINESSAREAKEY,
	PAYMENTMETHODKEY,
	CUSTOMERKEY,
	ACCOUNTDOCUMENTSTATUSKEY,
	GENERALLEDGERACCOUNTKEY,
	CUSTOMERCODE,
	SPECIALGLTRANSACTIONTYPE,
	SPECIALGLINDICATOR,
	CLEARINGDOCUMENTNUMBER,
	ASSIGNMENTNUMBER,
	ACCOUNTINGDOCUMENTNUMBER,
	ACCOUNTINNUMBERLINEITEM,
	REFERENCEDOCUMENTNUMBER,
	CURRENCYKEY,
	POSTINGKEY,
	ITEMTEXT,
	GENERALLEDGERACCOUNTNUMBER,
	GENERALLEDGERACCOUNT,
	ACCOUNTNUMBERBRANCH,
	PAYMENTTERMS,
	PAYMENTMETHOD,
	PAYMENTBLOCKKEY,
	TRANSACTIONNUMBERINVOICE,
	FISCALYEARRELEVANTINVOICE,
	RELEVANTINVOICELINEITEM,
	DUNNINGBLOCK,
	DUNNINGKEY,
	DUNNINGLEVEL,
	DUNNINGAREA,
	BILLINGDOCUMENT,
	REASONCODEPAYMENTS,
	BUSINESSPARTNERREFERENCEKEY1,
	BUSINESSPARTNERREFERENCEKEY2,
	DOCUMENTARCHIVEDINDICATOR,
	CREDITCONTROLAREA,
	PROFITCENTERCODE,
	REFERENCEKEYLINEITEM,
	FISCALPERIOD,
	FISCALYEARVARIANT,
	CURRENCYKEYSECONDLOCALCURRENCY,
	CURRENCYKEYTHIRDLOCALCURRENCY,
	ACCOUNTTYPE,
	CHARTOFACCOUNTS,
	COUNTRYKEY,
	LOCALCURRENCY,
	RECORDMODE,
	SUBITEMNUMBER,
	AMOUNTINLOCALCURRENCY,
	AMOUNTINDOCUMENTCURRENCY,
	CASHDISCOUNTDAY1,
	CASHDISCOUNTDAY2,
	NETPAYMENTTERMSPERIOD,
	CASHDISCOUNTPERCENTAGE1,
	CASHDISCOUNTPERCENTAGE2,
	AMOUNTELIGIBLEFORCASHDISCOUNTINDOCUMENTCURRENCY,
	CASHDISCOUNTAMOUNTINLOCALCURRENCY,
	CASHDISCOUNTAMOUNTINDOCUMENTCURRENCY,
	AMOUNTINSECONDLOCALCURRENCY,
	AMOUNTINTHIRDLOCALCURRENCY,
	CREDITAMOUNTINLOCALCURRENCY,
	CREDITAMOUNTINLOCALCURRENCYSIGNS,
	DEBITAMOUNTINLOCALCURRENCY,
	FOREINGKEYAMOUNTSIGNS,
	DOCUMENTCURRENCYDEBITAMOUNT,
	DOCUMENTCURRENCYCREDITAMOUNT,
	SRCLASTMODIFIEDDATE,
	COMPANYORGANIZATIONCODE,
	FISTATUS,
	POSTINGKEYKEY,
	PROFITCENTERCODEKEY,
	DOCUMENTTYPE,
	BUSINESSAREA,
	SEQGEN
) as
/*--------------------------------------------------------------------------------------------

This view is used to insert data into SAP.FACTACCOUNTSRECEIVABLE
----------------------------------------------------------------------------------------------
Revision History
----------------------------------------------------------------------------------------------
Date            Developer               Comments
----------------------------------------------------------------------------------------------
2021-07-15      Jayashri                   Initial Revision
*/
SELECT 
	  ifnull( DCO.CompanyOrganizationKey , 0 )                          AS CompanyOrganizationKey
	, ifnull( try_to_date ( EBB.AUGDT  , 'YYYYMMDD' )  , '1900-01-01')  AS ClearingDate
    , ifnull( try_to_date ( EBB.BUDAT  , 'YYYYMMDD' )  , '1900-01-01' ) AS PostingDateInDocument  
	, ifnull( try_to_date ( EBB.BLDAT  , 'YYYYMMDD' )  , '1900-01-01' ) AS DocumentDateInDocument
    , ifnull( try_to_date ( EBB.CPUDT  , 'YYYYMMDD' )  , '1900-01-01' ) AS AccountingDocumentEntryDate
	, ifnull( try_to_date ( EBB.ZFBDT  , 'YYYYMMDD' )  , '1900-01-01' ) AS BASeLineDateDueDateCalculation
	, ifnull( try_to_date ( EBB.NETDT  , 'YYYYMMDD' )  , '1900-01-01' ) AS NetPaymentDueDate
	, ifnull( try_to_date ( EBB.SK1DT  , 'YYYYMMDD' )  , '1900-01-01' ) AS CAShDiscountDueDate1
    , ifnull( try_to_date ( EBB.SK2DT  , 'YYYYMMDD' )  , '1900-01-01' ) AS CAShDiscountDueDate2
	, ifnull( try_to_date ( EBB.MADAT  , 'YYYYMMDD' )  , '1900-01-01' ) AS LAStDateDunningNotice
    , 0                                        AS DocumentTypeKey
	, 0                                        AS BusinessAreaKey
	, 0                                        AS PaymentMethodKey
	, 0                                        AS CustomerKey
	, IFNULL(DADS.AccountDocumentStatusKey,0)  AS AccountDocumentStatusKey
	, 0                                        AS GeneralLedgerAccountKey  -- Must be pouplated when we get the GL Catalog
	, RTRIM( IFNULL( EBB.KUNNER , '')) AS CustomerCode
	, RTRIM( IFNULL( EBB.UMSKS , '' )) AS SpecialGLTransactionType
	, RTRIM( IFNULL( EBB.UMSKZ , '' )) AS SpecialGLIndicator
	, RTRIM( IFNULL( EBB.AUGBL , '' )) AS ClearingDocumentNumber
	, RTRIM( IFNULL( EBB.ZUONR , '' )) AS ASsignmentNumber
    , RTRIM( IFNULL( EBB.BELNR , '' )) AS AccountingDocumentNumber
    , IFNULL( EBB.BUZEI , 0 )          AS AccountinNumberLineItem
	, RTRIM( IFNULL( EBB.XBLNR , '' )) AS ReferenceDocumentNumber
	, RTRIM( IFNULL( EBB.WAERS , '' )) AS CurrencyKey
	, RTRIM( IFNULL( EBB.BSCHL , '' )) AS PostingKey
	, RTRIM( IFNULL( EBB.SGTXT , '' )) AS ItemText
	, RTRIM( IFNULL( EBB.SAKNR , '' )) AS GeneralLedgerAccountNumber
	, RTRIM( IFNULL( EBB.HKONT , '' )) AS GeneralLedgerAccount
    , RTRIM( IFNULL( EBB.FILKD , '' )) AS AccountNumberBranch
    , RTRIM( IFNULL( EBB.ZTERM , '' )) AS PaymentTerms
	, RTRIM( IFNULL( EBB.ZLSCH , '' )) AS PaymentMethod
    , RTRIM( IFNULL( EBB.ZLSPR , '' )) AS PaymentBlockKey
    , RTRIM( IFNULL( EBB.REBZG , '' )) AS TransactionNumberInvoice
    , RTRIM( IFNULL( EBB.REBZJ , '' )) AS FiscalYearRelevantInvoice
    , RTRIM( IFNULL( EBB.REBZZ , 0 ))  AS RelevantInvoiceLineItem
    , RTRIM( IFNULL( EBB.MANSP , '' )) AS DunningBlock
    , RTRIM( IFNULL( EBB.MSCHL , '' )) AS DunningKey
    , RTRIM( IFNULL( EBB.MANST , '' )) AS DunningLevel
    , RTRIM( IFNULL( EBB.MABER , '' )) AS DunningArea
    , RTRIM( IFNULL( EBB.VBELN , '' )) AS BillingDocument
    , RTRIM( IFNULL( EBB.RSTGR , '' )) AS ReASonCodePayments
	, RTRIM( IFNULL( EBB.XREF1 , '' )) AS BusinessPartnerReferencekey1
    , RTRIM( IFNULL( EBB.XREF2 , '' )) AS BusinessPartnerReferencekey2
    , RTRIM( IFNULL( EBB.XARCH , '' )) AS DocumentArchivedIndicator
    , RTRIM( IFNULL( EBB.KKBER , '' )) AS CreditControlArea
	, RTRIM( IFNULL( EBB.PRCTR , '' )) AS ProfitCenterCode
	, RTRIM( IFNULL( EBB.XREF3 , '' )) AS ReferenceKeyLineItem
	, IFNULL(try_to_date(EBB.FISCPER   ,'YYYYMMDD'), '1900-01-01')	   AS FiscalPeriod
    , RTRIM( IFNULL( EBB.FISCVAR ,'' )) AS FiscalYearVariant
    , RTRIM( IFNULL( EBB.HWAE2 , '' )) AS CurrencyKeySecondLocalCurrency
    , RTRIM( IFNULL( EBB.HWAE3 , '' )) AS CurrencyKeyThirdLocalCurrency
    , RTRIM( IFNULL( EBB.KOART , '' )) AS AccountType
    , RTRIM( IFNULL( EBB.KTOPL , '' )) AS ChartOfAccounts
    , RTRIM( IFNULL( EBB.LAND1 , '' )) AS CountryKey
    , RTRIM( IFNULL( EBB.LCURR , '' )) AS LocalCurrency
	 ,RTRIM( IFNULL( EBB.UPDMOD ,'' )) AS RecordMode
    , IFNULL( EBB.UPOSZ , '' )		   AS SubItemNumber
	, IFNULL( EBB.DMBTR , 0 )          AS AmountInLocalCurrency
    , IFNULL( EBB.WRBTR , 0 )          AS AmountInDocumentCurrency
    , IFNULL( EBB.ZBD1T , 0 )          AS CAShDiscountDay1
    , IFNULL( EBB.ZBD2T , 0 )          AS CAShDiscountDay2
    , IFNULL( EBB.ZBD3T , 0 )          AS NetPaymentTermsPeriod
    , IFNULL( EBB.ZBD1P , 0 )          AS CAShDiscountPercentage1
    , IFNULL( EBB.ZBD2P , 0 )          AS CAShDiscountPercentage2
    , IFNULL( EBB.SKFBT , 0 )          AS AmountEligibleforCAShDiscountinDocumentCurrency
    , IFNULL( EBB.SKNTO , 0 )          AS CAShDiscountAmountInLocalCurrency
    , IFNULL( EBB.WSKTO , 0 )          AS CAShDiscountAmountInDocumentCurrency
    , IFNULL( EBB.DMBE2 , 0 )          AS AmountInSecondLocalCurrency
    , IFNULL( EBB.DMBE3 , 0 )          AS AmountInThirdLocalCurrency
    , IFNULL( EBB.DMHAB	, 0 )	       AS CreditAmountInLocalCurrency
    , IFNULL( EBB.DMSHB	, 0 )	       AS CreditAmountInLocalCurrencySigns
    , IFNULL( EBB.DMSOL	, 0 )	       AS DebitAmountInLocalCurrency
	, IFNULL( EBB.WRSHB	, 0 )	       AS ForeingKeyAmountSigns
    , IFNULL( EBB.WRSOL	, 0 )	       AS DocumentCurrencyDebitAmount
	, IFNULL( EBB.WRHAB	, 0 )	       AS DocumentCurrencyCreditAmount
	, EBB.SNFLK_UPDATEDON              AS SrcLAStModifiedDate
	, RTRIM( IFNULL( EBB.BUKRS , '' )) AS CompanyOrganizationCode
    , RTRIM(  IFNULL( EBB.STATUSPS,''))AS FIStatus   
    , 0                                AS PostingKeyKey
    , 0                                AS ProfitCenterCodeKey
    , RTRIM( IFNULL( EBB.BLART , '' )) AS DocumentType
    , RTRIM( IFNULL( EBB.GSBER , '' )) AS BusinessArea
    , IFNULL( EBB.SEQGEN , 0 )	       AS seqgen
FROM
    CONFORMED.BW_HA_BSID   AS EBB 
    LEFT OUTER JOIN SAP.DimCompanyOrganizations  AS DCO ON 
        RTRIM(  EBB.bukrs ) = DCO.CompanyOrganizationCode
    LEFT OUTER JOIN SAP.DimAccountDocumentStatus  AS DADS ON         
        RTRIM(  IFNULL( EBB.STATUSPS,'')) = DADS.AccountDocumentStatusCode;