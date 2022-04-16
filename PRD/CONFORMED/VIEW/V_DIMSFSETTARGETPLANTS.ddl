create or replace view V_DIMSFSETTARGETPLANTS(
	SETTARGETPLANTS
) as
SELECT DISTINCT IFNULL( RTRIM( UPPER(target_sites ) ) ,' ')  AS SetTargetPlantS

FROM conformed.SF_Opportunity

WHERE target_sites IS NOT NULL AND target_sites <> '';