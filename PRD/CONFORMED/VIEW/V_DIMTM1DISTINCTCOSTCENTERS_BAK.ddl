create or replace view V_DIMTM1DISTINCTCOSTCENTERS_BAK(
	COSTCENTERCODE
) as

SELECT  
    CASE 
        WHEN RIGHT(CostCenter,1)='_' THEN LEFT(CostCenter,LEN(CostCenter)-1) 
        ELSE CostCenter 
    END CostCenterCode
FROM
    CONFORMED.TM1_RPGL_IMDB
    
UNION 

SELECT  
    CASE 
        WHEN RIGHT(CostCenter,1)='_' THEN LEFT(CostCenter,LEN(CostCenter)-1) 
        ELSE CostCenter         
    END AS CostCenterCode
FROM
    CONFORMED.TM1_RPGL_Fact
WHERE 
    try_to_date ( Period || '-01' , 'mmmm-yy-dd')   >= '2014-09-01'
    ;