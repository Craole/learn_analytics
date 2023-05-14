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
  "League" = 'NBA' --@ Specific league
  AND "Season" = 2023 --@ Specific season
  -- AND "Player" LIKE 'Kevin Garnett' --@ Specific player
  -- AND "Team" LIKE 'TOT' --@ Transferred during the season
  -- AND LENGTH("Position") > 2 --@ Played multiple positions
  AND "Minutes" > 0
  AND "Win Shares Per 48 Minutes" IS NOT NULL
  AND "Box Plus/Minus" IS NOT NULL
  AND "Value over Replacement Player" IS NOT NULL
ORDER BY
  -- "Experience" DESC,
  -- "Value over Replacement Player" DESC,
  -- "Win Shares Per 48 Minutes" DESC,
  "Minutes" DESC,
  "Player"
LIMIT
  100;