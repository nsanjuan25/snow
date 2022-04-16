create or replace view V_FACTPLANNEDSPEND(
	DATASOURCEKEY,
	DOCUMENTNUMBER,
	DOCUMENTITEM,
	SCHEDULELINE,
	SCHEDULETYPEKEY,
	RECEIPTTYPEINDICATOR,
	PURCHASINGORGANIZATIONCODE,
	SUPPLIERKEY,
	AMLKEY,
	PLANTKEY,
	MATERIALKEY,
	MATERIALGROUPKEY,
	CANCELLATIONLEADTIME,
	DELIVERYDATEKEY,
	WEEKBEGINDATEKEY,
	MONTHBEGINDATEKEY,
	QUARTER,
	YEAR,
	QUANTITY,
	UNITCOSTINDOCUMENTCURRENCY,
	DOCUMENTCURRENCYCODE,
	EXCHANGERATEKEY,
	SPECIALSTOCKSKEY,
	PURCHASEDOCUMENTTYPEKEY,
	MANUFACTURERKEY,
	DELETEFLAG,
	CREATEDTS,
	UPDATEDTS,
	CREATEDBY,
	UPDATEDBY
) as 
        SELECT
			  A.DataSourceKey
			, A.DocumentNumber  
			, A.DocumentItem  
			, A.ScheduleLine  
			, A.PurchaseScheduleTypeKey As ScheduleTypeKey
			, A.ReceiptTypeIndicator  
			, A.PurchasingOrganizationCode  
			, IFNULL(A.SupplierKey,0)  AS SupplierKey
			, IFNULL(A.AmlKey,0)  AS AMLKey
			, IFNULL(A.PlantKey,0) AS PlantKey 
			, IFNULL(A.MaterialKey,0) AS MaterialKey
			, IFNULL(A.MAterialGroupKey,0)  AS MAterialGroupKey
			, MAX(A.CancellationLeadTime) CancellationLeadTime  
			, A.DeliveryDateKey  
			, IFNULL(A.WeekBeginDateKey ,0) AS WeekBeginDateKey
			, IFNULL(A.MonthBeginDateKey,0) AS MonthBeginDateKey
			, A.Quarter  
			, A.Year  
			, SUM(A.Quantity) Quantity  
			, IFNULL(AVG(A.UnitCostInDocumentCurrency),0) UnitCostInDocumentCurrency  
			, IFNULL(A.DocumentCurrencyCode,'')  as DocumentCurrencyCode
			, IFNULL(VCER.ExchangeRateKey, 0 ) AS  ExchangeRateKey 
			, IFNULL(A.SpecialStocksKey,0) AS SpecialStocksKey  
			, IFNULL(A.PurchaseDocumentTypeKey,0) AS PurchaseDocumentTypeKey
		    , IFNULL(DA.ManufacturerKey ,0) AS ManufacturerKey
			, A.DeleteFlag  
			, A.CreateDTS  
			, A.UpdateDTS
			, CURRENT_USER() CreatedBy
			, CURRENT_USER() UpdatedBy
		FROM                       
             (
                  SELECT DISTINCT  
						M.DataSourceKey ,  
						M.DocumentNumber,   
						M.DocumentItem,   
						M.DocumentScheduleLine AS ScheduleLine,   
						IFNULL( PST.PurchaseScheduleTypeKey , DPST.PurchaseScheduleTypeKey ) AS PurchaseScheduleTypeKey,   
						CASE    
						    WHEN upper(MT.MRPTypeStandardCode) IN ('PURCHASE ORDER','PURCHASE AGREEMENT') 
							THEN 'O'   
							ELSE 'U' END as ReceiptTypeIndicator,   
						IFNULL(PO.PurchasingOrganizationCode,  '') AS PurchasingOrganizationCode, 
						CASE --if supplier is empty o mrp then use the supplier on the po
                            WHEN M.SupplierKey = 0 THEN PO.SupplierKey
                            WHEN M.SupplierKey = 1 THEN PO.SupplierKey
                            ELSE M.SupplierKey
                        END AS SupplierKey, --S.SupplierKey,   		
        				CASE 
                            WHEN M.AmlKey  = 0 THEN PO.AMLKey
                            ELSE M.AMLKey
                         end as AMLKey ,   
						P.PlantKey,   
						PP.MaterialKey,   
					 	PP.MAterialGroupKey ,   
						IFNULL( PO.CancellationLeadtime, 0) AS CancellationLeadtime, 
						 M.DeliveryFinishDateKey  AS DeliveryDateKey,  
						null WeekBeginDateKey ,   
						null MonthBeginDateKey ,   
						DD.CalendarQuarterNumber Quarter,   
						DD.CalendarYear Year,   
						M.Quantity,  
                        (CASE
                            WHEN IFNULL(PO.UnitPriceBaseUOM,0) / (case when PO.PriceUnit = 0 then 1 else IFNULL(PO.PriceUnit,1) end)   = 0   THEN 
		                        CASE--It is Vendor Consigned   
		                            WHEN UPPER(SS.SpecialStocksStandardCode) = 'VCONSIGNED'  THEN 
                        				CASE --Check if PO DeliveryDTS falls into Current or Future Prices.  
				                            WHEN IFNULL(try_to_number(to_varchar(PPSI.UnitPriceFutureEffectiveFromDateKey,'YYYYMMDD')),0) <> 19000101  THEN 
						                        
                                                CASE  
						                            WHEN  M.DeliveryFinishDateKey  < PPSI.UnitPriceFutureEffectiveFromDateKey  
							                            THEN IFNULL(PPSI.UnitPriceCurrentBaseUOM,0)/(case when PPSI.PriceUnit=0 then 1 else IFNULL(PPSI.PriceUnit,1) end)  
						                        ELSE 
							                            IFNULL(PPSI.UnitPriceFutureBaseUOM,0)/(case when PPSI.PriceUnit=0 then 1 else IFNULL(PPSI.PriceUnit,1) end)
						                        END  
				                          ELSE --Unit Price Future Date was null set UnitPriceCurrent  
					                            IFNULL(PPSI.UnitPriceCurrentBaseUOM,0)/(case when PPSI.PriceUnit=0 then 1 else IFNULL(PPSI.PriceUnit,1) end)  
				                   END  		 
	                        
                        ELSE --It is Not Vendor Consigned   
			                CASE  
			                    WHEN UPPER( PDT.PurchaseDocumentTypeStandardCode ) = 'PURCHASE ORDER' -- NB (Standard POs) type POs  
				                    THEN IFNULL(PO.UnitPriceBaseUOM,0)/(case when PO.PriceUnit=0 then 1 else IFNULL(PO.PriceUnit,1) end) 
			                    
                                ELSE 
				                    CASE--Not Standard POs (Not NB)  
				                        WHEN UPPER( PDT.PurchaseDocumentTypeStandardCode ) = 'SCHEDULE AGREEMENT' -- SA (Schedule Agreement POs) type POs  
					                        THEN 
                                            CASE --Check if PO DeliveryDTS falls into Current or Future Prices.  
						                        WHEN IFNULL(try_to_number(to_varchar(PPSI.UnitPriceFutureEffectiveFromDateKey,'YYYYMMDD')),0) <> 19000101  
							                THEN
								                CASE  
								                    WHEN M.DeliveryFinishDateKey < PPSI.UnitPriceFutureEffectiveFromDateKey  
									                    THEN IFNULL(PPSI.UnitPriceCurrentBaseUOM,0)/(case when PPSI.PriceUnit=0 then 1 else IFNULL(PPSI.PriceUnit,1) end)  
								                ELSE        
									                IFNULL(PPSI.UnitPriceFutureBaseUOM,0)/(case when PPSI.PriceUnit=0 then 1 else IFNULL(PPSI.PriceUnit,1) end) 
						       		END  
						    ELSE --Unit Price Future Date was null set UnitPriceCurrent  
							    IFNULL(PPSI.UnitPriceCurrentBaseUOM,0)/(case when PPSI.PriceUnit=0 then 1 else IFNULL(PPSI.PriceUnit,1) end)
						    END  
					    --Non NB/SA, Non Standard/Schedule Agreements POs  
				    ELSE 
					CASE   
					    WHEN IFNULL(PPSI.UnitPriceCurrentBaseUOM,0) = 0   THEN 
							CASE ----Check if PO DeliveryDTS falls into P1 Price Effective Date.  
							WHEN try_to_number(to_varchar(PP.P1EffectiveFromDateKey,'YYYYMMDD')) <> 19000101--0
								THEN 
									CASE  
									WHEN  M.DeliveryFinishDateKey   < PP.P1EffectiveFromDateKey  
										THEN 
											IFNULL(PP.StandardUnitCostP0,0)/(case when PP.PriceUnit=0 then 1 else IFNULL(PP.PriceUnit,1) end)  
									ELSE 
										IFNULL(PP.StandardUnitCostP1,0)/(case when PP.PriceUnit=0 then 1 else IFNULL(PP.PriceUnit,1) end)
									END  
							ELSE --P1 Price Effective Date was null set StdUnitCostP0  
								IFNULL(PP.StandardUnitCostP0,0)/(case when PP.PriceUnit=0 then 1 else IFNULL(PP.PriceUnit,1) end) 
							END  
                          ELSE 
                              IFNULL(PPSI.UnitPriceCurrentBaseUOM,0)  
                          END  
                      END                                                      
                  END  
              END  
          --Unit Price was found in PO Line Items Info for any PO document type.  
            ELSE 
	            IFNULL(PO.UnitPriceBaseUOM,0)/(case when PO.PriceUnit=0 then 1 else IFNULL(PO.PriceUnit,1) end) 
            END
        ) UnitCostInDocumentCurrency,  
						   
          (
          CASE   
              WHEN IFNULL(PO.UnitPriceBaseUOM,0)/IFNULL(PO.PriceUnit,1) = 0   
              THEN 
                  CASE   
                      WHEN IFNULL(PPSI.UnitPriceCurrentBaseUOM,0) = 0   
                          THEN (
                                  P.LocalCurrencyCode
                                  )   
                      ELSE 
                          (
                                  CASE 
                                      WHEN PPSI.CurrencyCode =  ''
                                          THEN 'USD'
                                      ELSE IFNULL(PPSI.CurrencyCode, 'USD')
                                  END
                          )
                  END   
              ELSE 
                  (
                      CASE 
                          WHEN PO.CurrencyCode =''  
                              THEN 'USD'
                          ELSE IFNULL(PO.CurrencyCode, 'USD')
                      END
                  )
          END) DocumentCurrencyCode,
				PO.SpecialStocksKey,
				PO.PurchaseDocumentTypeKey,
				PO.ManufacturerKey , 
				0 DeleteFlag,
                (SELECT MAX(CreatedOn)  FROM SAP.FactMRP f where f.DataSourceKey =  M.DataSourceKey) CreateDTS,
                (SELECT MAX(CreatedOn)  FROM SAP.FactMRP f where f.DataSourceKey =  M.DataSourceKey) UpdateDTS
						 
			FROM 
				SAP.FactMRP M
				INNER JOIN SAP.DimMRPTypes MT ON M.MRPTypeKey = MT.MRPTypeKey
						AND UPPER( MT.MRPTypeStandardCode ) IN
							(
								  'PURCHASE ORDER'
								, 'PURCHASE AGREEMENT'
								, 'PLANNED ORDER'
								, 'PLANNED PURCHASE ORDER'
								, 'PURCHASE REQUISITION'
							)
                            AND M.DataSourceKey = MT.DataSourceKey
                LEFT OUTER JOIN SAP.DimPurchaseScheduleTypes DPST
                                ON DPST.PurchaseScheduleTypeCode =''    
                                and dpst.DATASOURCEKEY = m.dATASOURCEKEY                            
				INNER JOIN Public.DimDates DD  ON M.DeliveryFinishDateKey =  DD.DATEKEY 
                    
				LEFT JOIN SAP.DimMaterials PP ON PP.MaterialKey = M.MaterialKey
				    AND M.DataSourceKey = PP.DataSourceKey

                LEFT JOIN SAP.DimPlants P ON P.PlantKey = M.PlantKey
				    AND M.DataSourceKey = P.DataSourceKey

                LEFT JOIN SAP.FactPurchaseOrders PO ON PO.PurchaseDocumentNumber = M.DocumentNumber
					AND PO.PurchaseDocumentItem = M.DocumentItem
                    AND M.DataSourceKey = PO.DataSourceKey

				LEFT JOIN SAP.DimSpecialStocks SS ON PO.SpecialStocksKey = SS.SpecialStocksKey
                    AND M.DataSourceKey = SS.DataSourceKey

				LEFT JOIN SAP.DimPurchaseDocumentTypes PDT ON PDT.PurchaseDocumentTypeKey = PO.PurchaseDocumentTypeKey
					AND PDT.DataSourceKey = PO.DataSourceKey

				LEFT JOIN SAP.FactMaterialSourceInformation PPSI ON PPSI.MaterialSourceInformationReference = PO.NumberOfInformationRecord
						AND PPSI.MaterialKey = M.MaterialKey
						AND PPSI.DeleteFlag = 0
						AND PPSI.MaterialSourceTypeKey IN 
                            (   SELECT 
                                    IMST.MaterialSourceTypeKey 
                                FROM 
                                    SAP.DimMaterialSourceTypes IMST  
                                WHERE 
                                    IMST.MaterialSourceTypeCode = '2'
                                                                     
                            )

                            
				LEFT JOIN SAP.DimSuppliers S ON S.SupplierKey = PO.SupplierKey
                    AND M.DataSourceKey = S.DataSourceKey

				LEFT JOIN SAP.DimPurchaseScheduleTypes PST ON PST.DataSourceKey = PP.DataSourceKey
                    AND PST.MRPDocumentTypeCode = M.MRPDocumentTypeCode

			WHERE 
                 date(M.CREATEDON) = (SELECT date(MAX(CreatedOn )) FROM SAP.FactMRP f where f.DataSourceKey =  M.DataSourceKey)
    )A 
        LEFT OUTER JOIN SAP.DimAML AS DA ON DA.AMLKey = A.AMLKey
        LEFT  OUTER JOIN SAP.v_CurrentExchangeRate  AS  VCER  ON A.DocumentCurrencyCode = VCER.CurrencyCode
            AND VCER.DataSourceKey = A.DataSourceKey

		GROUP BY   
              A.DataSourceKey  
            , A.DocumentNumber  
            , A.DocumentItem  
            , A.ScheduleLine  
            , A.PurchaseScheduleTypeKey  
            , A.ReceiptTypeIndicator  
            , A.PurchasingOrganizationCode  
            , A.SupplierKey  
            , A.AmlKey  
            , A.PlantKey  
            , A.MaterialKey  
            , A.MaterialgroupKey  
            , A.DeliveryDateKey 
            , A.WeekBeginDateKey   
            , A.MonthBeginDateKey  
            , A.Quarter  
            , A.Year  
            , A.DocumentCurrencyCode 
			, VCER.ExchangeRateKey  
            , A.SpecialStocksKey
			, A.PurchaseDocumentTypeKey
			, DA.ManufacturerKey 
            , A.DeleteFlag  
            , A.CreateDTS  
            , A.UpdateDTS;