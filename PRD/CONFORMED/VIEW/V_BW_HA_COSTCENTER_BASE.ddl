create or replace view V_BW_HA_COSTCENTER_BASE(
	PARENT,
	PARENTNAME,
	CHILD,
	CHILDNAME,
	ZLEVEL,
	HIERARCHY,
	UPDATE_ON,
	LEVEL_NUMBER
) as
 /*-------------------------------------------------------------------------------------------------

This view is used to insert data into SAP.DimCostCenterHierarchy
-----------------------------------------------------------------------------------------------
Revision History
-----------------------------------------------------------------------------------------------
Date            Developer               Comments
----------------------------------------------------------------------------------------------
2021-03-03      Carlos Carrillo         Initial Revision
  */
SELECT 
       b.Parent,
       COALESCE(bd.txtlg, b.Parent) ParentName,
       b.Child,
       bc.txtlg ChildName,
       b.zlevel,
       b.hierarchy,
       b.SNFLK_UPDATEDON AS UPDATE_ON,
       b.level_number
FROM 
    CONFORMED.BW_HA_COSTCENTER_HIERBRIDGE b
    LEFT OUTER JOIN CONFORMED.BW_HA_COSTCENTER_HIERDIM bd
        ON b.parent = bd.nodename
           AND bd.ZLevel <> 'CCTR'
    INNER JOIN CONFORMED.BW_HA_COSTCENTER_HIERDIM bc
        ON b.child = bc.nodename
           AND b.ZLevel = bc.ZLevel
WHERE
    b.Level_number > 0;