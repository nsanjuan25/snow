create or replace view V_FACTHISTORICALSPEND_CONSUMPTION(
	MOVEMENTDOCUMENTNUMBER,
	MOVEMENTDOCUMENTITEM,
	MOVEMENTYEAR,
	DATASOURCEKEY,
	MATERIALKEY,
	EXCHANGERATEKEY,
	CURRENCYCODE,
	SPENDFLAG,
	SUPPLIERKEY,
	INVOICERECONCILEDFLAG,
	PLANTKEY,
	POSTINGDATEKEY,
	COST,
	QUANTITY,
	CALCULATEDQUANTITY,
	SRCLASTMODIFIEDDATE,
	PURCHASEDOCUMENTNUMBER,
	PURCHASEDOCUMENTITEM,
	SUPPLIERCODE,
	ASSETNUMBER,
	ORDERNUMBER,
	COSTCENTER,
	WBSELEMENT
) as
 /*-------------------------------------------------------------------------------------------------

This view is used to insert data into FactConsumption
-----------------------------------------------------------------------------------------------
Revision History
-----------------------------------------------------------------------------------------------
Date            Developer               Comments
----------------------------------------------------------------------------------------------
2021-03-22      Venkata             Initial Revision

*/
SELECT
          B.MovementDocumentNumber
        , B.MovementDocumentItem
        , B.MovementYear
        , B.DataSourceKey
        , B.MaterialKey        
        , ExchangeRateKey
        , CurrencyCode
        , spendflag
        , SupplierKey
        , InvoiceReconciledFlag
        , PlantKey
        , PostingDateKey
        , ((MaterialCost / MatQuantity)) AS COST 
        , Quantity
        , CalculatedQuantity
        , SrcLastModifiedDate
        , PurchaseDocumentNumber
        , PurchaseDocumentItem
        , B.SupplierCode
        , B.AssetNumber
        , B.OrderNumber
        , B.CostCenter
        , B.WBSElement

    FROM
        (
            SELECT
                  BaseData.MovementDocumentNumber
                , BaseData.MovementDocumentItem
                , BaseData.MovementYear
                , BaseData.DataSourceKey
                , BaseData.MaterialKey
                , BaseData.ExchangeRateKey
                , BaseData.CurrencyCode
                , BaseData.SpendFlag
                , BaseData.InvoiceReconciledFlag
                , BaseData.SupplierKey
                , BaseData.PlantKey
                , BaseData.PostedDateKey as PostingDateKey
                , BaseData.Quantity
                , BaseData.MatCost AS MaterialCost
                , Sum(BaseData.Quantity)    
                 OVER (  PARTITION BY
                               BaseData.MaterialKey
                             , BaseData.SupplierKey
                             , BaseData.PostedDateKey
                             ORDER BY
                                BaseData.MovementDocumentNumber DESC
                               , BaseData.MovementDocumentItem DESC
                               , BaseData.SpendFlag DESC ) AS CalculatedQuantity
               , BaseData.MatQuantity
               , BaseData.SrcLastModifiedDate
               , BaseData.PurchaseDocumentNumber
               , BaseData.PurchaseDocumentItem
               , BaseData.SupplierCode
               , BaseData.AssetNumber
               , BaseData.OrderNumber
               , BaseData.CostCenter
               , BaseData.WBSElement
            FROM
                (
                    SELECT
                          Fct.MovementDocumentNumber
                        , Fct.MovementDocumentItem
                        , Fct.MovementYear
                        , Fct.DataSourceKey                        
                        , Fct.MaterialKey
                        , Fct.MovementTypeKey                        
                        , Fct.PostedDateKey
                        , Fct.SupplierKey
                        ,((FCT.DebitCreditIndicator)|| '1')*Quantity AS Quantity
                        , Fct.MaterialCost as MatCost
                        , Fct.Quantity as MatQuantity
                        , MT.SpendFlag
                       
                        , CASE
                           WHEN MT.SpendFlag = 2 THEN ( ((FCT.DebitCreditIndicator)|| '1')*Quantity )
                            ELSE -1*( ((FCT.DebitCreditIndicator)|| '1')*Quantity )  
                           END As CalcQty
                        , Fct.ExchangeRateKey
                        , Fct.CurrencyCode
                        , 0 as InvoiceReconciledFlag
                        , Fct.TransactionDateKey
                        , Fct.PlantKey
                        , Fct.SrcLastModifiedDate
                        , Fct.PurchaseDocumentNumber
                        , Fct.PurchaseDocumentItem
                        , DS.SupplierCode
                        , Fct.AssetNumber
                        , Fct.OrderNumber
                        , Fct.CostCenter
                        , Fct.WBSElement
                  
              

                    FROM
                        SAP.FactMovements AS Fct
                        left JOIN SAP.DimSpecialStocks DSS 
                            ON fct.SpecialStocksKey = DSS.SpecialStocksKey
                        INNER JOIN SAP.DimMovementTypes AS MT ON MT.MovementTypeKey = Fct.MovementTypeKey
                            AND MT.SpendFlag IN ( 1 , 2 )
                        INNER JOIN SAP.DimSuppliers AS DS ON fct.SupplierKey = DS.SupplierKey
                   WHERE
                      DSS.SpecialStocksStandardCode = 'VConsigned'
                      AND 
                  Quantity <> 0  
                ) BaseData
        ) B;