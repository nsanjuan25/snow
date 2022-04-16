create or replace view V_FACTCOUPAINVOICES(
	INVOICENUMBER,
	INVOICEID,
	LASTEXPORTEDAT,
	CREATEDDATE,
	SUPPLIERNUMBER,
	NETDUEDATE,
	TOTALTAX,
	TOTAL,
	CURRENCYCODE,
	IMPORTEDINTOSAP,
	STATUS,
	DOCUMENTTYPE,
	SRCLASTMODIFIEDDATE,
	LOADTYPE,
	CHARTOFACCOUNTS,
	COMPANYCODE,
	HASH_VALUE
) as 

/*--------------------------------------------------------------------------------------------

 

This view is used to insert data into COUPA.FACTCOUPAINVOICES

----------------------------------------------------------------------------------------------

Revision History

----------------------------------------------------------------------------------------------

Date            Developer               Comments

----------------------------------------------------------------------------------------------

2021-05-12      Lynelle Joanna               Initial 

*/ 


	SELECT 
		  i.invoicenumber													AS InvoiceNumber
		, i.invoiceid														AS InvoiceId
		, CASE   WHEN i.lastexportedat IS NULL 
                THEN 
                    '1900-01-01'
			    ELSE 
					LEFT(i.lastexportedat,10)	
                END AS LastExportedAt
        , IFNULL(i.createddate,'19000101')         AS CreatedDate
        , IFNULL(i.Suppliernumber,'0')										AS SupplierNumber
		, IFNULL(i.netduedate,'19000101')	        AS NetDueDate 
		, IFNULL(totaltax,0)												AS TotalTax
		, IFNULL(total,0)													AS Total
		, IFNULL(i.Currency,'')												AS CurrencyCode
		, i.importedintosap												    AS ImportedIntoSap
		, UPPER(IFNULL(i.status,''))										AS Status
		, i.documenttype													AS DocumentType
		, i.frmw_extracted_on												AS SrcLastModifiedDate
		, 'DELTA'													        AS LoadType
		, IFNULL(i.Chartofaccount,'0')										AS ChartofAccounts
		, IFNULL(i.CompanyCode,'0')											AS CompanyCode
		, HASH(
			   i.invoicenumber
			 , i.invoiceid
			 , i.lastexportedat 
			 , i.createddate 
			 , i.Suppliernumber
			 , i.netduedate 
			 , i.total
             , i.Currency
			 , i.importedintosap
			 , i.status
			 , i.documenttype
			 , i.frmw_extracted_on
    		) AS HASH_VALUE 
	FROM
		Conformed.Coupa_Invoices i;