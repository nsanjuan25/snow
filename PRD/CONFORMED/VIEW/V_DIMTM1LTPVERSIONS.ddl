create or replace view V_DIMTM1LTPVERSIONS(
	LTPVERSION
) as
Select distinct
    RTRIM ( UPPER ( ltpversion)) as LTPVersion
    from conformed.TM1_LTP_SQFDTData

Union 

Select distinct
    RTRIM ( UPPER ( ltpversion)) as LTPVersion
    from conformed.TM1_LTP_CustomerData;