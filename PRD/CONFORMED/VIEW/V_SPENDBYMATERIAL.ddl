create or replace view V_SPENDBYMATERIAL(
	MATERIALKEY,
	RECEIPTDATEKEY,
	SPENDQUANTITY,
	SPENDAMOUNTINUSD
) as 
/*
Created date	: 2021-05-24
Created By		: Jayashri Salampuriya


*/
    SELECT 
          FHS.MaterialKey
        , FHS.ReceiptDateKey
        , SUM(FHS.Quantity) AS SpendQuantity
        , SUM( FHS.UnitCostInLocalCurrency * DER.ExchangeRate ) AS SpendAmountInUSD
    FROM
        sap.FactHistoricalSpend AS FHS
        INNER JOIN sap.DimExchangeRates AS DER ON FHS.ReceiptDateKey = DER.EffectiveFromDateKey
            AND FHS.CurrencyCode = DER.CurrencyCode
            AND DER.ToCurrencyCode = 'USD'
            AND FHS.DataSourceKey = DER.DataSourceKey
    GROUP BY    
          FHS.MaterialKey
        , FHS.ReceiptDateKey;