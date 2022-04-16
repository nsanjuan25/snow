create or replace view V_MRPSUMMARYBYMATERIAL(
	MRPCURRENTDATEKEY,
	PLANTKEY,
	DATASOURCEKEY,
	MATERIALKEY,
	ONHANDQUANTITY,
	ONORDERQUANTITY,
	DEMANDQUANTITY,
	DEMANDQUANTITY90DAYS
) as (
/*
Created date	: 2021-05-24
Created By		: Jayashri Salampuriya
Start Revision History            
-----------------------------------------------------------------------------------------------------------
Date			Developer           Revision Description
----------		--------------		-----------------------------------------------------------------------
20180507        Juan Cedeno         Initial Revision to get MRP Details
-----------------------------------------------------------------------------------------------------------
*/

 SELECT 
          CAST(MRP.MRPCurrentDateKey AS DATE) AS MRPCurrentDateKey
        , MRP.PlantKey
        , MRP.DataSourceKey
        , MRP.MaterialKey
	    , IFNULL( SUM(
                CASE WHEN MRPT.MRPTypeStandardCode IN   
                (    
                            'Inventory' 
                            , 'Stock in Outside Processing') THEN MRP.Quantity 
                    END  
            ), 0 )	AS OnHandQuantity

	    , IFNULL( SUM(
                CASE 
                    WHEN MRPT.MRPTypeStandardCode IN (
                    'Purchase Agreement', 'Purchase Order', 'Workorder'
                    ) THEN MRP.Quantity 
                    END  
            ) , 0 )	AS OnOrderQuantity

	    , IFNULL( SUM(
                CASE 
                    WHEN MRPT.MRPTypeStandardCode IN  
                                (
                                      'Allocation' 
                                    , 'Backflush Dependent Requirement'
                                    , 'Dependent Requirement'
                                    , 'Independent Requirement'
                                    , 'Interplant Transfer Order'
                                    , 'Safety Stock'   
                                    --, 'SubContractor Requirement'
                                    , 'Sales Agreement' 
                                    , 'Sales Order'                                                                     
                                ) OR 
                                ( MRPT.MRPTypeStandardCode = 'SubContractor Requirement'
                                  AND MRP.MRPPlanningSegment = '' ) THEN MRP.Quantity 
                    END  
            ) , 0 )	AS DemandQuantity
       
            , IFNULL( SUM(
                        CASE 
                            WHEN MRPT.MRPTypeStandardCode IN  
                                (
                                      'Allocation' 
                                    , 'Backflush Dependent Requirement'
                                    , 'Dependent Requirement'
                                    , 'Independent Requirement'
                                    , 'Interplant Transfer Order'
                                    , 'Safety Stock'   
                                    , 'SubContractor Requirement'
                                    , 'Sales Agreement' 
                                    , 'Sales Order'                                                                     
                                ) 
                            AND MRP.DeliveryFinishDateKey <= to_varchar(DATEADD( d, 91, GETDATE())) THEN MRP.Quantity 
                            END  
                    ) , 0 )	 AS DemandQuantity90Days
    FROM
	    sap.FactMRP						AS MRP
	    INNER JOIN sap.DimMRPTypes		AS MRPT ON MRP.MRPTypeKey = MRPT.MRPTypeKey
    WHERE 
        --Below filters are used to calculate Demand
        (
            MRPT.MRPTypeStandardCode IN 
            (
                  'Allocation'                                               -- Demand
                , 'Backflush Dependent Requirement'                          -- Demand
                , 'Dependent Requirement'                                    -- Demand
                , 'Independent Requirement'                                  -- Demand
                , 'Interplant Transfer Order'                                -- Demand
                , 'Safety Stock'                                             -- Demand
                , 'SubContractor Requirement'                                -- Demand
                , 'Purchase Agreement'                                       -- OnOrder
                , 'Purchase Order'                                           -- OnOrder
                , 'Workorder'                                                -- OnOrder
                , 'Inventory'                                                -- OnHand
                , 'Stock in Outside Processing'                              -- OnHand
            )                                                               
        )
        --OR 
        --(
        --    MRPT.MRPTypeStandardCode   = 'SubContractor Requirement'         -- Demand
        --   -- AND MRP.MRPPlanningSegment = ''                                  -- Demand
        --)
        OR 
        (
            MRPT.MRPTypeStandardCode IN 
            (
                  'Sales Agreement' 
                , 'Sales Order' 
            )                                                                -- Demand
            AND MRPT.ProcessingRule = 'Regular'                              -- Demand
        )
    GROUP BY 
          MRP.MaterialKey
        , MRP.PlantKey
        , MRP.DataSourceKey
        , MRPCurrentDateKey
);