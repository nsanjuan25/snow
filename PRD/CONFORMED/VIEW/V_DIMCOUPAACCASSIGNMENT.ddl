create or replace view V_DIMCOUPAACCASSIGNMENT(
	ROWID,
	PURCHASEDOCUMENTNUMBER,
	PURCHASEORDERID,
	PURCHASEORDERLINEID,
	PURCHASEORDERLINENUMBER,
	ACCOUNTLINEID,
	ACCOUNTLINENUMBER,
	MATERIALDOCUMENTNUMBER,
	DATASOURCEKEY,
	PROFITCENTER,
	GLACCOUNTNUMBER,
	GLDESCRIPTION,
	COSTCENTER,
	WBSELEMENT,
	LASTUPDATEDDATE,
	HASHVALUE
) as
/* 
Description             : This is the template for Header Section on Views
Created date            : 2021-05-24
Created By              : Lynelle Joanna  

Start Revision History            
-----------------------------------------------------------------------------------------------
Date                 Developer           Revision Description
----------           --------------      -----------------------------------------------------------
2021-05-21          Lynelle Joanna          Initial
-----------------------------------------------------------------------------------------------
End   Revision   History
*/

SELECT
	  ROWID 
	, PURCHASEDOCUMENTNUMBER 
	, PURCHASEORDERID 
	, PURCHASEORDERLINEID 
	, PURCHASEORDERLINENUMBER 
	, ACCOUNTLINEID 
	, ACCOUNTLINENUMBER 
	, MATERIALDOCUMENTNUMBER 
	, DATASOURCEKEY 
	, PROFITCENTER 
	, GLACCOUNTNUMBER 
	, GLDESCRIPTION 
	, COSTCENTER 
	, WBSELEMENT 
	, LASTUPDATEDDATE 
	, HASHVALUE
FROM

(
          SELECT
		  ROW_NUMBER() OVER (PARTITION BY 
			  PURCHASEDOCUMENTNUMBER 
			, PURCHASEORDERID 
			, PURCHASEORDERLINEID 
			, PURCHASEORDERLINENUMBER 
			, ACCOUNTLINEID 
			, ACCOUNTLINENUMBER 
			, MATERIALDOCUMENTNUMBER 
			, DATASOURCEKEY 
			, GLACCOUNTNUMBER 
			, COSTCENTER 
			, IFNULL(wbs.POSID,'')
			, PROFITCENTER 
		  ORDER BY PURCHASEDOCUMENTNUMBER,MATERIALDOCUMENTNUMBER)	AS ROWID
		, PURCHASEDOCUMENTNUMBER									
		, PURCHASEORDERID										
		, PURCHASEORDERLINEID										
		, PURCHASEORDERLINENUMBER								
		, ACCOUNTLINEID											
		, ACCOUNTLINENUMBER										
		, MATERIALDOCUMENTNUMBER 								
		, DATASOURCEKEY											
		, IFNULL(PROFITCENTER,'')									AS PROFITCENTER
		, IFNULL(GLACCOUNTNUMBER,'')								AS GLACCOUNTNUMBER
		, IFNULL(GLDESCRIPTION,'')									AS GLDESCRIPTION
		, IFNULL(COSTCENTER,'')										AS COSTCENTER
		, IFNULL(wbs.POSID,'')					    			    AS WBSELEMENT
		, LASTUPDATEDDATE											
        , HASH(PURCHASEDOCUMENTNUMBER
			  ,PURCHASEORDERID
			  ,PURCHASEORDERLINEID
			  ,PURCHASEORDERLINENUMBER
		      ,ACCOUNTLINEID
			  ,ACCOUNTLINENUMBER
			  ,MATERIALDOCUMENTNUMBER
			  ,DATASOURCEKEY
			  ,PROFITCENTER
			  ,GLACCOUNTNUMBER
		      ,GLDESCRIPTION
			  ,COSTCENTER
			  ,wbs.POSID
              ) AS HASHVALUE
										
            FROM     
                 (
                   SELECT 
                     IFNULL(i.PONUMBER,'')	 AS PURCHASEDOCUMENTNUMBER
                  , i.POID  AS PURCHASEORDERID
                  , i.ORDERLINEID AS PURCHASEORDERLINEID
                  , i.ORDERLINENUMBER AS PURCHASEORDERLINENUMBER
                  , i.ACCOUNTINGLINEID AS ACCOUNTLINEID 
                  , i.ACCOUNTLINENUMBER
                  , IFNULL(i.INVENTORYID,'') AS MATERIALDOCUMENTNUMBER
                  , IFNULL(DSOURCE.DATASOURCEKEY,0) AS DATASOURCEKEY
                  , CASE WHEN i.CHARTOFACCOUNTS = 'NRE Internal Orders' THEN
                    CASE WHEN IFNULL(pch2.PROFITCENTERCODE,'') <> '' THEN IFNULL(i.SEGMENT3, daa.PROFITCENTER)
                    ELSE ccm.PRCTR
                    END
                         WHEN i.CHARTOFACCOUNTS = 'Capital' THEN 
                         CASE WHEN IFNULL(pch.PROFITCENTERCODE,'') <> '' THEN IFNULL(i.SEGMENT4, daa.PROFITCENTER)
                         ELSE ccm.PRCTR
                         END
                         WHEN i.CHARTOFACCOUNTS = 'Expense' THEN IFNULL(ccm.PRCTR,' ')
                         ELSE IFNULL(i.PROFITCENTER, daa.PROFITCENTER)
                         END AS PROFITCENTER          
                  , GL.ECC AS GLACCOUNTNUMBER 
                  , COA.TXT50 AS GLDESCRIPTION
                  , IFNULL(RIGHT(RTRIM(LTRIM(i.COSTCENTER)),10), daa.COSTCENTER) AS COSTCENTER
                  ,  CASE WHEN i.CHARTOFACCOUNTS = 'Capital' THEN i.SEGMENT1
                    ELSE ''
                    END AS WBSELEMENT
                  , CAST(CAST( IFNULL( i.LASTUPDATEDDATE, '1900-01-01') AS TIMESTAMP_TZ) AS DATETIME) AS LASTUPDATEDDATE
              
                    FROM
                    (   SELECT
						  ROW_NUMBER() OVER ( PARTITION BY INVENTORYID,ACCOUNTINGLINEID,ACCOUNTLINENUMBER, status ORDER BY LASTUPDATEDDATE DESC) RN
						, INVENTORYID
						, PONUMBER
						, CAST(CASE WHEN POID IS NULL THEN 0
										WHEN POID = 'NULL' THEN 0
										WHEN POID = '' THEN 0
										ELSE POID
						  END AS NUMBER(38,0)) AS POID
						, CAST(CASE WHEN ORDERLINEID IS NULL THEN 0
										WHEN ORDERLINEID = 'NULL' THEN 0
										WHEN ORDERLINEID = '' THEN 0
										ELSE ORDERLINEID
						  END AS NUMBER(38,0)) AS ORDERLINEID
						, CAST(CASE WHEN ORDERLINENUMBER IS NULL THEN 0
										WHEN ORDERLINENUMBER = 'NULL' THEN 0
										WHEN ORDERLINENUMBER = '' THEN 0
										ELSE ORDERLINENUMBER
						  END AS NUMBER(38,0)) AS ORDERLINENUMBER
						, CAST(CASE WHEN ACCOUNTINGLINEID IS NULL THEN 0
										WHEN ACCOUNTINGLINEID = 'NULL' THEN 0
										WHEN ACCOUNTINGLINEID = '' THEN 0
										ELSE ACCOUNTINGLINEID
						  END AS NUMBER(38,0)) AS ACCOUNTINGLINEID
						, CAST(CASE WHEN ACCOUNTLINENUMBER IS NULL THEN 0
										WHEN ACCOUNTLINENUMBER = 'NULL' THEN 0
										WHEN ACCOUNTLINENUMBER = '' THEN 0
										ELSE ACCOUNTLINENUMBER
						  END AS NUMBER(38,0)) AS ACCOUNTLINENUMBER
						, CHARTOFACCOUNTS
						, RTRIM(LTRIM(SEGMENT3)) AS Segment3
						, RTRIM(LTRIM(SEGMENT4)) AS Segment4
						, RTRIM(LTRIM(SEGMENT1)) AS Segment1
						, LASTUPDATEDDATE
                    	, IFNULL(REPLACE(SUBSTRING(RECEIPTDATE, 1, 10), '-', ''), 19000101) AS ReceiptDateFormat
                        , CASE 
                            WHEN CHARTOFACCOUNTS LIKE '%Expense%' THEN NULL 
                            WHEN CHARTOFACCOUNTS LIKE '%NRE%Internal%Order%' THEN RTRIM(LTRIM(SEGMENT3)) 
                            WHEN CHARTOFACCOUNTS LIKE '%Capital%' THEN  RTRIM(LTRIM(SEGMENT4))
                            WHEN CHARTOFACCOUNTS LIKE '%Network%Order%' THEN  RTRIM(LTRIM(SEGMENT3))
                            ELSE NULL 
                        END AS PROFITCENTER
                        , CASE 
                           WHEN CHARTOFACCOUNTS LIKE '%Expense%' THEN RIGHT(RTRIM(LTRIM(SEGMENT3)),10)
                           WHEN CHARTOFACCOUNTS LIKE '%NRE%Internal%Order%' THEN RIGHT(RTRIM(LTRIM(SEGMENT4)),10)
                           WHEN CHARTOFACCOUNTS LIKE '%Capital%' THEN RIGHT(RTRIM(LTRIM(SEGMENT5)),10)
                           WHEN CHARTOFACCOUNTS LIKE '%Network%Order%' THEN  RIGHT(RTRIM(LTRIM(SEGMENT4)),10)
                          ELSE NULL 
                          END AS COSTCENTER
					
					FROM
						CONFORMED.COUPA_INVENTORY WHERE CHARTOFACCOUNTS IN('NRE Internal Orders','Expense','Capital'))i 
                    LEFT OUTER JOIN
                    (
                        SELECT  
						  ROW_NUMBER() OVER ( PARTITION BY POID,ORDERLINEID,ACCOUNTLINEID,ACCOUNTLINENUMBER ORDER BY LASTUPDATEDDATE DESC) rn
						, PONUMBER
						, CAST(CASE WHEN POID IS NULL THEN 0
										WHEN POID = 'NULL' THEN 0
										WHEN POID = '' THEN 0
										ELSE POID
						  END AS NUMBER(38,0)) AS POID
						, CAST(CASE WHEN ORDERLINEID IS NULL THEN 0
										WHEN ORDERLINEID = 'NULL' THEN 0
										WHEN ORDERLINEID = '' THEN 0
										ELSE ORDERLINEID
						  END AS NUMBER(38,0)) AS ORDERLINEID
						, CAST(CASE WHEN ORDERLINENUMBER IS NULL THEN 0
										WHEN ORDERLINENUMBER = 'NULL' THEN 0
										WHEN ORDERLINENUMBER = '' THEN 0
										ELSE ORDERLINENUMBER
						  END AS NUMBER(38,0)) AS ORDERLINENUMBER
						, CAST(CASE WHEN ACCOUNTLINEID IS NULL THEN 0
										WHEN ACCOUNTLINEID = 'NULL' THEN 0
										WHEN ACCOUNTLINEID = '' THEN 0
										ELSE ACCOUNTLINEID
						  END AS NUMBER(38,0)) AS ACCOUNTLINEID
						, CAST(CASE WHEN ACCOUNTLINENUMBER IS NULL THEN 0
										WHEN ACCOUNTLINENUMBER = 'NULL' THEN 0
										WHEN ACCOUNTLINENUMBER = '' THEN 0
										ELSE ACCOUNTLINENUMBER
						  END AS NUMBER(38,0)) AS ACCOUNTLINENUMBER
						, CHARTOFACCOUNTS
						, RTRIM(LTRIM(SEGMENT3)) AS SEGMENT3
						, RTRIM(LTRIM(SEGMENT4)) AS SEGMENT4
					    , CASE 
                            WHEN CHARTOFACCOUNTS LIKE '%Expense%' THEN NULL 
                            WHEN CHARTOFACCOUNTS LIKE '%NRE%Internal%Order%' THEN SEGMENT3 
                            WHEN CHARTOFACCOUNTS LIKE '%Capital%' THEN SEGMENT4 
                            WHEN CHARTOFACCOUNTS LIKE '%Network%Order%' THEN SEGMENT3 
                            ELSE NULL 
                        END AS ProfitCenter
                       , CASE 
                           WHEN CHARTOFACCOUNTS LIKE '%Expense%' THEN lpad(regexp_replace(SEGMENT5, '[^[:digit:]]', ''), 10, '0') 
                           WHEN CHARTOFACCOUNTS LIKE '%NRE%Internal%Order%' THEN lpad(regexp_replace(SEGMENT6, '[^[:digit:]]', ''), 10, '0') 
                           WHEN CHARTOFACCOUNTS LIKE '%Capital%' THEN lpad(regexp_replace(SEGMENT7, '[^[:digit:]]', ''), 10, '0') 
                           WHEN CHARTOFACCOUNTS LIKE '%Network%Order%' THEN lpad(regexp_replace(SEGMENT5, '[^[:digit:]]', ''), 10, '0') 
                           ELSE '0000000000' 
                           END AS CoupaGlAccount
						, CASE 
                           WHEN CHARTOFACCOUNTS LIKE '%Expense%' THEN RIGHT(RTRIM(LTRIM(SEGMENT3)),10)
                           WHEN CHARTOFACCOUNTS LIKE '%NRE%Internal%Order%' THEN RIGHT(RTRIM(LTRIM(SEGMENT4)),10)
                           WHEN CHARTOFACCOUNTS LIKE '%Capital%' THEN RIGHT(RTRIM(LTRIM(SEGMENT5)),10)
                           WHEN CHARTOFACCOUNTS LIKE '%Network%Order%' THEN  RIGHT(RTRIM(LTRIM(SEGMENT4)),10)
                           ELSE NULL 
                       END AS CostCenter
					FROM
						CONFORMED.COUPA_PURCHASEORDERS WHERE CHARTOFACCOUNTS IN('NRE Internal Orders','Expense','Capital')) po
                        ON po.POID				    = i.POID
					    AND po.ORDERLINEID		    = i.ORDERLINEID
					    AND po.ORDERLINENUMBER	    = i.ORDERLINENUMBER
					    AND po.ACCOUNTLINEID		= i.ACCOUNTINGLINEID
					    AND po.ACCOUNTLINENUMBER	= i.ACCOUNTLINENUMBER
                        
                    LEFT OUTER JOIN COUPA.DIMCOUPAACCASSIGNMENT daa
                        ON	i.INVENTORYID			= daa.MATERIALDOCUMENTNUMBER
                        AND i.POID					= daa.PURCHASEORDERID
                        AND i.ORDERLINEID			= daa.PURCHASEORDERLINEID
                        AND i.ORDERLINENUMBER		= daa.PURCHASEORDERLINENUMBER
                        AND i.ACCOUNTINGLINEID	    = daa.ACCOUNTLINEID
                        AND i.ACCOUNTLINENUMBER	    = daa.ACCOUNTLINENUMBER 
                        
                    LEFT OUTER JOIN CONFORMED.COUPA_GLACCOUNTS GL
                        ON GL.CONTROLLER = PO.COUPAGLACCOUNT
            			AND GL.SAPENVIRONMENT = 'ECC'
                    LEFT OUTER JOIN CONFORMED.ECC_HA_SKAT COA
			            ON COA.SAKNR = GL.ECC
			            AND COA.KTOPL = '0010'--coa.Chartofaccounts = '0010'
			            AND COA.SPRAS = 'E'  --coa.Languagekey = 'E'*/
                    LEFT OUTER JOIN CONFORMED.ECC_HA_CSKS CCM    
                        ON CCM.KOSTL = i.COSTCENTER
                        AND CCM.DATAB <= i.RECEIPTDATEFORMAT
                        AND CCM.DATBI >= i.RECEIPTDATEFORMAT
                    LEFT OUTER JOIN TM1.DIMPROFITCENTERHIERARCHY pch
			            ON i.SEGMENT4 = pch.PROFITCENTERNAME
		            LEFT OUTER JOIN TM1.DIMPROFITCENTERHIERARCHY pch2
			            ON i.SEGMENT3 = pch2.PROFITCENTERNAME
                    LEFT OUTER JOIN (SELECT MAX(DATASOURCEKEY) as DATASOURCEKEY,DATASOURCENAME FROM PUBLIC.DIMDATASOURCES GROUP BY DATASOURCENAME) DSOURCE ON DSOURCE.DATASOURCENAME = 'COUPA'
      WHERE 
		i.RN = 1 
		AND po.RN = 1
        AND i.ORDERLINEID <> 0
                 ) dups
	LEFT OUTER JOIN CONFORMED.ECC_HA_PRPS wbs ON wbs.POSID = dups.WBSElement
	) FINAL_QUERY
WHERE FINAL_QUERY.RowID = 1;