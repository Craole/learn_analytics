--TODO The query provides the performance averages of NBA players who have played in the past (x) years and recorded an average playing time above the 75th percentile of all players. It also includes several player performance metrics including Player Efficiency Rating (PER) - a metric used to evaluate a player's overall performance. This information can help in identifying high-performing players who are also consistent and reliable in their playing time, and therefore more valuable to their team.

WITH players AS (
  SELECT
      "Player",
      SUM("Games") AS "Games",
      SUM("Minutes") AS "Minutes",
      AVG("Player Efficiency Rating") AS "Player Efficiency Rating",
      AVG("True Shooting Percentage") AS "True Shooting Percentage",
      AVG("3-Point Attempt Rate") AS "3-Point Attempt Rate",
      AVG("Free Throw Attempt Rate") AS "Free Throw Attempt Rate",
      AVG("Offensive Rebound Percentage") AS "Offensive Rebound Percentage",
      AVG("Defensive Rebound Percentage") AS "Defensive Rebound Percentage",
      AVG("Total Rebound Percentage") AS "Total Rebound Percentage",
      AVG("Assist Percentage") AS "Assist Percentage",
      AVG("Steal Percentage") AS "Steal Percentage",
      AVG("Block Percentage") AS "Block Percentage",
      AVG("Turnover Percentage") AS "Turnover Percentage",
      AVG("Usage Percentage") AS "Usage Percentage",
      AVG("Offensive Win Shares") AS "Offensive Win Shares",
      AVG("Defensive Win Shares") AS "Defensive Win Shares",
      AVG("Win Shares") AS "Win Shares",
      AVG("Win Shares Per 48 Minutes") AS "Win Shares Per 48 Minutes",
      AVG("Offensive Box Plus/Minus") AS "Offensive Box Plus/Minus",
      AVG("Defensive Box Plus/Minus") AS "Defensive Box Plus/Minus",
      AVG("Box Plus/Minus") AS "Box Plus/Minus",
      AVG("Value over Replacement Player") AS "Value over Replacement Player"
  FROM "Advanced"
  WHERE
      1 = 1
      AND "Player Efficiency Rating" IS NOT NULL
      AND "Minutes" > 0
      AND UPPER("Team") NOT LIKE 'TOT'
      AND "Season" >= NOW() - INTERVAL '1 years'
      -- AND LOWER("Player") LIKE '%bridges%'
  GROUP BY
      "Player"
    ),
    minutes AS (
        SELECT
            PERCENTILE_CONT(0) WITHIN GROUP (
                ORDER BY
                    "Minutes"
            ) as "80th Percentile of Minutes"
        FROM "Advanced"
    )
SELECT
    "Player",
    ROUND("Games", 2) AS "Games",
    ROUND("Minutes", 2) AS "Minutes",
    ROUND(CAST("Player Efficiency Rating" AS numeric), 2) AS "Player Efficiency Rating",
    -- ROUND(CAST("True Shooting Percentage" AS numeric), 2) AS "True Shooting Percentage",
    -- ROUND(CAST("3-Point Attempt Rate" AS numeric), 2) AS "3-Point Attempt Rate",
    -- ROUND(CAST("Free Throw Attempt Rate" AS numeric), 2) AS "Free Throw Attempt Rate",
    -- ROUND(CAST("Offensive Rebound Percentage" AS numeric), 2) AS "Offensive Rebound Percentage",
    -- ROUND(CAST("Defensive Rebound Percentage" AS numeric), 2) AS "Defensive Rebound Percentage",
    -- ROUND(CAST("Total Rebound Percentage" AS numeric), 2) AS "Total Rebound Percentage",
    -- ROUND(CAST("Assist Percentage" AS numeric), 2) AS "Assist Percentage",
    -- ROUND(CAST("Steal Percentage" AS numeric), 2) AS "Steal Percentage",
    ROUND(CAST("Block Percentage" AS numeric), 2) AS "Block Percentage",
    -- ROUND(CAST("Turnover Percentage" AS numeric), 2) AS "Turnover Percentage",
    -- ROUND(CAST("Usage Percentage" AS numeric), 2) AS "Usage Percentage",
    ROUND(CAST("Offensive Win Shares" AS numeric), 2) AS "Offensive Win Shares",
    ROUND(CAST("Defensive Win Shares" AS numeric), 2) AS "Defensive Win Shares",
    ROUND(CAST("Win Shares" AS numeric), 2) AS "Win Shares",
    ROUND(CAST("Win Shares Per 48 Minutes" AS numeric), 2) AS "Win Shares Per 48 Minutes",
    -- ROUND(CAST("Offensive Box Plus/Minus" AS numeric), 2) AS "Offensive Box Plus/Minus",
    -- ROUND(CAST("Defensive Box Plus/Minus" AS numeric), 2) AS "Defensive Box Plus/Minus",
    -- ROUND(CAST("Box Plus/Minus" AS numeric), 2) AS "Box Plus/Minus",
    ROUND(CAST("Value over Replacement Player" AS numeric), 2) AS "Value over Replacement Player"
FROM players, minutes
WHERE
    1=1
    AND "Minutes" > "80th Percentile of Minutes"
ORDER BY
    "Block Percentage" DESC,
    "Games" DESC,
    "Minutes" DESC,
    "Win Shares" DESC,
    "Player Efficiency Rating" DESC;