UPDATE country_vaccination_stats
SET daily_vaccinations = Case when B.MEDIAN IS NULL THEN 0 ELSE B.MEDIAN END FROM	country_vaccination_stats A INNER JOIN
													(
													SELECT country,
														  daily_vaccinations,
														  PERCENTILE_CONT(0.5)
															 WITHIN GROUP (ORDER BY daily_vaccinations) OVER (
															  PARTITION BY country) AS MEDIAN
													FROM  country_vaccination_stats
													) B
											ON	A.country = B.country

SELECT *
FROM country_vaccination_stats