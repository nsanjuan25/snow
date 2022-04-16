create or replace view V_FACTHISTORICALSPEND_MOVEMENTS(
	PURCHASEDOCUMENTNUMBER,
	PURCHASEDOCUMENTITEM,
	DATASOURCEKEY,
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
) as  SELECT      
      PurchaseHistory.PurchaseDocumentNumber
    , PurchaseHistory.PurchaseDocumentItem
    , PurchaseHistory.DataSourceKey
    , Consumption.MovementDocumentNumber    AS MaterialDocumentNumber
    , Consumption.MovementDocumentItem      AS MaterialDocumentItem
    , PurchaseHistory.AMLKEY
    , Consumption.SupplierKey
    , PurchaseHistory.SpecialStocksKey
    , Consumption.PlantKey
    , Consumption.MaterialKey
    , Consumption.Quantity                  AS Quantity
    , Consumption.Quantity                  AS QuantityInvoiced
    , Consumption.PostingDateKey            AS ReceiptDateKey
    , PurchaseHistory.PurchasingOrganizationCode
    , PurchaseHistory.PurchaseDocumentTypeKey
    , PurchaseHistory.ManufacturerKey
    , Consumption.CurrencyCode              AS CurrencyCode
    , Consumption.ExchangeRateKey           AS ExchangeRateKey
    , '0'                                   AS InvoicedFlag
    , '1'                                   AS ConsignedFlag
    , Consumption.Cost                      AS UnitCostInLocalCurrency
    , 1                                     AS PriorityFlag
    , HASH(IFNULL(CAST(PurchaseHistory.AMLKEY AS VARCHAR),'')
        ,IFNULL(CAST(Consumption.SupplierKey AS VARCHAR),'')
        , IFNULL(CAST(PurchaseHistory.SpecialStocksKey AS VARCHAR),'')
        , IFNULL(CAST(Consumption.PlantKey AS VARCHAR),'')
        , IFNULL(CAST(Consumption.MaterialKey AS VARCHAR),'')
        , IFNULL(CAST(Consumption.CalculatedQuantity AS VARCHAR),'')
        , IFNULL(CAST(Consumption.PostingDateKey AS VARCHAR),'')
        , IFNULL(CAST(Consumption.ExchangeRateKey AS VARCHAR),'')
        , IFNULL(CAST(Consumption.Cost AS VARCHAR),'')
        , IFNULL(Consumption.CurrencyCode,'')) AS HASH_VALUE
    , Consumption.SrcLastModifiedDate           AS SrcLastModifiedDate
FROM
    (
        SELECT 
              FctPO.PurchaseDocumentNumber
            , FctPO.PurchaseDocumentItem
            , FctPO.DataSourceKey
            , FctPO.MaterialKey
            , FctPO.AMLKey
            , FctPO.SupplierKey
            , FctPO.PurchasingOrganizationCode
            , FctPO.PurchaseDocumentTypeKey
            , FctPO.Manufacturerkey
            , FctPO.SpecialStocksKey
        FROM 
            SAP.FactPurchaseOrders FctPO
            INNER JOIN SAP.DimSpecialStocks AS DSS ON 
                FctPO.SpecialStocksKey            = DSS.SpecialStocksKey
                AND FctPO.DataSourceKey           = DSS.DataSourceKey
                AND DSS.SpecialStocksStandardCode = 'VConsigned'
                AND fctpo.DataSourceKey = 30 -- 
        WHERE 
            EXISTS 
            (

                SELECT 
                    NULL 
                FROM
                   SAP.FactPurchaseHistory fctPH
                WHERE                    
                    FctPO.PurchaseDocumentNumber    = FctPH.PurchaseDocumentNumber 
                    AND FctPO.PurchaseDocumentItem  = FctPH.PurchaseDocumentItem
                    AND TO_DATE(LEFT(postingdatekey,8)) >= dateadd(m,-37,TO_DATE(LEFT(postingdatekey,8))) 
                    AND DSS.DataSourceKey = 30
                    AND EXISTS 
                    (
                        SELECT 
                            NULL 
                        FROM 
                            SAP.DimMovementTypes AS DMT1 
                        WHERE 
                            fctPH.MovementTypeKey             = DMT1.MovementTypeKey
                            AND fctPH.DataSourceKey           = DMT1.DataSourceKey
                            AND DMT1.MovementTypeStandardCode = 'PO Receipt'                                                
                            AND DMT1.DataSourceKey = 30 
                    ) 
              )
    ) PurchaseHistory 
    INNER JOIN
    (
        SELECT 
              MaterialKey
            , DataSourceKey
            , MovementDocumentNumber
            , MovementDocumentItem
            , ExchangeRateKey
            , CurrencyCode
            , spendflag
            , SupplierKey
            , InvoiceReconciledFlag
            , PlantKey
            , PostingDateKey
            , TO_DECIMAL(MaterialCost / MatQuantity) AS COST
            , Quantity
            , CalculatedQuantity
            , SrcLastModifiedDate
            , PurchaseDocumentNumber 
            , PurchaseDocumentItem
        FROM (
            SELECT 
                  MaterialKey
                , DataSourceKey
                , MovementDocumentNumber
                , MovementDocumentItem
                , ExchangeRateKey
                , CurrencyCode
                , spendflag
                , InvoiceReconciledFlag
                , SupplierKey
                , PlantKey
                , PostedDatekey AS PostingDateKey
                , Quantity
                , MatCost       AS MaterialCost
                , SUM(Quantity) 
                        OVER (PARTITION BY 
                              MaterialKey
                            , SupplierKey 
                        ORDER BY 
                              movementdocumentnumber DESC 
                            , movementdocumentitem DESC
                            , spendflag DESC ) AS CalculatedQuantity
                , MatQuantity
                , SrcLastModifiedDate
                , PurchaseDocumentNumber 
                , PurchaseDocumentItem
            FROM 
                (
                    SELECT 
                          Fct.MaterialKey
                        , Fct.DataSourceKey
                        , Fct.MovementTypeKey
                        , Fct.MovementDocumentNumber
                        , Fct.MovementDocumentItem
                        , Fct.PostedDateKey
                        , Fct.SupplierKey
                        , ( CAST(Fct.DebitCreditIndicator + '1' as INTEGER) * Fct.Quantity ) as Quantity
                        , Fct.MaterialCost  AS MatCost
                        , Fct.Quantity      AS MatQuantity
                        , MT.SpendFlag
                        , CASE 
                            WHEN MT.SpendFlag = 2 THEN 
                                ( CAST(Fct.DebitCreditIndicator + '1' as INTEGER) * Fct.Quantity ) 
                            ELSE
                                 -1*( CAST(Fct.DebitCreditIndicator + '1' as INTEGER) * Fct.Quantity ) 
                           END  AS CalcQty
                        , Fct.ExchangeRateKey
                        , Fct.CurrencyCode
                        , 0     AS InvoiceReconciledFlag
                        , Fct.TransactionDateKey
                        , Fct.PlantKey
                        , Fct.SrcLastModifiedDate
                        , Fct.PurchaseDocumentNumber
                        , Fct.PurchaseDocumentItem
                FROM (
                    SELECT * 
                    FROM 
                        SAP.FactMovements 
                    WHERE 
                        SrcLastModifiedDate > 
                        (   SELECT IFNULL(max( SrcLastModifiedDate),'1900-01-01 00:00:00') 
                            FROM SAP.factHistoricalSpend WHERE consignedflag=1
                            AND FactHistoricalSpend.DataSourceKey = 30
                        ) 
                        AND SAP.FactMovements.DataSourceKey = 30
                ) Fct
                INNER JOIN SAP.DimSpecialStocks DSS ON 
                    fct.SpecialStocksKey  = DSS.SpecialStocksKey
                    AND fct.DataSourceKey = DSS.DataSourceKey

                INNER JOIN SAP.DimMovementTypes MT ON 
                    Fct.MovementTypeKey   = MT.MovementTypeKey
                    AND Fct.DataSourceKey = MT.DataSourceKey
                    AND MT.spendflag IN (1,2)            
            WHERE 
                DSS.SpecialStocksStandardCode = 'VConsigned' 
                AND Fct.Quantity <> 0 
                AND Fct.DataSourceKey = 30
      ) BaseData
    ) B 
   ) Consumption
    ON PurchaseHistory.PurchaseDocumentNumber   = Consumption.PurchaseDocumentNumber
       AND PurchaseHistory.PurchaseDocumentItem = Consumption.PurchaseDocumentItem
       AND PurchaseHistory.DataSourceKey        = Consumption.DataSourceKey;