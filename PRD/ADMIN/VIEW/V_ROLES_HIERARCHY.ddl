create or replace view V_ROLES_HIERARCHY(
	HIERARCHY
) COMMENT='This view provides a the roles hierarchy structure'
 as 
  SELECT
      sys_connect_by_path(Obj, ' -> ') Hierarchy
  FROM 
      (
          SELECT 
              * 
          FROM 
              ADMIN.HIERARCHY_PROJECTED A
          WHERE 
              A.Parent LIKE '%(ROLE)%'
              AND A.Obj LIKE  '%(ROLE)%'
              AND A.privilege = 'USAGE'           

          UNION ALL 

          select 'START (ROLE)' , 'IAM_SFLK_P_ACCOUNTADM(ROLE)', 'USAGE', current_timestamp

      )c
      START WITH 
          PARENT = 'START (ROLE)'
      CONNECT BY 
          PARENT = PRIOR OBJ
  ORDER BY 
      Hierarchy;