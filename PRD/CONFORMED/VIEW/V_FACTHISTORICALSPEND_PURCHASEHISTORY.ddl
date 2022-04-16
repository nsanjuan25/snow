create or replace view V_FACTHISTORICALSPEND_PURCHASEHISTORY(
	PURCHASEDOCUMENTNUMBER,
	PURCHASEDOCUMENTITEM,
	DATASOURCEKEY,
	MATERIALDOCUMENTNUMBER,
	MATERIALDOCUMENTITEM,
	MATERIALDOCUMENTYEAR,
	AMLKEY,
	SUPPLIERKEY,
	SPECIALSTOCKSKEY,
	PURCHASINGORGANIZATIONCODE,
	PURCHASEDOCUMENTTYPEKEY,
	MANUFACTURERKEY,
	PLANTKEY,
	MATERIALKEY,
	QUANTITY,
	QUANTITYINVOICED,
	RECEIPTDATEKEY,
	CURRENCYCODE,
	DOCUMENTCURRENCYCODE,
	AMOUNTINDOCUMENTCURRENCY,
	AMOUNTINLOCALCURRENCY,
	EXCHANGERATEKEY,
	CONSIGNEDFLAG,
	INVOICEDFLAG,
	UNITCOSTINLOCALCURRENCY,
	SRCLASTMODIFIEDDATE,
	RECEIPTTYPE
) as
 /*-------------------------------------------------------------------------------------------------

This view is used to insert data into FactHistoricalSpend
-----------------------------------------------------------------------------------------------
Revision History
-----------------------------------------------------------------------------------------------
Date            Developer               Comments
----------------------------------------------------------------------------------------------
2021-03-29      Venkata             Initial Revision

*/
    SELECT
          PurchaseDocumentNumber
        , PurchaseDocumentItem
        , DataSourceKey
        , MaterialDocumentNumber
        , MaterialDocumentItem
        , MaterialDocumentYear
        , AMLKey
        , SupplierKey
        , SpecialStocksKey
        , PurchasingOrganizationCode
        , PurchaseDocumentTypeKey
        , ManufacturerKey
        , PlantKey
        , MaterialKey
        , QuantityReceived AS Quantity
        , QuantityInvoiced
        , ReceiptDateKey
        , LocalCurrencyCode AS CurrencyCode
        , DocumentCurrencyCode
        , AmountinDocumentCurrency
        , AmountInLocalCurrency
        , LocalCurrencyExchangeRateKey AS ExchangeRateKey
        , 0 as consignedflag
        , CASE WHEN QuantityInvoiced > 0 THEN 1 ELSE 0 END AS InvoicedFlag
        , CASE
                WHEN Quantity = 0 THEN 0
                WHEN QuantityInvoiced > 0 THEN ((AmountInvoiced + AmountDiscounted) / QuantityInvoiced)
           ELSE AmountInLocalCurrency / Quantity END
           AS UnitCostInLocalCurrency
        , SrcLastModifiedDate
        , ReceiptType
    FROM
        (
            SELECT
                  PurchaseDocumentNumber
                , PurchaseDocumentItem
                , DataSourceKey
                , MaterialDocumentNumber
                , MaterialDocumentItem
                , MaterialDocumentYear
                , AMLKey
                , SupplierKey
                , SpecialStocksKey
                , PurchasingOrganizationCode
                , PurchaseDocumentTypeKey
                , ManufacturerKey
                , PlantKey
                , MaterialKey
                , ReceiptDateKey
                , LocalCurrencyCode
                , DocumentCurrencyCode
                , LocalCurrencyExchangeRateKey
                , MIN( ReceiptType ) ReceiptType
                , SUM(Quantity) as Quantity
                , SUM (QuantityReceived ) AS QuantityReceived
                , SUM(AmountLclCurrency) as AmountInLocalCurrency
                , SUM(AmountDocumentCurrency) as AmountInDocumentCurrency
                , SUM (CASE WHEN AMTReceived  < 0 THEN 0 ELSE AMTReceived  END ) AS AmountRecd
                , SUM (CASE WHEN QTY_CALC_IR < 0 THEN 0 ELSE QTY_CALC_IR END)    AS QuantityInvoiced
                , SUM (CASE WHEN AMT_CALC_IR < 0 THEN 0 ELSE AMT_CALC_IR END)    AS AmountInvoiced
                , SUM (CASE WHEN QTY_CALC_CrDb>0 THEN 0 ELSE QTY_CALC_CrDb END)  AS QuantityDiscounted
                , SUM (CASE WHEN AMT_CALC_CrDb>0 THEN 0 ELSE AMT_CALC_CrDb END)  AS AmountDiscounted
                , MAX(SrcLastModifiedDate) AS SrcLastModifiedDate
            FROM
                (
                    SELECT
                          fctPH.PurchaseDocumentNumber
                        , fctPH.PurchaseDocumentItem
                        , fctPH.DataSourceKey
                        , fctPH.MaterialDocumentYear
                        , CASE WHEN IFNULL(fctPH.ReferenceDocumentNumber,'') = ''
                             Then fctPH.MaterialDocumentNumber
                             Else fctPH.ReferenceDocumentNumber
                          END AS MaterialDocumentNumber
                        , CASE WHEN IFNULL(fctPH.ReferenceDocumentItem,'') = '' OR fctPH.ReferenceDocumentItem = 0
                             THEN fctPH.MaterialDocumentItem
                             Else fctPH.ReferenceDocumentItem
                          END AS MaterialDocumentItem
                        , MAX( fctPH.AMLKey )                       AS AMLKey
                        , MAX( fctPO.SupplierKey  )                 AS SupplierKey
                        , MAX( FctPO.SpecialStocksKey )             AS SpecialStocksKey
                        , MAX( FctPO.PurchasingOrganizationCode )   AS PurchasingOrganizationCode
                        , MAX( fctPO.PurchaseDocumentTypeKey )      AS PurchaseDocumentTypeKey
                        , MAX( fctPO.ManufacturerKey )              AS ManufacturerKey
                        , MAX( fctPH.PlantKey )                     AS PlantKey
                        , MAX( fctPH.MaterialKey )                  AS MaterialKey
                        , MIN( fctPH.PostingDateKey )               AS ReceiptDateKey  
                        , MAX( fctPH.LocalCurrencyCode )            AS LocalCurrencyCode
                        , MAX( fctPH.DocumentCurrencyCode )         AS DocumentCurrencyCode
                        , MIN( fctPH.LocalCurrencyExchangeRateKey ) AS LocalCurrencyExchangeRateKey
                        , MIN ( CASE
                                WHEN upper( DPHT.PurchaseHistoryTypeStandardCode ) = 'GOODS RECEIPT'   THEN 1
                                WHEN upper( DPHT.PurchaseHistoryTypeStandardCode ) = 'INVOICE RECEIPT' THEN 2
                                WHEN upper( DPHT.PurchaseHistoryTypeStandardCode ) = 'DEBIT/CREDIT'    THEN 3
                            END ) AS ReceiptType

                        , SUM(CASE WHEN UPPER( DPHT.PurchaseHistoryTypeStandardCode ) = 'GOODS RECEIPT' OR  IFNULL(ReferenceDocumentNumber,'') = ''
                              THEN Cast(DebitCreditIndicator || '1' as int) * -1 *Quantity
                         ELSE 0 END)
                           AS Quantity
                        , SUM(CASE WHEN UPPER( DPHT.PurchaseHistoryTypeStandardCode ) = 'GOODS RECEIPT'  
                              THEN Cast(DebitCreditIndicator || '1' as int) * -1 *Quantity
                         ELSE 0 END)
                           AS QuantityReceived
                        , Sum(CASE WHEN UPPER( DPHT.PurchaseHistoryTypeStandardCode ) = 'GOODS RECEIPT' OR  IFNULL(ReferenceDocumentNumber,'') = ''
                              THEN Cast(DebitCreditIndicator || '1' as int) * -1 *AmountInLocalCurrency
                         ELSE 0 END)
                           AS AmountLclCurrency
                        , Sum(CASE WHEN UPPER( DPHT.PurchaseHistoryTypeStandardCode) = 'GOODS RECEIPT' OR  IFNULL(ReferenceDocumentNumber,'') = '' 
                              THEN Cast(DebitCreditIndicator || '1' as int) * -1 *AmountInDocumentCurrency
                         ELSE 0 END)
                           AS AmountDocumentCurrency -- added 3/19
                        , Sum(AmountInLocalCurrency) as TotalAmountInLocalCurrency
                        , Sum(CASE WHEN UPPER( DPHT.PurchaseHistoryTypeStandardCode ) = 'GOODS RECEIPT'  
                              THEN Cast(DebitCreditIndicator || '1' as int) * -1 * AmountInLocalCurrency
                         ELSE 0 END)
                           AS AMTReceived
                        , Sum(CASE WHEN UPPER( DPHT.PurchaseHistoryTypeStandardCode ) = 'INVOICE RECEIPT'
                              THEN Cast(DebitCreditIndicator || '1' as int) * -1 *Quantity
                         ELSE 0 END)
                           AS QTY_CALC_IR
                        , Sum(CASE WHEN UPPER( DPHT.PurchaseHistoryTypeStandardCode ) = 'INVOICE RECEIPT'
                              THEN Cast(DebitCreditIndicator || '1' as int) * -1 *AmountInLocalCurrency
                         ELSE 0 END)
                           AS AMT_CALC_IR
                        , Sum(CASE WHEN UPPER(DPHT.PurchaseHistoryTypeStandardCode) = 'DEBIT/CREDIT'
                              THEN Cast(DebitCreditIndicator || '1' as int) * -1 *Quantity
                         ELSE 0 END)
                           AS QTY_CALC_CrDb
                        , Sum(CASE WHEN UPPER( DPHT.PurchaseHistoryTypeStandardCode ) = 'DEBIT/CREDIT'
                              THEN Cast(DebitCreditIndicator || '1' as int) * -1 *AmountInLocalCurrency
                         ELSE 0 END)
                           AS AMT_CALC_CrDb
                        , MAX(fctPH.SrcLastModifiedDate) AS SrcLastModifiedDate
                    FROM 
                        SAP.FactPurchaseHistory fctPH
                        INNER JOIN SAP.factPurchaseOrders fctPO
                            ON  fctPH.PurchaseDocumentNumber = fctPO.PurchaseDocumentNumber  
                            AND fctPH.PurchaseDocumentItem   = fctPO.PurchaseDocumentItem
                            AND fctPH.DataSourceKey          = fctPO.DataSourceKey

                        INNER JOIN SAP.DimSpecialStocks DSS ON fctPO.SpecialStocksKey = DSS.SpecialStocksKey
                        INNER JOIN SAP.DimPurchaseHistoryTypes DPHT ON DPHT.PurchaseHistoryTypeKey = FctPH.PurchaseHistoryTypeKey
                    WHERE
                        UPPER( DSS.SpecialStocksStandardCode ) <> 'VCONSIGNED'
                        AND UPPER( DPHT.PurchaseHistoryTypeStandardCode ) IN
                            (
                                  'GOODS RECEIPT' 
                                , 'INVOICE RECEIPT'
                                , 'DEBIT/CREDIT'
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
                ) REMOVE_NEGATIVE_POSITIVE_VALUES
            GROUP BY
                  PurchaseDocumentNumber
                , PurchaseDocumentItem
                , DataSourceKey
                , MaterialDocumentYear
                , MaterialDocumentNumber
                , MaterialDocumentItem
                , AMLKey
                , SupplierKey
                , SpecialStocksKey
                , PurchasingOrganizationCode
                , PurchaseDocumentTypeKey
                , ManufacturerKey
                , PlantKey
                , MaterialKey
                , ReceiptDateKey
                , LocalCurrencyCode
                , DocumentCurrencyCode
                , LocalCurrencyExchangeRateKey
        ) FINAL_QUERY;