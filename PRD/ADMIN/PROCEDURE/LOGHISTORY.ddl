CREATE OR REPLACE PROCEDURE "LOGHISTORY"("VARACTION" VARCHAR(16777216), "VARSTEP" VARCHAR(16777216))
RETURNS VARCHAR(100)
LANGUAGE JAVASCRIPT
EXECUTE AS CALLER
AS '
    try {
        return "Success";
            var strProcedureName = "''" + VARSTEP + "''";
                        
            if ( VARACTION.toUpperCase() == ''A'')
            {
                
                var sql_command = `
                    INSERT INTO Admin.ELT_History
                    (
                          ProcedureName
                        , StartDate    
                    )
                    VALUES
                    (
                        ` + strProcedureName + `
                      , CAST( CURRENT_TIMESTAMP()  as datetime )
                    ) `;
                      
                  snowflake.execute( { sqlText: sql_command } );       
            }

            if ( VARACTION.toUpperCase() == ''M'')
            {
                 var sql_command = `
                   UPDATE 
                        Admin.ELT_History
                   SET
                          ENDDATE =  CAST( CURRENT_TIMESTAMP()  as datetime )
                   WHERE
                       Admin.ELT_History.ELT_HistoryKey =
                       (
                            SELECT 
                                MAX( A.ELT_HistoryKey )
                            FROM 
                                Admin.ELT_History A
                            WHERE
                                ProcedureName =  ` + strProcedureName + `
                       ) ; `;
                 
                         
                 var sql_command = `
                   UPDATE 
                        Admin.ELT_History
                   SET
                         ENDDATE =  CAST( CURRENT_TIMESTAMP()  as datetime )
                        , RowsInserted = ts.$1
                        , RowsUpdated  = ts.$2
                   FROM 
                        TABLE(RESULT_SCAN(LAST_QUERY_ID())) ts
                   WHERE
                       ROWKEY =
                       (
                            SELECT 
                                coalesce(MAX( B.ELT_HistoryKey ),0)
                            FROM 
                                Admin.ELT_History B
                            WHERE
                                ProcedureName =  ` + strProcedureName + `
                       ) ;
               `;                         
                    snowflake.execute( { sqlText: sql_command } );  
               
             }            
                         
            if ( VARACTION.toUpperCase() == ''I'')
            {
                 var sql_command = `
                   UPDATE 
                        Admin.ELT_History
                   SET
                         ENDDATE =  CAST( CURRENT_TIMESTAMP()  as datetime )
                   WHERE
                       Admin.ELT_History.ELT_HistoryKey =
                       (
                            SELECT 
                                coalesce(MAX( B.ELT_HistoryKey ),0)
                            FROM 
                                Admin.ELT_History B
                            WHERE
                                ProcedureName =  ` + strProcedureName + `
                       ) ;
               `;         
                         
                    var rs = snowflake.execute( { sqlText: sql_command } );  
               
             }                                     
                
        //return sql_command;                                           
        return "Success";                                           
    }
    catch (err)  {
        
        snowflake.execute({sqlText: 
            `insert into admin.error_log(procedurename , error_code , error_state, error_message , stack_trace)  VALUES (?, ?, ?, ?, ?)`
            ,binds: [arguments.callee.name, err.code, err.state, err.message, err.stackTraceTxt]
        });
                                 
        return "Failed: " + err; 
    }                      
';