create or replace view V_SCMDB_CLASSNAME(
	CLASSID,
	CLASSNAME
) as
/*--------------------------------------------------------------------

This view is used to spend_analytics 
-----------------------------------------------------------------------
Revision History
-----------------------------------------------------------------------
Date            Developer               Comments
-----------------------------------------------------------------------
2021-02-26      Noel San Juan          Initial Revision
*/
SELECT DISTINCT 
    classid, 
    upper(classname) classname 
FROM 
    conformed.SCMDB_CLASS
ORDER BY 
    ClassId ASC, 
    ClassName ASC;