CREATE OR REPLACE PROCEDURE "SAVEQUERYHISTORY"()
RETURNS VARCHAR(10000)
LANGUAGE JAVASCRIPT
EXECUTE AS OWNER
AS ' 
  /*-------------------------------------------------------------------------------------------------
      This Stored procedure inserts data into conformed.tcurrTable
      -----------------------------------------------------------------------------------------------
      Revision History
      -----------------------------------------------------------------------------------------------
      Date            Developer               Comments
      -----------------------------------------------------------------------------------------------
      2020-10-01      Juan Cedeno             Initial Revision
  */

    var result = "Success";
    try {
                
                   
          var sql_command = " SELECT * FROM Admin.WarehouseQueryMonitor  ";         
          var statement1  = snowflake.createStatement( {sqlText: sql_command} );
          var result_set1 = statement1.execute();
          
          while ( result_set1.next() ) {
          
             var sql_command =  `CREATE OR REPLACE TRANSIENT TABLE PRD.Admin.tmpQueryHistory AS SELECT * FROM table(information_schema.QUERY_HISTORY_BY_WAREHOUSE(''` + result_set1.getColumnValue(1) +  `'', dateadd(''hours'',-26,current_timestamp()),current_timestamp()  , RESULT_LIMIT => 10000  ))  `;   
             snowflake.execute( { sqlText: sql_command } );   
             
          
          }
                         
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