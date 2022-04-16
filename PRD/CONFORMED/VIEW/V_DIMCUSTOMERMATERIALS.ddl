create or replace view V_DIMCUSTOMERMATERIALS(
	DATASOURCEKEY,
	CUSTOMERMATERIALCODE,
	MATERIALCODE,
	PLANTCODE,
	PRIORITY
) as
/*--------------------------------------------------------------------------------------------

This view is used to insert data into SAP.DimCustomerMaterials
----------------------------------------------------------------------------------------------
Revision History
----------------------------------------------------------------------------------------------
Date            Developer               Comments
----------------------------------------------------------------------------------------------
2021-02-19      Juan Cedeno             Initial Revision
*/                         
  SELECT 
        1 as DataSourceKey
      , CustomerMaterialCode
      , MaterialCode
      , PlantCode
      , Priority 
  FROM 
      conformed.v_ecc_ha_DimCustomerMaterials                        

    UNION ALL                         
                        
  SELECT 
        2 as DataSourceKey
      , CustomerMaterialCode
      , MaterialCode
      , PlantCode
      , Priority 
  FROM 
      conformed.v_hcc_ha_DimCustomerMaterials;