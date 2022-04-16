create or replace view V_FACTHISTORICALSPEND_PURCHASEHISTORYBASE(
	PURCHASEDOCUMENTNUMBER,
	PURCHASEDOCUMENTITEM,
	DATASOURCEKEY,
	MATERIALDOCUMENTYEAR,
	MATERIALDOCUMENTNUMBER,
	MATERIALDOCUMENTITEM,
	PURCHASEHISTORYTYPESTANDARDCODEORDER,
	PURCHASEHISTORYTYPESTANDARDCODE,
	AMLKEY,
	SUPPLIERKEY,
	SPECIALSTOCKSKEY,
	PURCHASINGORGANIZATIONCODE,
	PURCHASEDOCUMENTTYPEKEY,
	MANUFACTURERKEY,
	PLANTKEY,
	MATERIALKEY,
	RECEIPTDATEKEY,
	LOCALCURRENCYCODE,
	LOCALCURRENCYEXCHANGERATEKEY,
	QUANTITY,
	AMOUNTINLOCALCURRENCY,
	QUANTITYRECEIVED,
	AMOUNTRECEIVEDINLOCALCURRENCY,
	QUANTITYINVOICED,
	AMOUNTINVOICEDINLOCALCURRENCY,
	QUANTITYDEBITED,
	AMOUNTDEBITEDINLOCALCURRENCY,
	SRCLASTMODIFIEDDATE
) as SELECT
      fctPH.PurchaseDocumentNumber
    , fctPH.PurchaseDocumentItem
    , fctPH.DataSourceKey
    , fctPH.MaterialDocumentYear
    , CASE 
            WHEN IFNULL(fctPH.ReferenceDocumentNumber,'') = ''  THEN fctPH.MaterialDocumentNumber
            ELSE fctPH.ReferenceDocumentNumber
        END AS MaterialDocumentNumber
    , CASE 
            WHEN IFNULL(fctPH.ReferenceDocumentItem,'') = '' OR fctPH.ReferenceDocumentItem = 0 THEN fctPH.MaterialDocumentItem
            ELSE fctPH.ReferenceDocumentItem
        END AS MaterialDocumentItem
    , CASE 
        WHEN DPHT.PurchaseHistoryTypeStandardCode  = 'Goods Receipt'   THEN 1
        WHEN DPHT.PurchaseHistoryTypeStandardCode  = 'Invoice Receipt' THEN 2
        WHEN DPHT.PurchaseHistoryTypeStandardCode  = 'Debit/Credit'    THEN 3
        END AS PurchaseHistoryTypeStandardCodeOrder
    , DPHT.PurchaseHistoryTypeStandardCode
    , MAX( fctPH.AMLKey )                       AS AMLKey
    , MAX( fctPO.SupplierKey  )                 AS SupplierKey
    , MAX( FctPO.SpecialStocksKey )             AS SpecialStocksKey
    , MAX( FctPO.PurchasingOrganizationCode )   AS PurchasingOrganizationCode
    , fctPO.PurchaseDocumentTypeKey
    , MAX( fctPO.ManufacturerKey )              AS ManufacturerKey
    , fctPH.PlantKey 
    , fctPH.MaterialKey 
    , MIN( fctPH.PostingDateKey )               AS ReceiptDateKey 
    , MAX( fctPH.LocalCurrencyCode )            AS LocalCurrencyCode
    , MIN( fctPH.LocalCurrencyExchangeRateKey ) AS LocalCurrencyExchangeRateKey
    , SUM(CASE WHEN DPHT.PurchaseHistoryTypeStandardCode = 'Goods Receipt' OR  IFNULL(ReferenceDocumentNumber,'') = ''  --fix this was uncommented
            THEN Cast(DebitCreditIndicator +'1' as INTEGER) * -1 *Quantity
	        ELSE 0 END)
        AS Quantity
       
    , Sum(CASE WHEN DPHT.PurchaseHistoryTypeStandardCode = 'Goods Receipt' OR  IFNULL(ReferenceDocumentNumber,'') = '' --fix this was uncommented
            THEN Cast(DebitCreditIndicator +'1' as INTEGER) * -1 *AmountInLocalCurrency
	        ELSE 0 END)
        AS AmountInLocalCurrency

    , SUM(CASE WHEN DPHT.PurchaseHistoryTypeStandardCode = 'Goods Receipt'  
            THEN Cast(DebitCreditIndicator +'1' as INTEGER) * -1 *Quantity
	        ELSE 0 END)
        AS QuantityReceived


    , Sum(CASE WHEN DPHT.PurchaseHistoryTypeStandardCode = 'Goods Receipt'  
            THEN Cast(DebitCreditIndicator +'1' as INTEGER) * -1 * AmountInLocalCurrency
	        ELSE 0 END)
        AS AmountReceivedInLocalCurrency
       
    , Sum(CASE WHEN DPHT.PurchaseHistoryTypeStandardCode = 'Invoice Receipt'  
            THEN Cast(DebitCreditIndicator +'1' as INTEGER) * -1 *Quantity
	        ELSE 0 END)
        AS QuantityInvoiced
    , Sum(CASE WHEN DPHT.PurchaseHistoryTypeStandardCode = 'Invoice Receipt'  
            THEN Cast(DebitCreditIndicator +'1' as INTEGER) * -1 *AmountInLocalCurrency
	        ELSE 0 END)
        AS AmountInvoicedInLocalCurrency
    , Sum(CASE WHEN DPHT.PurchaseHistoryTypeStandardCode = 'Debit/Credit'  
            THEN Cast(DebitCreditIndicator +'1' as INTEGER) * -1 *Quantity
	        ELSE 0 END)
        AS QuantityDebited
    , Sum(CASE WHEN DPHT.PurchaseHistoryTypeStandardCode = 'Debit/Credit'  
            THEN Cast(DebitCreditIndicator +'1' as INTEGER) * -1 *AmountInLocalCurrency
	        ELSE 0 END)
        AS AmountDebitedInLocalCurrency
    , MAX(fctPH.SrcLastModifiedDate) AS SrcLastModifiedDate
FROM 
    SAP.FactPurchaseHistory AS fctPH 
    INNER JOIN SAP.factPurchaseOrders       AS fctPO ON fctPH.PurchaseDocumentNumber =fctPO.PurchaseDocumentNumber  
        AND fctPH.PurchaseDocumentItem = fctPO.PurchaseDocumentItem
        AND fctPH.DataSourceKey        = fctPO.DataSourceKey
    INNER JOIN SAP.DimSpecialStocks         AS DSS  ON fctPO.SpecialStocksKey = DSS.SpecialStocksKey
    INNER JOIN SAP.DimPurchaseHistoryTypes  AS DPHT ON DPHT.PurchaseHistoryTypeKey = FctPH.PurchaseHistoryTypeKey
WHERE 
    DSS.SpecialStocksStandardCode <> 'VConsigned' 
    AND DPHT.PurchaseHistoryTypeStandardCode IN 
        (
              'Goods Receipt'
            , 'Invoice Receipt' 
            , 'Debit/Credit'
        )
GROUP BY
      fctPH.PurchaseDocumentNumber
    , fctPH.PurchaseDocumentItem
    , fctPH.MaterialDocumentYear
    , fctPH.DataSourceKey
    , CASE WHEN IFNULL(fctPH.ReferenceDocumentNumber,'') = '' 
            Then fctPH.MaterialDocumentNumber
            Else fctPH.ReferenceDocumentNumber
        END
    , CASE WHEN IFNULL(fctPH.ReferenceDocumentItem,'') = '' OR ReferenceDocumentItem = 0 
            Then fctPH.MaterialDocumentItem
            Else fctPH.ReferenceDocumentItem
        END 
    , DPHT.PurchaseHistoryTypeStandardCode
    , fctPO.PurchaseDocumentTypeKey
    , fctPH.PlantKey 
    , fctPH.MaterialKey;