create or replace view V_ROLES_WAREHOUSES(
	PARENT,
	OBJ,
	PRIVILEGE,
	CREATEDON
) COMMENT='This view provides a the roles with access to Warehouses'
 as 
    SELECT 
        * 
    FROM 
        HIERARCHY_PROJECTED
    WHERE 
        OBJ LIKE '%(WAREHOUSE)%';