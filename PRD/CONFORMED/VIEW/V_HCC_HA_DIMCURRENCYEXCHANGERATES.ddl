create or replace view V_HCC_HA_DIMCURRENCYEXCHANGERATES(
	FROMCURRENCYCODE,
	TOCURRENCYCODE,
	EFFECTIVEFROMDATE,
	EXCHANGERATE,
	UPDATED_ON
) as
 /*-------------------------------------------------------------------------------------------------

This view is used to do the old tranformation spend_analytics.currencyexchangerate
-----------------------------------------------------------------------------------------------
Revision History
-----------------------------------------------------------------------------------------------
Date            Developer               Comments
----------------------------------------------------------------------------------------------
2021-01-28      Carlos Carrillo         Initial Revision
  */

SELECT FromCurrencycode,
       ToCurrencyCode,
       EffectiveFromDate,
       ExchangeRate,
       SYSDATE() AS updated_on
FROM
(
    SELECT FromCurrencycode,
           ToCurrencyCode,
           EffectiveFromDate,
           ExchangeRate,
           updated_on,
           ROW_NUMBER() OVER (PARTITION BY FromCurrencycode,
                                           ToCurrencyCode,
                                           EffectiveFromDate
                              ORDER BY CASE tn.kurst
                                           WHEN 'EURX' THEN
                                               1
                                           WHEN 'P' THEN
                                               2
                                           WHEN 'M' THEN
                                               3
                                       END
                             ) AS rn
    FROM
    (
        SELECT tp.fcurr AS FromCurrencycode,
               tp.tcurr AS ToCurrencyCode,
               CAST(CAST(ABS(tp.gdatu - 99999999) AS INT) AS string) AS EffectiveFromDate,
               (CASE
                    WHEN
                    (
                        tp.gdatu <= tp.tf_gdatu
                        AND tp.tfact != 0
                        AND NOT (
                                    tp.tf_tcurr IS NULL
                                    OR tp.tf_tcurr = ''
                                )
                    ) THEN
               ((-1 / tp.ukurs) * (tp.ffact / tp.tfact))
                    ELSE
               (-1 / tp.ukurs)
                END
               ) AS ExchangeRate,
               SYSDATE() AS updated_on,
               tp.kurst
        FROM
        (
            SELECT ti.*
            FROM
            (
                SELECT tr.fcurr,
                       tr.tcurr,
                       tf.tcurr tf_tcurr,
                       tr.gdatu,
                       tf.gdatu tf_gdatu,
                       tr.ukurs,
                       tf.ffact,
                       tf.tfact,
                       tr.kurst,
                       ROW_NUMBER() OVER (PARTITION BY tr.fcurr,
                                                       tr.tcurr,
                                                       tr.gdatu
                                          ORDER BY CASE tr.kurst
                                                       WHEN 'EURX' THEN
                                                           1
                                                       WHEN 'P' THEN
                                                           2
                                                       WHEN 'M' THEN
                                                           3
                                                   END
                                         ) row_num
                FROM CONFORMED.HCC_HA_TCURR tr
                    LEFT OUTER JOIN
                    (
                        SELECT *
                        FROM CONFORMED.HCC_HA_TCURF
                        WHERE kurst IN ( 'EURX', 'P', 'M' )
                    ) tf
                        ON tr.tcurr = tf.fcurr
                           AND tr.fcurr = tf.tcurr
                           AND tr.kurst = tf.kurst
                WHERE tr.kurst IN ( 'EURX', 'P', 'M' )
                      AND tr.ukurs < 0
            ) ti
            WHERE ti.row_num = 1
        ) tp
        UNION ALL
        SELECT tp.fcurr AS FromCurrencycode,
               tp.tcurr AS ToCurrencyCode,
               CAST(CAST(ABS(tp.gdatu - 99999999) AS INT) AS string) AS EffectiveFromDate,
               (CASE
                    WHEN
                    (
                        tp.gdatu <= tp.tf_gdatu
                        AND tp.ffact != 0
                        AND NOT (
                                    tp.tf_tcurr IS NULL
                                    OR tp.tf_tcurr = ''
                                )
                    ) THEN
               ((tp.ukurs) * (tp.tfact / tp.ffact))
                    ELSE
               (tp.ukurs)
                END
               ) AS ExchangeRate,
               SYSDATE() AS updated_on,
               tp.kurst
        FROM
        (
            SELECT ti.*
            FROM
            (
                SELECT tr.fcurr,
                       tr.tcurr,
                       tf.tcurr tf_tcurr,
                       tr.gdatu,
                       tf.gdatu tf_gdatu,
                       tr.ukurs,
                       tf.ffact,
                       tf.tfact,
                       tr.kurst,
                       ROW_NUMBER() OVER (PARTITION BY tr.fcurr,
                                                       tr.tcurr,
                                                       tr.gdatu
                                          ORDER BY CASE tr.kurst
                                                       WHEN 'EURX' THEN
                                                           1
                                                       WHEN 'P' THEN
                                                           2
                                                       WHEN 'M' THEN
                                                           3
                                                   END
                                         ) row_num
                FROM CONFORMED.HCC_HA_TCURR tr
                    LEFT OUTER JOIN
                    (
                        SELECT *
                        FROM CONFORMED.HCC_HA_TCURF
                        WHERE kurst IN ( 'EURX', 'P', 'M' )
                    ) tf
                        ON tr.fcurr = tf.fcurr
                           AND tr.tcurr = tf.tcurr
                           AND tr.kurst = tf.kurst
                WHERE tr.kurst IN ( 'EURX', 'P', 'M' )
                      AND tr.ukurs >= 0
            ) ti
            WHERE ti.row_num = 1
        ) tp
    ) tn
) tr
WHERE rn = 1;