SELECT
  "Player",
  "Team",
  "Games",
  ROUND(SUM("Minutes"), 0) AS "Minutes"
  -- "Minutes"
FROM
  "Advanced"
WHERE
  1 = 1
  AND "Player Efficiency Rating" IS NOT NULL
  AND "Minutes" > 0
  AND UPPER("Team") NOT LIKE 'TOT'
  AND "Season" >= NOW() - INTERVAL '1 years'
  AND LOWER("Player") LIKE '%bridges%'
GROUP BY
  "Player",
  "Team",
  "Games"
ORDER BY
  "Minutes" DESC