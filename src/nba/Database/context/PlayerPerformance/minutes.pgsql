SELECT
  "Season",
  "Player",
  "Player Efficiency Rating",
  ROUND(AVG("Minutes"), 2) AS "Minutes per Season",
  "Games"
FROM
  "Advanced"
WHERE
  1 = 1
  AND "Player Efficiency Rating" IS NOT NULL
  AND "Minutes" > 0
  AND EXTRACT(
    YEAR
    from
      "Season"
  ) >= EXTRACT(
    YEAR
    FROM
      NOW ()
  ) - 0
GROUP BY
  "Season",
  "Player",
  "Player Efficiency Rating",
  "Games",
  "Minutes"
ORDER BY
  "Player Efficiency Rating" DESC,
  "Minutes per Season",
  "Games";
