create or replace view V_FACTPURCHASEHISTORY(
	ROW_ID,
	PURCHASEDOCUMENTNUMBER,
	PURCHASEDOCUMENTITEM,
	SEQUENCENUMBER,
	PURCHASEHISTORYTYPEKEY,
	PURCHASEHISTORYTYPECODE,
	MATERIALDOCUMENTNUMBER,
	MATERIALDOCUMENTITEM,
	DATASOURCEKEY,
	MOVEMENTTYPEKEY,
	POSTINGDATEKEY,
	MATERIALKEY,
	PLANTKEY,
	AMLKEY,
	MATERIALDOCUMENTYEAR,
	PURCHASEORDERHISTORYCATEGORY,
	QUANTITY,
	QUANTITY2,
	LOCALCURRENCYCODE,
	AMOUNTINLOCALCURRENCY,
	DOCUMENTCURRENCYCODE,
	AMOUNTINDOCUMENTCURRENCY,
	LOCALCURRENCYEXCHANGERATEKEY,
	DOCUMENTCURRENCYEXCHANGERATEKEY,
	DEBITCREDITINDICATOR,
	DELIVERYCOMPLETEFLAG,
	REFERENCEDOCUMENTNUMBER,
	REFERENCEDOCUMENTNUMBER2,
	REFERENCEDOCUMENTITEM,
	INVOICEVALUELOCALCURRENCY,
	INVOICEVALUEFOREIGNCURRENCY,
	SHIPPINGCOMPLIANCECODE,
	PURCHASEDOCUMENTENTRYDATE,
	SRCLASTMODIFIEDDATE,
	DSCREATEDTS,
	HASH_VALUE
) as 
SELECT 
		RemoveDups.Row_Id
      , RemoveDups.PurchaseDocumentNumber
      , RemoveDups.PurchaseDocumentItem
      , RemoveDups.SequenceNumber
      , RemoveDups.PurchaseHistoryTypeKey
      , RemoveDups.PurchaseHistoryTypeCode
      , RemoveDups.MaterialDocumentNumber
      , RemoveDups.MaterialDocumentItem
      , RemoveDups.DataSourceKey
      , RemoveDups.MovementTypeKey
      , RemoveDups.PostingDateKey
      , RemoveDups.MaterialKey
      , RemoveDups.PlantKey
      , RemoveDups.AMLKEy
      , RemoveDups.MaterialDocumentYear
      , RemoveDups.PurchaseOrderHistoryCategory
      , RemoveDups.Quantity
      , RemoveDups.Quantity2
      , RemoveDups.LocalCurrencyCode
      , RemoveDups.AmountInLocalCurrency
      , RemoveDups.DocumentCurrencyCode
      , RemoveDups.AmountInDocumentCurrency
      , RemoveDups.LocalCurrencyExchangeRateKey
      , RemoveDups.DocumentCurrencyExchangeRateKey
      , RemoveDups.DebitCreditIndicator
      , RemoveDups.DeliveryCompleteFlag
      , RemoveDups.ReferenceDocumentNumber
	  , RemoveDups.ReferenceDocumentNumber2
      , RemoveDups.ReferenceDocumentItem
      , RemoveDups.InvoiceValueLocalCurrency
      , RemoveDups.InvoiceValueForeignCurrency
      , RemoveDups.ShippingComplianceCode
      , RemoveDups.PurchaseDocumentEntryDate
      , RemoveDups.SrcLastModifiedDate
      , RemoveDups.DSCREATEDTS
      , RemoveDups.HASH_VALUE 
	FROM
	(
		SELECT 
		  row_number() over (Partition by EPH.PurchaseDocumentNumber,EPH.PurchaseDocumentItem,EPH.SeqNumberOfPurchaseDocument,EPH.PurchaseHistoryTypeCode,materialdocumentnumber,materialdocumentitem Order by IFNULL(AMLKey,0) Desc,DDER.rn,DLER.rn) as Row_Id
		, EPH.PurchaseDocumentNumber
		, cAST( EPH.PurchaseDocumentItem AS integer ) as PurchaseDocumentItem
        , ifnull(EPH.PurchaseHistoryTypeCode,'') as PurchaseHistoryTypeCode
		, cast( SeqNumberOfPurchaseDocument as integer) as SequenceNumber
		, IFNULL(DPHT.PurchaseHistoryTypeKey,0) AS PurchaseHistoryTypeKey
		, MaterialDocumentNumber as MaterialDocumentNumber
		, cast( MaterialDocumentItem as integer) as MaterialDocumentItem
		, EPH.DataSourceKey
		, IFNULL(DMT.MovementTypeKey,0) AS MovementTypeKey
		, POSTINGDTS  as PostingDateKey
		, IFNULL(DPP.MaterialKey,0) AS MaterialKey
		, IFNULL(DP.PlantKey,0) AS PlantKey
		, IFNULL(AML.AMLKey,0) AS AMLKEy
		, MaterialDocYear as MaterialDocumentYear
		, POHistoryCategory as PurchaseOrderHistoryCategory
		, EPH.Quantity1 AS Quantity
		, EPH.Quantity2 AS Quantity2
		, ifnull( EPH.LocalCurrencyCode , '' ) as LocalCurrencyCode
		, EPH.AmountInLocalCurrency
		, ifnull(DocumentCurrencyCode, '' ) as DocumentCurrencyCode
		, EPH.AmountInDocumentCurrency
		, IFNULL(DLER.ExchangeRateKey,0) as LocalCurrencyExchangeRateKey
		, IFNULL(DDER.ExchangeRateKey,0) as DocumentCurrencyExchangeRateKey
		, EPH.DebitCreditIndicator
		, IFNULL(DeliveryCompleteFlag, '' ) as DeliveryCompleteFlag
		, IFNULL(DocumentNumberOfAReferenceDocument, '') as ReferenceDocumentNumber
		, IFNULL(EPH.ReferenceDocumentNumber , '')		 AS ReferenceDocumentNumber2
		, EPH.ReferenceDocumentItem
		, InvoiceValueLocalCurr as InvoiceValueLocalCurrency
        , InvoiceValueForeignCurr as InvoiceValueForeignCurrency
		, IFNULL(ShippingComplianceCode , '')  as ShippingComplianceCode
        ,  EPH.AccountingDocEntryDate 
        , EPH.DSCREATEDTS
        , TO_TIMESTAMP_NTZ(  
            CASE 
                WHEN 
                    (CASE when EPH.AccountingDocEntryDate is null then 0 else 1 end) and (case when EPH.TimeOfEntry is null then 0 else  1 end) THEN 
                    TO_VARCHAR(to_date(EPH.AccountingDocEntryDate) || ' ' || substring(TimeOfEntry,1,2) || ':' || substring(TimeOfEntry,3,2) || ':' || substring(TimeOfEntry,5,2)) 
    	        ELSE TO_TIMESTAMP_NTZ( EPH.PostingDTS ) 
	          END 
            ) AS PurchaseDocumentEntryDate 
		, Updated_On as SrcLastModifiedDate
		,  HASH(IFNULL(TO_VARCHAR(DMT.MovementTypeKey),' ') 
             , IFNULL(POSTINGDTS,'1900-01-01') 
             , IFNULL(TO_VARCHAR(DPP.MaterialKey),' ')
			 , IFNULL(TO_VARCHAR(DP.PlantKey),' ') 
             , IFNULL(TO_VARCHAR(AMLKey),' ') 
             , IFNULL(POHistoryCategory,' ')
			 , IFNULL(TO_VARCHAR(Quantity1) ,' ') 
             , IFNULL(TO_VARCHAR(Quantity2),' ') 
             , IFNULL(EPH.LocalCurrencyCode,'UNK')
			 , IFNULL(TO_VARCHAR(AmountInLocalCurrency),' ') 
             , IFNULL(DocumentCurrencyCode,'UNK') 
             , IFNULL(TO_VARCHAR(AmountInDocumentCurrency),' ')
			 , IFNULL(TO_VARCHAR(DLER.ExchangeRateKey),' ') 
             , IFNULL(TO_VARCHAR(DDER.ExchangeRateKey),' ')
			 , IFNULL(EPH.DebitCreditIndicator,' ')
			 , IFNULL(DeliveryCompleteFlag,' ') 
             , IFNULL(DocumentNumberOfAReferenceDocument,' ') 
			 , IFNULL(EPH.ReferenceDocumentNumber,' ')
             , IFNULL(TO_VARCHAR(EPH.ReferenceDocumentItem),' ')
			 , IFNULL(TO_VARCHAR(InvoiceValueLocalCurr),' ') 
             , IFNULL(TO_VARCHAR(InvoiceValueForeignCurr),' ') 
             , IFNULL(ShippingComplianceCode,' ')
             , IFNULL(AccountingDocEntryDate, '1900-01-01' )
             , IFNULL(TimeOfEntry, ' ' )
	 )  AS HASH_VALUE
	 FROM  
		 CONFORMED.V_SAP_PURCHASEHISTORY  EPH         
		 LEFT OUTER JOIN SAP.DimPurchaseHistoryTypes AS DPHT ON DPHT.DataSourceKey = EPH.DataSourceKey
			AND ( LTRIM(RTRIM(EPH.PurchaseHistoryTypeCode)) = DPHT.PurchaseHistoryTypeCode) 
		 LEFT OUTER JOIN SAP.DimMovementTypes DMT ON DMT.DataSourceKey = EPH.DataSourceKey
			AND (LTRIM(RTRIM(EPH.MovementTypeCode)) = DMT.MovementTypeCode )
		 LEFT OUTER JOIN SAP.DimPlants DP ON DP.DataSourceKey = EPH.DataSourceKey
			AND (LTRIM(RTRIM(EPH.SiteCode)) = DP.PlantCode )
		 LEFT OUTER JOIN SAP.DimMaterials DPP ON EPH.DataSourceKey = DPP.DataSourceKey
			AND RTRIM(EPH.SitePartCode ) = DPP.MaterialCode
            AND DPP.PlantKey = DP.PlantKey
			AND DP.PlantCode = RTRIM(EPH.SiteCode) 
		 LEFT OUTER JOIN (
                SELECT 
                    * 
                FROM 
                    (
                        SELECT 
                              DI1.AMLKey
                            , DI1.AMLReference
                            , DI1.PlantKey
                            , DI1.EffectiveFromDateKey
                            , DI1.EffectivetoDateKey
                            , DI1.DataSourceKey
                            , row_number() 
                                OVER (PARTITION BY 
                                      DI1.AMLReference
                                    , DI1.PlantKey
                                    , DI1.EffectiveFromDateKey 
                                    , DI1.DataSourceKey
                                    ORDER BY 
                                         DI1.EffectivetoDateKey
                                        , DI1.AMLkey ) as rn 
                                 FROM 
                                    SAP.DimAML DI1 ) DIMAMLINTERNAL 
                              WHERE 
                                DIMAMLINTERNAL.rn = 1) AML  ON 
                LTRIM(RTRIM(EPH.AMLReference)) = AML.AMLReference 
                AND AML.PlantKey = DP.PlantKey 
                AND AML.EffectiveFromDateKey <= EPH.POSTINGDTS 
			    AND  AML.EffectiveToDateKey > EPH.POSTINGDTS
                AND AML.DataSourceKey = EPH.DataSourceKey
		 LEFT OUTER JOIN (
            SELECT 
                  DR1.ExchangeRateKey
                , DR1.CurrencyCode
                , DR1.ToCurrencyCode
                , DR1.EffectiveFromDateKey
                , DR1.DataSourceKey
                , ROW_NUMBER() 
                OVER (PARTITION BY 
                          DR1.CurrencyCode
                        , DR1.ToCurrencyCode 
                        , DR1.DataSourceKey
                    ORDER BY 
                          DR1.EffectiveFromDateKey DESC
                        , DR1.ExchangeRateKey DESC ) as rn 
              FROM 
                SAP.DimExchangeRates DR1
              ) DLER ON 
                DLER.CurrencyCode = LTRIM(RTRIM(EPH.LocalCurrencyCode)) 
                AND  DLER.ToCurrencyCode = 'USD' 
                AND DLER.EffectiveFromDateKey = EPH.POSTINGDTS
                AND DLER.DataSourceKey = EPH.DataSourceKey
		 LEFT OUTER JOIN (
            SELECT 
                  DRI2.ExchangeRateKey
                , DRI2.CurrencyCode
                , DRI2.ToCurrencyCode
                , DRI2.EffectiveFromDateKey
                , DRI2.DataSourceKey
                , ROW_NUMBER() 
                OVER (Partition by 
                      DRI2.CurrencyCode
                    , DRI2.ToCurrencyCode 
                    , DRI2.DataSourceKey
                 ORDER BY 
                          DRI2.EffectiveFromDateKey DESC
                        , DRI2.ExchangeRateKey DESC ) as rn 
                FROM 
                    SAP.DimExchangeRates DRI2 ) DDER ON 
                    DDER.CurrencyCode = LTRIM(RTRIM(EPH.DocumentCurrencyCode)) 
                    AND  DDER.ToCurrencyCode = 'USD' 
                    AND DDER.EffectiveFromDateKey = EPH.POSTINGDTS
                    AND DDER.DataSourceKey = EPH.DataSourceKey
					) RemoveDups
	 WHERE 
		RemoveDups.Row_Id = 1;