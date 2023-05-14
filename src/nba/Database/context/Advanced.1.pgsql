SELECT
  -- "Season ID",
  "Season",
  -- "Player ID",
  "Player",
  "Position",
  "Age",
  "Experience",
  -- "League",
  "Team",
  "Games",
  "Minutes",
  "Player Efficiency Rating",
  -- "True Shooting Percentage",
  -- "3-Point Attempt Rate",
  -- "Free Throw Attempt Rate",
  -- "Offensive Rebound Percentage",
  -- "Defensive Rebound Percentage",
  -- "Total Rebound Percentage",
  -- "Assist Percentage",
  -- "Steal Percentage",
  -- "Block Percentage",
  -- "Turnover Percentage",
  -- "Usage Percentage",
  -- "Offensive Win Shares",
  -- "Defensive Win Shares",
  -- "Win Shares",
  "Win Shares Per 48 Minutes",
  "Offensive Box Plus/Minus",
  "Defensive Box Plus/Minus",
  "Box Plus/Minus",
  "Value over Replacement Player"
FROM
  "Advanced"
WHERE
  "League" = 'NBA'
  AND "Player" LIKE 'Kevin Garnett'
  -- AND "Team" LIKE 'TOT' --@ Transferred during the season
  -- AND LENGTH("Position") > 2 --@ Played multiple positions
  AND "Minutes" > 0
  AND "Win Shares Per 48 Minutes" IS NOT NULL
  AND "Box Plus/Minus" IS NOT NULL
  AND "Value over Replacement Player" IS NOT NULL
ORDER BY
  "Experience" DESC,
  "Value over Replacement Player" DESC,
  "Win Shares Per 48 Minutes" DESC,
  "Minutes" DESC,
  "Player"
LIMIT
  100;

-- SELECT
--   "Season",
--   "Player",
--   "Position",
--   ROUND(AVG("Minutes"), 0) AS "Average Minutes",
--   SUM("Minutes") AS "Total Minutes"
-- FROM
--   "Advanced"
-- WHERE
--   "Minutes" IS NOT NULL
--   AND "Position" <> 'C'
-- GROUP BY
--   "Season",
--   "Player",
--   "Position"
-- ORDER BY
--   -- "Season" DESC,
--   AVG("Minutes") DESC,
--   SUM("Minutes") DESC
-- LIMIT
--   10;
-- SELECT
--   "Player",
--   ROUND(AVG("Minutes"), 0) AS "Average Minutes",
--   "Player Efficiency Rating"
-- FROM
--   "Advanced"
-- WHERE
--   "Player Efficiency Rating" IS NOT NULL
--   AND "Minutes" IS NOT NULL
--   -- AND "Season" >= 2023
-- GROUP BY
--   "Player",
--   "Minutes",
--   "Player Efficiency Rating"
--   -- HAVING
--   --   "Average Minutes" > 2500
-- ORDER BY
--   "Average Minutes" DESC,
--   "Player Efficiency Rating" DESC
-- LIMIT
--   100;
--   "Season",
--   SUM("Minutes"),
--   MAX("Player Efficiency Rating")
-- FROM
--   "Advanced"
-- GROUP BY
--   "Player",
--   "Season"
-- ORDER BY
--   "Season",
--   MAX("Player Efficiency Rating")
-- LIMIT
--   100;
-- Player Performance:
-- Which players have the highest Player Efficiency Rating?
-- SELECT
--   "Player",
--   "Player Efficiency Rating"
-- FROM
--   "Advanced"
-- ORDER BY
--   "Player Efficiency Rating" ASC
-- LIMIT
--   10;
-- Which players have the highest True Shooting Percentages?
-- Which players have the highest Win Shares?
-- Which players have the highest Box Plus/Minus ratings?
-- Which players have the highest Value over Replacement Player ratings?
-- Which players have the highest usage percentages?
-- Which players have the highest offensive and defensive rebound percentages?
-- Which players have the highest assist, steal, and block percentages?
-- Which players have the highest turnover percentages?
-- Which players have the highest offensive and defensive win shares?
-- Which players have the highest win shares per 48 minutes?
-- How do different players' performances vary across different seasons, leagues, teams, and positions?
-- Team Performance:
-- Which teams have the most wins in a given season or league?
-- Which teams have the highest average Player Efficiency Ratings or other performance metrics?
-- Which teams have the most win shares from their players?
-- How does a team's performance change over the course of a season?
-- Which teams have the highest offensive and defensive ratings?
-- How do different teams' performances vary across different seasons, leagues, and positions?
-- Player Development:
-- How does a player's performance change over the course of their career, in terms of age, experience, and position?
-- Which players tend to improve the most from season to season, in terms of their performance metrics?
-- How do players' performances vary based on the amount of minutes they play?
-- Which positions tend to develop the most well-rounded players?
-- How does a player's performance vary based on the team they are playing for or the league they are playing in?
-- Market Analysis:
-- How do performance metrics affect player salaries or trade value?
-- How do performance metrics change over the course of a player's contract?
-- Which teams are most likely to be interested in a given player, based on their position and performance metrics?
-- How does a player's performance in one league compare to their performance in another league?
-- Which positions are most in demand across different teams and leagues?
-- How do performance metrics affect a team's likelihood of making the playoffs or winning a championship?