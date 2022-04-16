create or replace view V_BW_HA_COSTCENTER_HIERDIM(
	COSTCENTERHIERARCHYID,
	COSTCENTERHIERARCHYNAME,
	ZLEVEL,
	DELETEFLAG,
	UPDATED_ON
) as
 /*-------------------------------------------------------------------------------------------------

This view is used to insert data into SAP.DimCostCenterHierarchy
-----------------------------------------------------------------------------------------------
Revision History
-----------------------------------------------------------------------------------------------
Date            Developer               Comments
----------------------------------------------------------------------------------------------
2021-06-15      Carlos Carrillo         Initial Revision
  */
SELECT DISTINCT
       nodename AS CostCenterHierarchyID
      ,ifnull(txtlg,'')    AS CostCenterHierarchyName
      ,ifnull(Zlevel,'') as Zlevel
      ,0        AS DeleteFlag
      ,FRMW_EXTRACTED_ON AS Updated_On
FROM
       CONFORMED.BW_HA_COSTCENTER_HIERDIM;