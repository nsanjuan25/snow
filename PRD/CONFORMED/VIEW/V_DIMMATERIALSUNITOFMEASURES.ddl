create or replace view V_DIMMATERIALSUNITOFMEASURES(
	MATERIALKEY,
	DATASOURCEKEY,
	MATERIALCODE,
	PLANTCODE,
	ALTERNATEUNITOFMEASUREDSCODE,
	ALTERNATETOBASECONVERSIONRATE,
	UOMROUNDINGDECIMAL,
	SNFLK_UPDATEDON
) as 
/*-------------------------------------------------------------------------------------------------

This view is used to insert data into Sap.DIMMATERIALSUNITOFMEASURES
-----------------------------------------------------------------------------------------------
Revision History
-----------------------------------------------------------------------------------------------
Date            Developer               Comments
----------------------------------------------------------------------------------------------
2021-03-09     SRIDHAR                 Initial Revision  
2021-08-27     Jagan                   Add JPS   
2021-09-22     Jagan                   Add JPS   
*/
    SELECT 
          M.MaterialKey
        , a.* 
    FROM
    (
        SELECT 
            * 
        FROM  
            CONFORMED.V_ECC_DimMaterialsUnitOfMeasures   

        UNION ALL 

        SELECT
            * 
        FROM  
            CONFORMED.V_HCC_DimMaterialsUnitOfMeasures

        UNION ALL 

        SELECT
            * 
        FROM  
            CONFORMED.V_JPS_DimMaterialsUnitOfMeasures

		UNION ALL 

        SELECT
            * 
        FROM  
            CONFORMED.V_PLA_DimMaterialsUnitOfMeasures
			
    ) a
    INNER JOIN sap.DimMaterials M  on a.MAterialCode = M.MAterialCode
    AND a.PlantCode = M.PlantCode;