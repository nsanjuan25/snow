create or replace view V_FACTMATERIALS(
	DATASOURCEKEY,
	MATERIALKEY,
	PLANNERKEY,
	BUYERKEY,
	MATERIALGROUPKEY,
	PLANTKEY,
	DELETEFLAG,
	PROFITCENTERCODE,
	CURRENCYCODE,
	PRICEUNIT,
	LOCALCURRENCYTOUSDEXCHANGERATE,
	STANDARDUNITCOSTP0,
	STANDARDUNITCOSTP0USD,
	STANDARDCOSTUSD,
	STANDARDUNITCOSTP1,
	STANDARDUNITCOSTP1USD,
	STANDARDCOSTP1USD,
	SELLUNITPRICEP0,
	SELLUNITPRICEP0USD,
	SELLPRICEUSD,
	SELLUNITPRICEP1,
	SELLUNITPRICEP1USD,
	SELLPRICEP1USD,
	CARRYINGCOSTRATE,
	LABORCOST,
	MATERIALCOST,
	SAFETYTIMEINDICATOR,
	SAFETYINSTOCK,
	FIXEDLOTSIZE,
	REORDERPOINTQTY,
	SAFETYLEADTIME,
	FIXEDLEADTIME,
	MULTIPLEQTY,
	SAFETYSTOCKQTY,
	MAXIMUMSTOCKQTY,
	MINIMUMLOTSIZE
) as (
     
/*
Created date	: 2021-05-24
Created By		: Jayashri Salampuriya
Start Revision History            
-----------------------------------------------------------------------------------------------------------
Date			Developer           Revision Description
----------		--------------		-----------------------------------------------------------------------
20180507        Juan Cedeno         Initial Revision to get Current Material Details
-----------------------------------------------------------------------------------------------------------
*/
    SELECT                       
          DM.DataSourceKey
        , DM.MaterialKey
        , DM.PlannerKey
        , DM.BuyerKey
        , DM.MaterialGroupKey    
        , DM.PlantKey  
        , DM.DeleteFlag     
        , DM.ProfitCenterCode            
        , DM.CurrencyCode
        , DM.PriceUnit
        , DM.LocalCurrencyToUSDExchangeRate
        , DM.StandardUnitCostP0
        , ( DM.StandardUnitCostP0 * DM.LocalCurrencyToUSDExchangeRate )                 AS StandardUnitCostP0USD
        , ((DM.StandardUnitCostP0 / DM.PriceUnit) * DM.LocalCurrencyToUSDExchangeRate)  AS StandardCostUSD
            
        , DM.StandardUnitCostP1
        , ( DM.StandardUnitCostP1 * DM.LocalCurrencyToUSDExchangeRate )                 AS StandardUnitCostP1USD
        , ( (DM.StandardUnitCostP1 / DM.PriceUnit) * DM.LocalCurrencyToUSDExchangeRate )AS StandardCostP1USD
    
        , DM.SellUnitPriceP0 
        , DM.SellUnitPriceP0 * DM.LocalCurrencyToUSDExchangeRate                        AS SellUnitPriceP0USD
        , ((DM.SellUnitPriceP0 / DM.PriceUnit) * DM.LocalCurrencyToUSDExchangeRate)     AS SellPriceUSD

        , DM.SellUnitPriceP1
        , DM.SellUnitPriceP1 * DM.LocalCurrencyToUSDExchangeRate                        AS SellUnitPriceP1USD
        , ((DM.SellUnitPriceP1 / DM.PriceUnit) * DM.LocalCurrencyToUSDExchangeRate)     AS SellPriceP1USD
            
        , 0 as CarryingCostRate
        , 0 as LaborCost 
        , 0 as MaterialCost             
        , DM.SafetyTimeIndicator
        , DM.SafetyInStock
        , DM.FixedLotSize
        , DM.ReOrderPointQty
        , DM.SafetyLeadTime
        , DM.FixedLeadTime
        , DM.MultipleQty
        , DM.SafetyStockQty
        , DM.MaximumStockQty
        , DM.MinimumLotSize 
    FROM 
        sap.DimMaterials AS DM
);