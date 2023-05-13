--* Player performance analysis: Analyze the performance of individual players based on their stats such as player efficiency rating, true shooting percentage, win shares, and usage percentage. This analysis can help identify the strengths and weaknesses of each player and make informed decisions about player development, acquisition, and trading.

--TODO Evaluate player efficiency rating (PER): This can be done by comparing a player's PER to the league average and assessing how much value they provide to their team on a per-minute basis. A high PER can indicate an efficient and productive player.
SELECT
  "Season ID",
  "Season",
  "Player ID",
  "Player",
  "Position",
  "Player Efficiency Rating"
FROM
  "Advanced"
WHERE
  "Player Efficiency Rating" IS NOT NULL
  AND "Minutes" > 0
ORDER BY
  "Player Efficiency Rating" DESC
LIMIT
  10;

--TODO Analyze true shooting percentage (TS%): TS% is a metric that takes into account a player's field goal percentage, three-point percentage, and free throw percentage. This metric can be used to evaluate a player's efficiency in scoring and shooting.
--TODO Assess win shares (WS): Win shares is a statistic that estimates the number of wins a player contributes to their team. This can be used to evaluate a player's overall impact on the game and their team's success.
--TODO Evaluate usage percentage (USG%): USG% is a measure of how often a player uses a team's possessions when they are on the court. This can be used to evaluate how much a player is involved in their team's offense and can be a factor in assessing a player's overall impact on the game.
--TODO Use advanced statistics: Advanced statistics such as Box Plus/Minus (BPM), Value Over Replacement Player (VORP), and Offensive/Defensive Win Shares (OWS/DWS) can provide a more nuanced understanding of a player's overall impact on the game.