create or replace view V_PIPES_MISSING(
	TABLENAME,
	PIPENAME
) as 
SELECT
      upper( A.TableName ) as TableName
    , IFNULL(  P.PIPE_NAME , '*MISSING PIPE') AS PipeName
FROM
    landing.TableMetadata A
    LEFT OUTER JOIN information_schema.PIPES P 
        ON CONCAT( 'PIPE_' , upper( A.TableName ) ) = P.PIPE_NAME
WHERE 
    P.PIPE_NAME IS NULL;