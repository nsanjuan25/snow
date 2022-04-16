create or replace view V_FACTHISTORICALSPEND_MOVEMENTSUPDNULL(
	DATASOURCEKEY,
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
     
        Consumption.DataSourceKey
        , PurchaseHistory.PurchaseDocumentNumber
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
            , IFNULL(CAST(Consumption.PlantKey AS VARCHAR),'')
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
            , FctPH.DataSourceKey
            , FctPH.PurchaseDocumentItem
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
                ON FctPO.PurchaseDocumentNumber = FctPH.PurchaseDocumentNumber 
                AND FctPO.PurchaseDocumentItem = FctPH.PurchaseDocumentItem
                AND fctpo.DataSourceKey = FctPH.DataSourceKey

            INNER JOIN (
                        SELECT SpecialStocksKey 
                        ,DimSpecialStocks.DataSourceKey
                        FROM SAP.DimSpecialStocks 
                        WHERE SpecialStocksStandardCode = 'VConsigned' 
                        AND DimSpecialStocks.DataSourceKey = 30
                        ) DSS
                ON FctPO.SpecialStocksKey = DSS.SpecialStocksKey
                AND DSS.SpecialStocksKey = FctPO.SpecialStocksKey
        WHERE 
            MovementTypeKey IN 
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
            DataSourceKey
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
            Purchasedocumentnumber is null  
            AND consignedflag = '1'
            AND DataSourceKey  = 30 
            ) Consumption 
        ON (  PurchaseHistory.MaterialKey = Consumption.MaterialKey
        AND Consumption.DataSourceKey = PurchaseHistory.DataSourceKey
    );