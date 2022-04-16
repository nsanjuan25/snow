create or replace view V_FACTSFOPPORTUNITIES(
	ID,
	SFACCOUNTKEY,
	CLOSEDATEKEY,
	PRODUCTIONSTARTKEY,
	OPPORTUNITYNAME,
	STAGENAME,
	SETTARTGETPLANTKEY,
	ISWON,
	PROBABILITY,
	PEAKREVENUE,
	LIFETIMEREVENUE,
	FY2016_REVENUE,
	FY2017_REVENUE,
	FY2018_REVENUE,
	FY2019_REVENUE,
	FY2020_REVENUE,
	FY2021_REVENUE
) as
SELECT 
      RTRIM(  O.id )                                         AS ID
    , IFNULL( SA.SFAccountKey , 0 )                          AS SFAccountKey
	, try_To_date (closedate)                                AS CloseDateKey
    , try_To_date (production_start)                         AS ProductionStartKey
    , UPPER( IFNULL( RTRIM( O.name ) ,'') )                  AS OpportunityName        
    , UPPER( IFNULL( RTRIM( O.stage ) ,'') )                 AS stagename
    , IFNULL( RTRIM( UPPER( TP.SetTartgetPlantKey )) , 0 )   AS SetTartgetPlantKey
    , UPPER( IFNULL( UPPER( RTRIM( O.iswon )  ) ,'')  )      AS iswon
    , case when o.probability is null or o.probability = '' then 0 else o.probability end AS probability
    , case when o.peak_revenue2 is null or o.peak_revenue2 = '' then 0 else o.peak_revenue2 end AS PeakRevenue
    , case when o.lifetime_revenue2 is null or o.lifetime_revenue2 = '' then 0 else o.lifetime_revenue2 end AS LifeTimeRevenue    
    , case when o.fy16_revenue is null or o.fy16_revenue = '' then 0 else o.fy16_revenue end AS fy2016_revenue    
    , case when o.fy17_revenue is null or o.fy17_revenue = '' then 0 else o.fy17_revenue end AS fy2017_revenue  
    , case when o.fy18_revenue is null or o.fy18_revenue = '' then 0 else o.fy18_revenue end AS fy2018_revenue 
    , case when o.fy19_revenue is null or o.fy19_revenue = '' then 0 else o.fy19_revenue end AS fy2019_revenue 
    , case when o.fy20_revenue is null or o.fy20_revenue = '' then 0 else o.fy20_revenue end AS fy2020_revenue 
    , case when o.fy21_revenue is null or o.fy21_revenue = '' then 0 else o.fy21_revenue end AS fy2021_revenue 
    
FROM     
    conformed.SF_Opportunity AS O
    LEFT OUTER JOIN Salesforce.DimSFSetTargetPlants TP 
    ON  Upper(O.Target_Sites) = TP.SetTargetPlants
    LEFT OUTER JOIN Salesforce.DimSFAccounts  SA 
    ON O.accountid  = SA.AccountSrcID;