create or replace view V_SCMDB_CAMPUSREGION(
	SITEID,
	REGIONCODE,
	REGIONNAME,
	CAMPUSCODE,
	CAMPUSNAME,
	SEQ
) as 
    SELECT
        * 
    FROM
        (
			 SELECT 
				  c.siteid
				, d.SiteGroupCode       AS Regioncode
				, d.description         AS Regionname
				, campus.SiteGroupCode  AS CampusCode
				, campus.description    AS CampusName
                , ROW_NUMBER() OVER (PARTITION BY campus.SiteGroupCode ORDER BY d.SiteGroupCode DESC) Seq     
                
			FROM 
				conformed.scmdb_SiteGroupToSite c 
				FULL OUTER JOIN conformed.scmdb_SiteGroup d ON c.SiteGroupID = d.SiteGroupID 
                FULL OUTER JOIN
                    (
                        SELECT 
                              a.siteid
                            , b.SiteGroupCode
                            , b.description 
                        FROM 
                            conformed.scmdb_sitegrouptosite a
                            FULL OUTER JOIN conformed.scmdb_SiteGroup b on a.SiteGroupID = b.SiteGroupID
                        WHERE 
                            UPPER(b.description ) like 'CAMPUS%' 
                    ) Campus ON c.siteid = campus.siteid 
			WHERE 
				UPPER(d.description) LIKE '%REGION%'          
        )  ;