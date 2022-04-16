create or replace view V_FACTSATQUOTEHEADER(
	QUOTEID,
	QUOTEITEMNBR,
	QUOTENAME,
	DESCRIPTION,
	CREATEUSER,
	DATECREATED,
	DATEUPDATED,
	CORPORATIONNAME,
	NUMBEROFQUOTEITEMS
) as 
  SELECT 
      * 
  FROM 
    (
          SELECT 
              a.quoteid               quoteid, 
              b.quoteitemnbr          quoteitemnbr, 
              a.quotename             quotename, 
              a.description           description, 
              a.createuser            CREATEUSER, 
              a.createdts             datecreated, 
              a.updatedts             dateupdated, 
              c.corporationname       corporationname, 
              a1.numberofquoteitems   numberofquoteitems 
          FROM 
              conformed.scmdb_quoteheader a 
              INNER JOIN conformed.scmdb_quoteitem b ON a.quoteid = b.quoteid 
              INNER JOIN conformed.scmdb_corporation c ON b.customercorporationid = c.corporationid 
              LEFT OUTER JOIN 
              (
                  SELECT quoteid, 
                      count(quoteitemnbr) numberofquoteitems 
                  FROM 
                      conformed.scmdb_quoteitem 
                  GROUP BY quoteid
              ) a1 ON a1.quoteid = a.quoteid 
     ORDER BY a.quoteid ASC, b.quoteitemnbr ASC
  ) a;