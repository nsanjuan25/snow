create or replace view V_FACTCOUPAHISTORICALSPEND(
	PURCHASEDOCUMENTNUMBER,
	PURCHASEDOCUMENTITEM,
	PURCHASEORDERID,
	PURCHASEORDERLINEID,
	PURCHASEORDERLINENUMBER,
	ACCOUNTLINEID,
	ACCOUNTLINENUMBER,
	MATERIALDOCUMENTNUMBER,
	SUPPLIERKEY,
	PLANTKEY,
	QUANTITY,
	QUANTITYINVOICED,
	RECEIPTDATEKEY,
	CURRENCYCODE,
	DOCUMENTCURRENCYCODE,
	AMOUNTINDOCUMENTCURRENCY,
	AMOUNTINLOCALCURRENCY,
	EXCHANGERATEKEY,
	AMOUNTFLAG,
	INVOICEDFLAG,
	UNITCOSTINLOCALCURRENCY,
	SRCLASTMODIFIEDDATE,
	RECEIPTTYPE
) as
/*--------------------------------------------------------------------

This view is used to ADD data into SAP.FactCoupaHistoricalSpend table
-----------------------------------------------------------------------
Revision History
-----------------------------------------------------------------------
Date            Developer               Comments
-----------------------------------------------------------------------
2021-07-22      Noel San Juan          Initial Revision
*/
SELECT 
	  IFNULL(PurchaseDocumentNumber, '')		AS PurchaseDocumentNumber
	, IFNULL(PurchaseOrderLineNumber, 0)		AS PurchaseDocumentItem
	, IFNULL(PurchaseOrderID, 0)				AS PurchaseOrderID
	, IFNULL(PurchaseOrderLineID, 0)			AS PurchaseOrderLineID
	, IFNULL(PurchaseOrderLineNumber, 0)		AS PurchaseOrderLineNumber
	, IFNULL(AccountLineID, 0)					AS AccountLineID
	, IFNULL(AccountLineNumber, 0)				AS AccountLineNumber
	, IFNULL(MaterialDocumentNumber, 0)		    AS MaterialDocumentNumber
	, IFNULL(SupplierKey, 0)					AS SupplierKey
	, IFNULL(PlantKey, 0)						AS PlantKey
	, IFNULL(SplitQuantity, 0)					AS Quantity
	, '0'										AS QuantityInvoiced
	, IFNULL(ReceiptDateKey, '1900-01-01')		AS ReceiptDateKey
	, IFNULL(LocalCurrencyCode, '')				AS CurrencyCode
	, IFNULL(DocumentCurrencyCode, '')			AS DocumentCurrencyCode
	, IFNULL(AmountinDocumentCurrency, 0)		AS AmountinDocumentCurrency
	, IFNULL(SplitAmountLclCurrency, 0)			AS AmountInLocalCurrency
	, IFNULL(LocalCurrencyExchangeRateKey, 0)	AS ExchangeRateKey
	, CASE
		WHEN LineType = 'OrderAmountLine' THEN 'TRUE' 
		ELSE 'FALSE' 
	  END AS AmountFlag
	, 'FALSE' AS InvoicedFlag
	,  CASE LineType
		WHEN 'OrderAmountLine' THEN Price
		WHEN 'OrderQuantityLine' THEN
			CASE 
				WHEN Quantity = 0  THEN 0
			ELSE AmountInLocalCurrency / Quantity
			END

		ELSE AmountInLocalCurrency / Quantity
	END						AS UnitCostInLocalCurrency
	, SrcLastModifiedDate
	, ReceiptType
FROM 
( 
	SELECT
		  PurchaseOrderNumber			AS PurchaseDocumentNumber
		, PurchaseOrderID
		, PurchaseOrderLineID
		, PurchaseOrderLineNumber
		, AccountLineID
		, AccountLineNumber
		, CoupaInventoryID				AS MaterialDocumentNumber
		, SupplierKey
		, PlantKey
		, ReceiptDateKey
		, LocalCurrencyCode
		, DocumentCurrencyCode
		, LocalCurrencyExchangeRateKey
		, LineType
		, MIN(ReceiptType)			    AS ReceiptType
		, MAX(Price)					AS Price
		, SUM(Quantity)					AS Quantity
		, SUM(SplitQuantity)			AS SplitQuantity
		, SUM(AmountLclCurrency)		AS AmountInLocalCurrency
		, SUM(SplitAmountLclCurrency)	AS SplitAmountLclCurrency
		, SUM(AmountDocumentCurrency)	AS AmountInDocumentCurrency
		, MAX(SrcLastModifiedDate)		AS SrcLastModifiedDate
	FROM 
		(
			SELECT
				  fci.PurchaseOrderID
				, fci.PurchaseOrderNumber
				, fci.PurchaseOrderLineID
				, fci.PurchaseOrderLineNumber
				, fci.AccountLineID
				, fci.AccountLineNumber
				, fci.CoupaInventoryID
				, fci.LineType
				, MAX( fcpo.SupplierKey  )						AS SupplierKey
				, MAX( fcpo.PlantKey )							AS PlantKey
				, MIN( fci.PostingDateKey )						AS ReceiptDateKey
				, MAX( fci.LocalCurrencyCode )					AS LocalCurrencyCode
				, MAX( fci.DocumentCurrencyCode )				AS DocumentCurrencyCode
				, MIN( fci.LocalCurrencyExchangeRateKey )		AS LocalCurrencyExchangeRateKey
				, 1												AS ReceiptType
				, MAX( fcpo.NetPrice )							AS Price
				, SUM(CASE WHEN DebitCreditIndicator = '-' THEN 1 ELSE -1::INT END * ((fci.Quantity * fci.PercentageOfLine)/100))					AS SplitQuantity
				, SUM(CASE WHEN DebitCreditIndicator = '-' THEN 1 ELSE -1::INT END * (fci.Quantity))												AS Quantity
                , SUM(CASE WHEN DebitCreditIndicator = '-' THEN 1 ELSE -1::INT END * ((fci.AmountInLocalCurrency * fci.PercentageOfLine)/100))		AS SplitAmountLclCurrency
				, SUM(CASE WHEN DebitCreditIndicator = '-' THEN 1 ELSE -1::INT END * (fci.AmountInLocalCurrency))									AS AmountLclCurrency
				, SUM(CASE WHEN DebitCreditIndicator = '-' THEN 1 ELSE -1::INT END * ((fci.AmountInDocumentCurrency * fci.PercentageOfLine)/100))	AS AmountDocumentCurrency
				, MAX(fci.SrcLastModifiedDate) AS SrcLastModifiedDate
			FROM 
				COUPA.FACTCOUPAINVENTORY fci 
				INNER JOIN COUPA.FACTCOUPAPURCHASEORDERS fcpo 
					ON fci.PurchaseOrderID =fcpo.PurchaseOrderID  
					AND fci.PurchaseOrderNumber = fcpo.PurchaseOrderNumber
					AND fci.PurchaseOrderLineID = fcpo.PurchaseOrderLineID
					AND fci.PurchaseOrderLineNumber = fcpo.PurchaseOrderLineNumber
					AND fci.AccountLineID = fcpo.AccountLineID
					AND fci.AccountLineNumber = fcpo.AccountLineNumber
					AND fci.DataSourceKey = fcpo.DataSourceKey
				INNER JOIN SAP.DIMPURCHASEHISTORYTYPES DPHT ON DPHT.PurchaseHistoryTypeKey = fci.PurchaseHistoryTypeKey
			WHERE 
				DPHT.PurchaseHistoryTypeStandardCode = 'Goods Receipt'
			GROUP BY
				  fci.PurchaseOrderID
				, fci.PurchaseOrderNumber
				, fci.PurchaseOrderLineID
				, fci.PurchaseOrderLineNumber
				, fci.AccountLineID
				, fci.AccountLineNumber
				, fci.CoupaInventoryID
				, fci.LineType
    ) REMOVE_NEGATIVE_POSITIVE_VALUES
GROUP BY 
      PurchaseOrderNumber
	, PurchaseOrderID
	, PurchaseOrderLineID
	, PurchaseOrderLineNumber
	, AccountLineID
	, AccountLineNumber
    , CoupaInventoryID
    , SupplierKey
    , PlantKey
    , ReceiptDateKey
    , LocalCurrencyCode
	, DocumentCurrencyCode
    , LocalCurrencyExchangeRateKey 
	, LineType
) FINAL_QUERY;