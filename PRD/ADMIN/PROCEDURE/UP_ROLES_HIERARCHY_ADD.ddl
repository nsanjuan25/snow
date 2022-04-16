CREATE OR REPLACE PROCEDURE "UP_ROLES_HIERARCHY_ADD"()
RETURNS VARCHAR(100)
LANGUAGE JAVASCRIPT
COMMENT='This procedure builds the Security hierarchy roles into table HIERARCHY_PROJECTED '
EXECUTE AS CALLER
AS ' 
  /*-------------------------------------------------------------------------------------------------
      This Stored procedure inserts data into conformed.tcurrTable
      -----------------------------------------------------------------------------------------------
      Revision History
      -----------------------------------------------------------------------------------------------
      Date            Developer               Comments
      -----------------------------------------------------------------------------------------------
      2020-12-01      Juan Cedeno             Initial Revision
  */

    var result = "Success";
    try {
                

              var sql_command = `
                  CREATE OR REPLACE TRANSIENT TABLE GRANT_TO_ROLES_RS_CACHED 
                  as
                  SELECT 
                        *
                      , CURRENT_TIMESTAMP AS CreatedOn
                  FROM 
                      SNOWFLAKE.ACCOUNT_USAGE.GRANTS_TO_ROLES
                  WHERE 
                      GRANTED_TO in (''ROLE'',''DATABASE'',''SCHEMA'',''WAREHOUSE'') 
                      AND DELETED_ON IS NULL ;
          `;

           snowflake.execute( { sqlText: sql_command } );       


              var sql_command = `
                  CREATE OR REPLACE TRANSIENT TABLE HIERARCHY_PROJECTED 
                  AS 
                      SELECT 
                        * 
                        , CURRENT_TIMESTAMP AS CreatedOn
                      FROM
                      (
                          WITH BASE AS(
                              SELECT 
                                    PRIVILEGE 
                                  , GRANTED_ON 
                                  , NAME
                                  , TABLE_CATALOG 
                                  , TABLE_SCHEMA 
                                  , GRANTED_TO
                                  , GRANTEE_NAME 
                              FROM 
                                  GRANT_TO_ROLES_RS_CACHED
                              WHERE 
                                  GRANTED_ON IN (''ACCOUNT'',''ROLE'',''WAREHOUSE'' ,''DATABASE'',''SCHEMA'')
                      ),PROJ 
                     AS
                     (
                          SELECT
                                CONCAT(GRANTEE_NAME ,''('',GRANTED_TO,'')'') PARENT
                              , CONCAT( IFF( TABLE_CATALOG IS NOT NULL,TABLE_CATALOG||''.'','''' )      ,IFF( TABLE_SCHEMA IS NOT NULL  , TABLE_SCHEMA || ''.'' , '''' )
                              , NAME
                              ,''('' ,GRANTED_ON ,'')'') AS OBJ
                              , PRIVILEGE
                          FROM 
                              BASE
                          ORDER BY 
                              PARENT
                      )
                SELECT 
                    * 
                FROM
                    PROJ
                UNION
                SELECT NULL PARENT ,''ACCOUNTADMIN(ROLE)'' OBJ ,NULL PRIVILEGE
                );    

          `;

           snowflake.execute( { sqlText: sql_command } );  
                     
                         
    }
    catch (err)  {
        result = "Failed: " + err; 
        
        snowflake.execute({sqlText: 
            `insert into admin.error_log(procedurename , error_code , error_state, error_message , stack_trace)  VALUES (?, ?, ?, ?, ?)`
            ,binds: [arguments.callee.name, err.code, err.state, err.message, err.stackTraceTxt]
        });
        
    }
        
    return result;
                        
';