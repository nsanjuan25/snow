create or replace view V_BW_HA_PROFITCENTER_BASE(
	PARENT,
	PARENTNAME,
	CHILD,
	CHILDNAME,
	ZLEVEL,
	HIERARCHY,
	SNFLK_UPDATEDON,
	LEVEL_NUMBER
) as
 /*-------------------------------------------------------------------------------------------------

This view is used to insert data into SAP.DimProfitCenterHierarchy
-----------------------------------------------------------------------------------------------
Revision History
-----------------------------------------------------------------------------------------------
Date            Developer               Comments
----------------------------------------------------------------------------------------------
2021-02-18      Carlos Carrillo         Initial Revision
  */
SELECT B.Parent,
       iFnull(BD.txtlg, B.Parent) ParentName,
       B.Child,
       BC.txtlg ChildName,
       B.zlevel,
       B.hierarchy,
       B.SNFLK_UPDATEDON,
       B.level_number
FROM 
    CONFORMED.BW_HA_PROFITCENTER_HIERBRIDGE b
INNER JOIN 
    CONFORMED.BW_HA_PROFITCENTER_HIERDIM bc ON B.child = BC.nodename
LEFT OUTER JOIN 
    CONFORMED.BW_HA_PROFITCENTER_HIERDIM bd ON B.parent = BD.nodename
WHERE B.Level_number > 0;