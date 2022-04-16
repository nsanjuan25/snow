create or replace view V_FACTHISTORICALSPEND_MOVEMENTSUPDNULLWOQTY(
	PURCHASEDOCUMENTNUMBER,
	PURCHASEDOCUMENTITEM,
	MATERIALDOCUMENTNUMBER,
	MATERIALDOCUMENTITEM,
	AMLKEY,
	SUPPLIERKEY,
	SPECIALSTOCKSKEY,
	PLANTKEY,
	MATERIALKEY,
	QUANTITY,
	QUANTITYINVOICED,
	RECEIPTDATEKEY,
	PURCHASINGORGANIZATIONCODE,
	PURCHASEDOCUMENTTYPEKEY,
	MANUFACTURERKEY,
	CURRENCYCODE,
	EXCHANGERATEKEY,
	INVOICEDFLAG,
	CONSIGNEDFLAG,
	UNITCOSTINLOCALCURRENCY,
	PRIORITYFLAG,
	HASH_VALUE,
	SRCLASTMODIFIEDDATE
) as SELECT 
         
        PurchaseHistory.PurchaseDocumentNumber
        , PurchaseHistory.PurchaseDocumentItem
        , Consumption.MaterialDocumentNumber
        , Consumption.MaterialDocumentItem
        , PurchaseHistory.AMLKEY
        , Consumption.SupplierKey
        , PurchaseHistory.SpecialStocksKey
        , Consumption.PlantKey
        , Consumption.MaterialKey
        , Consumption.Quantity
        , Consumption.QuantityInvoiced
        , Consumption.ReceiptDateKey
        , PurchaseHistory.PurchasingOrganizationCode
        , PurchaseHistory.PurchaseDocumentTypeKey
        , PurchaseHistory.ManufacturerKey
        , Consumption.CurrencyCode
        , Consumption.ExchangeRateKey
        , '0' AS InvoicedFlag
        , '1' AS ConsignedFlag
        , Consumption.UnitCostInLocalCurrency
        , 2 AS PriorityFlag
        , HASH(IFNULL(CAST(Consumption.SupplierKey AS VARCHAR),'')
           ,IFNULL(CAST(PurchaseHistory.SpecialStocksKey AS VARCHAR),'')
           ,IFNULL(CAST(Consumption.PlantKey AS VARCHAR),'')
           ,IFNULL(CAST(Consumption.MaterialKey AS VARCHAR),'')
           ,IFNULL(CAST(Consumption.Quantity AS VARCHAR),'')
           ,IFNULL(CAST(Consumption.ReceiptDateKey AS VARCHAR),'')
           ,IFNULL(CAST(Consumption.ExchangeRateKey AS VARCHAR),'')
           ,IFNULL(CAST(Consumption.UnitCostInLocalCurrency AS VARCHAR),'')
           ,IFNULL(Consumption.CurrencyCode,'')) as HASH_VALUE
        , Consumption.SrcLastModifiedDate As SrcLastModifiedDate
 FROM
    (
        SELECT DISTINCT 
             FctPH.PurchaseDocumentNumber
            , FctPH.PurchaseDocumentItem
            , FctPH.DataSourceKey
            , FctPH.MaterialDocumentNumber
            , FctPH.MaterialDocumentItem
            , FctPH.PostingdateKey
            , FctPH.MaterialKey
            , FctPH.PlantKey
            , FctPH.AMLKey
            , FctPH.DocumentCurrencyExchangeRateKey
            , FctPH.AmountInDocumentCurrency
            , FctPH.Quantity
            , FctPO.SupplierKey
            , FctPO.PurchasingOrganizationCode
            , FctPO.PurchaseDocumentTypeKey
            , FctPO.ManufacturerKey
            , FctPO.SpecialStocksKey
           
        FROM 
             SAP.FactPurchaseHistory FctPH 
             INNER JOIN SAP.factPurchaseOrders FctPO
                ON (FctPO.PurchaseDocumentNumber = FctPH.PurchaseDocumentNumber AND 
                FctPO.PurchaseDocumentItem = FctPH.PurchaseDocumentItem) 
                AND FctPO.DataSourceKey = FctPH.DataSourceKey

             INNER JOIN (Select SpecialStocksKey from SAP.DimSpecialStocks where SpecialStocksStandardCode = 'VConsigned' 
                AND DimSpecialStocks.DataSourceKey = 30
             ) DSS
                ON (FctPO.SpecialStocksKey = DSS.SpecialStocksKey) 
                AND DSS.SpecialStocksKey = FctPO.SpecialStocksKey
        WHERE MovementTypeKey in 
            (
                SELECT Distinct MovementTypeKey from SAP.dimmovementtypes 
                WHERE MovementTypeStandardCode = 'PO Receipt'
                AND DimMovementTypes.DataSourceKey = 30
            )
            AND TO_DATE(LEFT(postingdatekey,8)) >= dateadd(m,-12,TO_DATE(LEFT(postingdatekey,8)))
        ) PurchaseHistory 
        INNER JOIN
        (
            SELECT 
             
                 FactHistoricalSpend.DataSourceKey
                , MaterialDocumentNumber
                , MaterialDocumentItem
                , SupplierKey
                , PlantKey
                , MaterialKey
                , Quantity
                , QuantityInvoiced
                , ReceiptDateKey
                , CurrencyCode
                , ExchangeRateKey
                , UnitCostInLocalCurrency
                , SrclastModifiedDate
            FROM
                SAP.FactHistoricalSpend
            WHERE 
                Purchasedocumentnumber IS NULL  
                AND consignedflag = '1'
                AND FactHistoricalSpend.DataSourceKey = 30
                ) Consumption
            ON ( PurchaseHistory.SupplierKey = Consumption.supplierkey
             AND PurchaseHistory.MaterialKey = Consumption.MaterialKey
             AND Consumption.DataSourceKey = PurchaseHistory.DataSourceKey
             AND Consumption.DataSourceKey = 30
        );