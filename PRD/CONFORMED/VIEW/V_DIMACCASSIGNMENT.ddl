create or replace view V_DIMACCASSIGNMENT(
	DATASOURCEKEY,
	CLIENT,
	PURCHASINGDOCUMENTNUMBER,
	ITEMNUMBER,
	SEQUENTIALNUMBER,
	QUANTITY,
	DISTRIBUTIONPERCENTAGE,
	GLACCOUNTNUMBER,
	COSTCENTER,
	ORDERNUMBER,
	MAINASSETNUMBER,
	ASSETSUBNUMBER,
	WBSELEMENT,
	PROFITCENTER,
	GLDESCRIPTION
) as 
/*-------------------------------------------------------------------------------------------------

This view is used to insert data into V_DimAccAssignment
-----------------------------------------------------------------------------------------------
Revision History
-----------------------------------------------------------------------------------------------
Date            Developer               Comments
----------------------------------------------------------------------------------------------
2021-03-09     SRIDHAR                 Initial Revision  
  */                                  
    select 
        DataSourceKey, 
        Client , 
        PURCHASINGDOCUMENTNUMBER , 
        ITEMNUMBER , 
        SequentialNumber , 
        Quantity , 
        DistributionPercentage , 
        GLAccountNumber , 
        CostCenter , 
        OrderNumber , 
        MainAssetNumber,                                  
        ASSETSUBNUMBER , 
        WBSElement , 
        ProfitCenter , 
        GLDescription  
    FROM 
        conformed.v_ecc_DimAccAssignment
 
 UNION ALL 

  SELECT 
      DataSourceKey, 
      Client , 
      PURCHASINGDOCUMENTNUMBER , 
      ITEMNUMBER , 
      SequentialNumber , 
      Quantity , 
      DistributionPercentage , 
      GLAccountNumber , 
      CostCenter , 
      OrderNumber ,
      MainAssetNumber,                                 
      ASSETSUBNUMBER , 
      WBSElement , 
      ProfitCenter , 
      GLDescription  
      FROM 
          conformed.v_hcc_DimAccAssignment;