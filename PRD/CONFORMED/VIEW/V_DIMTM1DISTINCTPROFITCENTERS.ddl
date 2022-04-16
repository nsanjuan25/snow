create or replace view V_DIMTM1DISTINCTPROFITCENTERS(
	PROFITCENTERCODE
) as

SELECT DISTINCT 
    CASE 
        WHEN RIGHT(ProfitCenter,1)='_' THEN LEFT(ProfitCenter,LEN(ProfitCenter)-1) 
        ELSE ProfitCenter 
    END ProfitCenterCode
FROM
	CONFORMED.TM1_RPGL_IMDB
    
UNION 

SELECT DISTINCT 
    CASE 
        WHEN RIGHT(ProfitCenter,1)='_' THEN LEFT(ProfitCenter,LEN(ProfitCenter)-1) 
        ELSE ProfitCenter         
    END AS ProfitCenterCode
FROM
		CONFORMED.TM1_RPGL_Fact;