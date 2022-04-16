create or replace view V_MATERIALSUMMARY(
	MATERIALKEY,
	ONHANDQTY,
	ONORDERQTY,
	REQUIREDQTY,
	DEMANDQTY
) as
/* 
Description		: 
Created date	: 2018-11-08
Created By		: Rene Dil

Start Revision History            
-----------------------------------------------------------------------------------------------
Date			Developer           Revision Description
----------		--------------		-----------------------------------------------------------
2018-??-??		Juan Cedeno			Initial Version
2018-11-09		Rene Dil			Added Purchase Requistion Qty
-----------------------------------------------------------------------------------------------
End   Revision   History
*/
SELECT 
	MRP.MaterialKey
	, IFNULL( SUM(
		CASE 
			WHEN MRPT.MRPTypeStandardCode IN   (    
				'Inventory' 
				, 'Stock in Outside Processing'
				) THEN MRP.Quantity 
		END  
        ), 0 )						AS OnHandQty

	, IFNULL( SUM(
		CASE 
			WHEN MRPT.MRPTypeStandardCode IN (
				'Purchase Agreement'
				, 'Purchase Order'
				, 'Workorder'
                ) THEN MRP.Quantity 
		END  
        ) , 0 )						AS OnOrderQty

	, IFNULL( SUM(
		CASE 
			WHEN MRPT.MRPTypeStandardCode IN (
				'Purchase Requisition'
                ) THEN MRP.Quantity 
		END  
        ) , 0 )						AS RequiredQty

	, IFNULL( SUM(
		CASE 
			WHEN MRPT.MRPTypeStandardCode IN  (
				'Dependent Requirement'
				, 'Independent Requirement'
				, 'Safety Stock'
				, 'SubContractor Requirement'
				, 'Backflush Dependent Requirement'
				, 'Allocation'
				, 'Interplant Transfer Order'
				) THEN MRP.Quantity 
		END  
        ) , 0 )						AS DemandQty
FROM
	SAP.FactMRP						AS MRP
	INNER JOIN SAP.DimMRPTypes		AS MRPT ON MRP.MRPTypeKey = MRPT.MRPTypeKey
WHERE 
    MRPT.MRPTypeStandardCode IN 
    (
          'Dependent Requirement'
        , 'Independent Requirement'
        , 'Safety Stock'
        , 'SubContractor Requirement'
        , 'Backflush Dependent Requirement'
        , 'Allocation'
        , 'Interplant Transfer Order'
        , 'Purchase Agreement'
        , 'Purchase Order'
		, 'Purchase Requisition'
        , 'Workorder'
        , 'Inventory'
        , 'Stock in Outside Processing'
    )
GROUP BY 
    MRP.MaterialKey;