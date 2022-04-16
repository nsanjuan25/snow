create or replace view V_PLA_DIMMATERIALSUNITOFMEASURES(
	DATASOURCEKEY,
	MATERIALCODE,
	PLANTCODE,
	ALTERNATEUNITOFMEASUREDSCODE,
	ALTERNATETOBASECONVERSIONRATE,
	UOMROUNDINGDECIMAL,
	SNFLK_UPDATEDON
) as 
/*-------------------------------------------------------------------------------------------------

This view is used to insert data into V_DimMaterialsUnitOfMeasures
-----------------------------------------------------------------------------------------------
Revision History
-----------------------------------------------------------------------------------------------
Date            Developer               Comments
----------------------------------------------------------------------------------------------
2021-09-21      Jagan                   Initial Revision     
*/
select 
    '4' DATASOURCEKEY,                                  
	marc_marm.MaterialCode,
	marc_marm.PlantCode,
	marc_marm.AlternateUnitOfMeasureDSCode,
	marc_marm.AlternateToBaseConversionRate,
	t006.andec as UOMRoundingDecimal,
	current_timestamp as SNFLK_UPDATEDON from 
	(
        select temp.* from 
        (
		    select 
                 marc.matnr as MaterialCode,
                 marc.werks as PlantCode,
                 marm.meinh as AlternateUnitOfMeasureDSCode,
                 marm.umrez / marm.umren as AlternateToBaseConversionRate,
                 row_number() over (partition by marc.matnr, marc.werks, marm.meinh order by marc.matnr, marc.werks, marm.meinh) as rownum
            from 
                CONFORMED.PLA_HA_MARC marc 
            inner join 
			    CONFORMED.PLA_HA_MARM marm
                    on marc.matnr = marm.matnr
         ) as temp
    where temp.rownum = 1
    ) marc_marm
LEFT OUTER JOIN CONFORMED.PLA_HA_T006 T006
    on marc_marm.AlternateUnitOfMeasureDSCode = T006.MSEHI;