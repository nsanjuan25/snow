CREATE OR REPLACE PROCEDURE "ERROR_LOG_ADD"("PROCNAME" VARCHAR(16777216), "PROCCODE" VARCHAR(16777216), "PROCSTATE" VARCHAR(16777216), "PROCMESSAGE" VARCHAR(16777216), "PROCSTACK" VARCHAR(16777216), "EMAILID" VARCHAR(16777216))
RETURNS VARCHAR(100)
LANGUAGE JAVASCRIPT
EXECUTE AS OWNER
AS ' 
	try {
				


        snowflake.execute({sqlText:
            `insert into admin.error_log(procedurename , error_code , error_state, error_message , stack_trace)  VALUES (?, ?, ?, ?, ?)`
            ,binds: [PROCNAME , PROCCODE, PROCSTATE, PROCMESSAGE, PROCSTACK]
        });


        //Get Email Addresess 
        
        var sql_command = `SELECT * FROM ADMIN.Error_Log_Mails WHERE EMAILID = ''` + EMAILID + `'' ;  `;
        var statement1 = snowflake.createStatement( {sqlText: sql_command} );
        var result_set1 = statement1.execute();
        result_set1.next()
        
        var sql_command = `    
              select  public.sendNotification
              (
                  ''` +  result_set1.getColumnValue(1) + `'' 
                , ''` +  result_set1.getColumnValue(2) + `'' 
                , ''SNOWFLAKE ` +  result_set1.getColumnValue(3) + ` -- Error Procedure  - [` + PROCNAME+ `] ''
                , ''Procedure failed [` + PROCNAME +  `]   ****  Error Message [` + PROCMESSAGE +  `]  **** Error Trace [` + PROCSTACK +  `]''
                , ''''
              );
        ` ;                
        snowflake.execute( { sqlText: sql_command } );   

                

        result = "Success";
                         
    }
    catch (err)  {
        result = "Failed: " + err;
 
        snowflake.execute({sqlText:
            `insert into admin.error_log(procedurename , error_code , error_state, error_message , stack_trace)  VALUES (?, ?, ?, ?, ?)`
            ,binds: [arguments.callee.name , err.code, err.state, err.message, err.stackTraceTxt]
        });
       
        throw ( err );
    }
	return result;
';