create or replace view V_FACTCOUPAINVENTORY(
	ROW_ID,
	COUPAINVENTORYID,
	PURCHASEORDERID,
	PURCHASEORDERNUMBER,
	PURCHASEORDERLINEID,
	PURCHASEORDERLINENUMBER,
	ACCOUNTLINEID,
	ACCOUNTLINENUMBER,
	PURCHASEHISTORYTYPEKEY,
	DATASOURCEKEY,
	POSTINGDATEKEY,
	POSTINGDATE,
	MATERIALDOCUMENTYEAR,
	PURCHASEORDERHISTORYCATEGORY,
	QUANTITY,
	PRICE,
	PERCENTAGEOFLINE,
	INVENTORYCURRENCYCODE,
	LOCALCURRENCYCODE,
	AMOUNTININVENTORY,
	AMOUNTINLOCALCURRENCY,
	DOCUMENTCURRENCYCODE,
	AMOUNTINDOCUMENTCURRENCY,
	LOCALCURRENCYEXCHANGERATEKEY,
	DEBITCREDITINDICATOR,
	INVOICEVALUELOCALCURRENCY,
	INVOICEVALUEFOREIGNCURRENCY,
	SRCLASTMODIFIEDDATE,
	EXPORTEDFLAG,
	INVENTORYSTATUS,
	INVENTORYTYPE,
	REQ,
	ITEMNUMBER,
	ORDERQUANTITY,
	SUPPLIERNUMBER,
	LASTEXPORTEDAT,
	RECEIPTDATE,
	INVENTORYCREATEDDATE,
	TRADINGPARTNER,
	LINETYPE,
	ORDERUNITOFMEASURECODE,
	COMPANYCODE,
	COUPAACCASSIGNMENTKEY,
	LASTUPDATEDDATE,
	HASHVALUE
) as
/* 
Description             : This is the template for Header Section on Views
Created date            : 2021-05-21
Created By              : Arnel Melchor

Start Revision History            
-----------------------------------------------------------------------------------------------
Date                 Developer           Revision Description
----------           --------------      -----------------------------------------------------------
2021-05-21           Arnel Melchor            Initial Create
-----------------------------------------------------------------------------------------------
End   Revision   History
*/
SELECT
    uniq.Row_Id
  , uniq.CoupaInventoryID
  , uniq.PurchaseOrderID
  , uniq.PurchaseOrderNumber
  , uniq.PurchaseOrderLineID
  , uniq.PurchaseOrderLineNumber
  , uniq.AccountLineID
  , uniq.AccountLineNumber
  , uniq.PurchaseHistoryTypeKey
  , uniq.DataSourceKey
  , uniq.PostingDateKey
  , uniq.PostingDate
  , uniq.MaterialDocumentYear
  , uniq.PurchaseOrderHistoryCategory
  , uniq.Quantity
  , uniq.Price
  , uniq.PercentageOfLine
  , uniq.InventoryCurrencyCode
  , uniq.LocalCurrencyCode
  , uniq.AmountInInventory
  , uniq.AmountInLocalCurrency
  , uniq.DocumentCurrencyCode
  , uniq.AmountInDocumentCurrency
  , uniq.LocalCurrencyExchangeRateKey
  , uniq.DebitCreditIndicator
  , uniq.InvoiceValueLocalCurrency
  , uniq.InvoiceValueForeignCurrency
  , uniq.SrcLastModifiedDate
  , uniq.ExportedFlag
  , uniq.InventoryStatus
  , uniq.InventoryType
  , uniq.Req
  , uniq.ItemNumber
  , uniq.OrderQuantity 
  , uniq.SupplierNumber
  , uniq.LastExportedAt
  , uniq.ReceiptDate
  , uniq.InventoryCreatedDate
  , uniq.TradingPartner
  , uniq.LineType
  , uniq.OrderUnitOfMeasureCode
  , uniq.CompanyCode
  , uniq.CoupaAccAssignmentKey
  , uniq.LastUpdatedDate
  , HASH(
          uniq.PurchaseOrderNumber
        , uniq.PurchaseOrderID
        , uniq.PurchaseOrderNumber
        , uniq.PurchaseOrderLineID
        , uniq.PurchaseOrderLineNumber
        , uniq.AccountLineID
        , uniq.AccountLineNumber
        , uniq.PostingDate
        , uniq.Quantity
        , uniq.Req
        , uniq.ItemNumber
        , uniq.OrderQuantity
        , uniq.SupplierNumber
        , uniq.LastExportedAt
        , uniq.TradingPartner
        , uniq.InventoryCurrencyCode
        , uniq.LocalCurrencyCode
        , uniq.Price
        , uniq.PercentageOfLine
        , uniq.AmountInInventory
        , uniq.AmountInLocalCurrency
        , uniq.LastExportedAt
        , uniq.LocalCurrencyExchangeRateKey
        , uniq.InventoryStatus
        , uniq.InventoryType
        , uniq.LineType
        , uniq.OrderUnitOfMeasureCode
        , uniq.CompanyCode
        , uniq.CoupaAccAssignmentKey
    ) AS HashValue

FROM
(
  SELECT
    ROW_NUMBER() OVER (PARTITION BY i.PoNumber,i.PoId,i.OrderLineId,i.AccountingLineId,i.AccountLineNumber,i.InventoryId ORDER BY i.LastUpdatedDate DESC) AS Row_Id
  , i.InventoryId										    AS CoupaInventoryID
  , i.PoId                                                  AS PurchaseOrderID
  , IFNULL(i.PoNumber,'')								    AS PurchaseOrderNumber
  , i.OrderLineId                                           AS PurchaseOrderLineID
  , i.OrderLineNumber                                       AS PurchaseOrderLineNumber
  , i.AccountingLineId                                      AS AccountLineID
  , i.AccountLineNumber                                     AS AccountLineNumber
  , 1													    AS PurchaseHistoryTypeKey--Use SAP Goods Receipt	
  , DS.DataSourceKey										AS DataSourceKey
  , IFNULL(TO_DATE(CAST( i.receiptdate AS TIMESTAMP_TZ)),'1900-01-01') AS PostingDateKey
  , IFNULL(TO_DATE(CAST( i.receiptdate AS TIMESTAMP_TZ)),'1900-01-01') AS PostingDate
  , IFNULL(CAST(SUBSTRING(i.receiptdate,1,4) AS INT),0)		AS MaterialDocumentYear
  , 'E'													    AS PurchaseOrderHistoryCategory
  , CAST( CASE WHEN i.InventoryQuantity IS NULL THEN 0
          WHEN i.InventoryQuantity = 'NULL' THEN 0
          WHEN i.InventoryQuantity = '' THEN 0
      ELSE i.InventoryQuantity
     END AS NUMERIC(18,6)) 									AS Quantity  
  , CAST(IFNULL(i.Price,0)AS NUMERIC(18,6)) 				AS Price
  , CAST(IFNULL(i.PercentageOfLine,0) AS NUMERIC(18,6))		AS PercentageOfLine
  , IFNULL(LTRIM(RTRIM(i.Currency)),'')						AS InventoryCurrencyCode
  , IFNULL(LTRIM(RTRIM(DCO.Currency)),'')					AS LocalCurrencyCode
  , CAST(IFNULL(i.Total,0) AS NUMERIC(18,6))			   	AS AmountInInventory
  , CASE 
      WHEN IFNULL(LTRIM(RTRIM(DCO.Currency)),'') = IFNULL(LTRIM(RTRIM(i.Currency)),'') THEN IFNULL(i.total,0) 
      ELSE IFNULL(i.Total * ER.ExchangeRate,0)
    END													AS AmountInLocalCurrency
  , IFNULL(LTRIM(RTRIM(i.Currency)),'')					AS DocumentCurrencyCode
  , IFNULL(i.Total,0)									AS AmountInDocumentCurrency
  , IFNULL(LCER.ExchangeRateKey,0)						AS LocalCurrencyExchangeRateKey
  , CASE WHEN i.Status = 'created' THEN '-' ELSE '+' END	AS DebitCreditIndicator
  , 0.000000												AS InvoiceValueLocalCurrency
  , 0.000000												AS InvoiceValueForeignCurrency
  , CAST(CAST( i.LastUpdatedDate AS TIMESTAMP_TZ) AS DATETIME) AS SrcLastModifiedDate
  , CAST(CAST( i.LastUpdatedDate AS TIMESTAMP_TZ) AS DATETIME) AS LastUpdatedDate
  , CAST(IFNULL(CASE WHEN i.Exported = 'true' THEN 1 ELSE 0 END,0) AS INT) AS ExportedFlag
  , IFNULL(i.status,'')									AS InventoryStatus
  , IFNULL(i.Type,'')										AS InventoryType
  , CAST( CASE WHEN i.req IS NULL THEN 0
          WHEN i.req = 'NULL' THEN 0
          WHEN i.req = '' THEN 0
      ELSE i.req
     END AS INT) 										AS req
  , CAST( CASE WHEN i.ItemNumber IS NULL THEN 0
          WHEN i.ItemNumber = 'NULL' THEN 0
          WHEN i.ItemNumber = '' THEN 0
      ELSE i.ItemNumber
     END AS INT) 										AS ItemNumber
  , IFNULL(i.SupplierNumber,'')							AS SupplierNumber
  , CAST( CASE WHEN i.OrderQty IS NULL THEN 0
          WHEN i.OrderQty = 'NULL' THEN 0
          WHEN i.OrderQty = '' THEN 0
      ELSE i.OrderQty
     END AS NUMERIC(18,6)) 								AS OrderQuantity
  , CASE WHEN IFNULL(i.LastExportedAt,'') = '' THEN '1900-01-01 00:00:00.000'
      ELSE 
          CAST(CAST( i.LastExportedAt AS TIMESTAMP_TZ) AS DATETIME) 
      END													AS LastExportedAt
  , CASE WHEN IFNULL(i.ReceiptDate,'') = '' THEN '1900-01-01 00:00:00.000'
      ELSE 
          CAST(CAST( i.ReceiptDate AS TIMESTAMP_TZ) AS DATETIME) 
      END													AS ReceiptDate
  , CASE WHEN IFNULL(i.CreatedDate,'') = '' THEN '1900-01-01 00:00:00.000'
      ELSE 
          CAST(CAST( i.CreatedDate AS TIMESTAMP_TZ) AS DATETIME) 
      END													AS InventoryCreatedDate
  , IFNULL(i.TradingPartner,'')							    AS TradingPartner
  , IFNULL(i.LineType,'')									AS LineType
  , IFNULL(i.Uom,'')										AS OrderUnitOfMeasureCode
  , IFNULL(i.CompanyCode,'')								AS CompanyCode
  , IFNULL(DAA.CoupaAccAssignmentKey, 0)				    AS CoupaAccAssignmentKey
  
FROM
(
    SELECT 
          ROW_NUMBER() OVER ( PARTITION BY InventoryId,AccountingLineId,AccountLineNumber,Status ORDER BY LASTUPDATEDDATE DESC) AS rn
        , InventoryId
        , PoNumber
        , CAST( CASE WHEN PoId IS NULL THEN 0
					WHEN PoId = 'NULL' THEN 0
					WHEN PoId = '' THEN 0
					ELSE PoId
		  END AS NUMBER(38,0))									AS PoId
		, CAST( CASE WHEN OrderLineId IS NULL THEN 0
					WHEN OrderLineId = 'NULL' THEN 0
					WHEN OrderLineId = '' THEN 0
					ELSE OrderLineId
		  END AS NUMBER(38,0))									AS OrderLineId
		, CAST( CASE WHEN OrderLineNumber IS NULL THEN 0
					WHEN OrderLineNumber = 'NULL' THEN 0
					WHEN OrderLineNumber = '' THEN 0
					ELSE OrderLineNumber
		  END AS NUMBER(38,0))									AS OrderLineNumber
		, CAST( CASE WHEN AccountingLineId IS NULL THEN 0
					WHEN AccountingLineId = 'NULL' THEN 0
					WHEN AccountingLineId = '' THEN 0
					ELSE AccountingLineId
		  END AS NUMBER(38,0))									AS AccountingLineId
		, CAST( CASE WHEN AccountLineNumber IS NULL THEN 0
					WHEN AccountLineNumber = 'NULL' THEN 0
					WHEN AccountLineNumber = '' THEN 0
					ELSE AccountLineNumber
		  END AS NUMBER(38,0))									AS AccountLineNumber
        , Status
        , LASTUPDATEDDATE                             AS LastUpdatedDate
        , ReceiptDate
        , TO_DATE(IFNULL(SUBSTRING(ReceiptDate,1,10),'1900-01-01')) AS ReceiptDateFormat
        , InventoryQuantity
        , Price
        , PercentageOfLine
        , LTRIM(RTRIM(Currency)) AS Currency
        , Total
        , Exported
        , Type
        , Req
        , ItemNumber
        , OrderQty
        , LastExportedAt
        , CreatedDate
        , TradingPartner
        , LineType
        , CASE 
               WHEN ChartOfAccounts LIKE '%Expense%' THEN segment1 
               WHEN ChartOfAccounts LIKE '%NRE%Internal%Order%' THEN segment2 
               WHEN ChartOfAccounts LIKE '%Capital%' THEN segment3 
               WHEN ChartOfAccounts LIKE '%Network%Order%' THEN segment2 
               ELSE NULL 
           END                              AS CompanyCode
        , LEFT(LTRIM(RTRIM(
                CASE 
                       WHEN ChartOfAccounts LIKE '%Expense%' THEN segment1 
                       WHEN ChartOfAccounts LIKE '%NRE%Internal%Order%' THEN segment2 
                       WHEN ChartOfAccounts LIKE '%Capital%' THEN segment3 
                       WHEN ChartOfAccounts LIKE '%Network%Order%' THEN segment2 
                       ELSE NULL 
                   END)),4)                 AS CompanyCode2
        , SupplierNumber
        , Uom
    FROM CONFORMED.COUPA_INVENTORY WHERE ChartOfAccounts IN('NRE Internal Orders','Expense','Capital')
  ) i
    LEFT OUTER JOIN (SELECT MAX(DataSourceKey) AS DataSourceKey,DataSourceName FROM PUBLIC.DimDataSources GROUP BY DataSourceName) DS  ON DS.DataSourceName = 'Coupa'
    LEFT OUTER JOIN SAP.DimCompanyOrganizations DCO ON DCO.CompanyOrganizationCode = i.CompanyCode2
    LEFT OUTER JOIN COUPA.DimCoupaAccAssignment DAA 
      ON i.InventoryId			    = DAA.MaterialDocumentNumber
      AND i.PoNumber				= DAA.PurchaseDocumentNumber
      AND i.PoId					= DAA.PurchaseOrderID
      AND i.OrderLineId			    = DAA.PurchaseOrderLineID
      AND i.OrderLineNumber		    = DAA.PurchaseOrderLineNumber
      AND i.AccountingLineId	    = DAA.AccountLineID
      AND i.AccountLineNumber	    = DAA.AccountLineNumber
    
    LEFT OUTER JOIN (
                      SELECT 
                          DR1.ExchangeRateKey
                        , DR1.CurrencyCode
                        , DR1.ToCurrencyCode
                        , DR1.EffectiveFromDateKey
                        , DR1.DataSourceKey
                        , ROW_NUMBER() OVER (PARTITION BY DR1.CurrencyCode, DR1.ToCurrencyCode , DR1.DataSourceKey ORDER BY DR1.EffectiveFromDateKey DESC, DR1.ExchangeRateKey DESC ) AS rn 
                      FROM SAP.DimExchangeRates DR1
                      ) DLER 
        ON DLER.CurrencyCode = i.Currency
        AND DLER.ToCurrencyCode = DCO.Currency
        AND DLER.EffectiveFromDateKey = i.ReceiptDateFormat
        AND DLER.DataSourceKey = 1
    LEFT OUTER JOIN (
                      SELECT 
                          DR1.ExchangeRateKey
                        , DR1.CurrencyCode
                        , DR1.ToCurrencyCode
                        , DR1.EffectiveFromDateKey
                        , DR1.DataSourceKey
                        , ROW_NUMBER() OVER (PARTITION BY DR1.CurrencyCode, DR1.ToCurrencyCode , DR1.DataSourceKey ORDER BY DR1.EffectiveFromDateKey DESC, DR1.ExchangeRateKey DESC ) AS rn 
                      FROM SAP.DimExchangeRates DR1
            ) LCER
        ON LCER.CurrencyCode = DCO.Currency
        AND  LCER.ToCurrencyCode = 'USD'
        AND LCER.EffectiveFromDateKey = i.ReceiptDateFormat
        AND LCER.DataSourceKey = 1
    LEFT OUTER JOIN SAP.DimExchangeRates ER ON DLER.ExchangeRateKey = ER.ExchangeRateKey
    WHERE i.rn = 1
  ) uniq
WHERE uniq.Row_Id = 1;