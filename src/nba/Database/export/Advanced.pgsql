COPY (
  SELECT
    "Season ID",
    "Season",
    "Player ID",
    "Player",
    "Position",
    "Age",
    "Experience",
    "League",
    "Team",
    "Games",
    "Minutes",
    "Player Efficiency Rating",
    "True Shooting Percentage",
    "3-Point Attempt Rate",
    "Free Throw Attempt Rate",
    "Offensive Rebound Percentage",
    "Defensive Rebound Percentage",
    "Total Rebound Percentage",
    "Assist Percentage",
    "Steal Percentage",
    "Block Percentage",
    "Turnover Percentage",
    "Usage Percentage",
    "Offensive Win Shares",
    "Defensive Win Shares",
    "Win Shares",
    "Win Shares Per 48 Minutes",
    "Offensive Box Plus/Minus",
    "Defensive Box Plus/Minus",
    "Box Plus/Minus",
    "Value over Replacement Player"
  FROM
    "Advanced"
  LIMIT
    10
) TO 'D:\Projects\Data\nba\Database\content\Advanced.csv'
WITH
  DELIMITER ',' CSV HEADER;