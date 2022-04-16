create or replace view V_CREDITSBURNOUT(
	START_TIME,
	TOTALCREDITS,
	CREDITSUSED,
	CREDITSUSEDCUMMULATIVE,
	REMAINING_CREDITS
) as 
SELECT 
    Start_Time, 
    TotalCredits, 
    CreditsUsed,
    CreditsUsedCummulative, 
    TotalCredits - CreditsUsedCummulative as Remaining_Credits
FROM
    (
    SELECT
          Date_Trunc(month, Start_Time) as Start_Time
        , SUM(CREDITS_USED) AS CreditsUsed
        , SUM( sum( CREDITS_USED ) ) over ( order by  Date_Trunc(month, Start_Time) ASC    ) AS CreditsUsedCummulative
        , 32963 +   --89000
          18518 as  TotalCredits--50000  
    FROM
        V_WAREHOUSECREDITS
    group by 
        Date_Trunc(month, Start_Time)    
    ) A;