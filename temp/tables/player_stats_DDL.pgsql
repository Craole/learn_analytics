--*** DELETE TABLES ***--
  --@ Drop the tables if they exists
  DROP TABLE IF EXISTS player_stats_csv, player_stats;

--*** CREATE TABLES ***--
  --| Player Stats [CSV]
    CREATE TEMP TABLE --@ Use TEXT data-type to avoid errors
      player_stats_csv (
        seas_id TEXT,
        season TEXT,
        player_id TEXT,
        player TEXT,
        birth_year TEXT,
        pos TEXT,
        age TEXT,
        experience TEXT,
        lg TEXT,
        tm TEXT,
        g TEXT,
        gs TEXT,
        mp TEXT,
        fg TEXT,
        fga TEXT,
        fg_percent TEXT,
        x3p TEXT,
        x3pa TEXT,
        x3p_percent TEXT,
        x2p TEXT,
        x2pa TEXT,
        x2p_percent TEXT,
        e_fg_percent TEXT,
        ft TEXT,
        fta TEXT,
        ft_percent TEXT,
        orb TEXT,
        drb TEXT,
        trb TEXT,
        ast TEXT,
        stl TEXT,
        blk TEXT,
        tov TEXT,
        pf TEXT,
        pts TEXT
      );
  --| Player Stats
  --@ Declare the set of desired columns
  CREATE TABLE player_stats (
    "Season ID" INTEGER NOT NULL,
    "Season" DATE NOT NULL,
    "Player ID" SMALLINT NOT NULL,
    "Player" VARCHAR(50) NOT NULL,
    "Position" VARCHAR(16) NOT NULL,
    "League" VARCHAR(3) NOT NULL,
    "Team" VARCHAR(3) NOT NULL,
    "Games" INTEGER
      CHECK ("Games" >= 0 OR "Games" IS NULL),
    "Games Started" INTEGER
      CHECK ("Games Started" >= 0 OR "Games Started" IS NULL),
    "Minutes" INTEGER
      CHECK ("Minutes" >= 0 OR "Minutes" IS NULL),
    "3-Point Field Goals" INTEGER
      CHECK ("3-Point Field Goals" >= 0 OR "3-Point Field Goals" IS NULL),
    "3-Point Field Goal Attempts" INTEGER
      CHECK ("3-Point Field Goal Attempts" >= 0 OR "3-Point Field Goal Attempts" IS NULL),
    "2-Point Field Goals" INTEGER
      CHECK ("2-Point Field Goals" >= 0 OR "2-Point Field Goals" IS NULL),
    "2-Point Field Goal Attempts" INTEGER
      CHECK ("2-Point Field Goal Attempts" >= 0 OR "2-Point Field Goal Attempts" IS NULL),
    "Free Throws" INTEGER
      CHECK ("Free Throws" >= 0 OR "Free Throws" IS NULL),
    "Free Throw Attempts" INTEGER
      CHECK ("Free Throw Attempts" >= 0 OR "Free Throw Attempts" IS NULL),
    "Offensive Rebounds" INTEGER
      CHECK ("Offensive Rebounds" >= 0 OR "Offensive Rebounds" IS NULL),
    "Defensive Rebounds" INTEGER
      CHECK ("Defensive Rebounds" >= 0 OR "Defensive Rebounds" IS NULL),
    "Assists" INTEGER
      CHECK ("Assists" >= 0 OR "Assists" IS NULL),
    "Steals" INTEGER
      CHECK ("Steals" >= 0 OR "Steals" IS NULL),
    "Blocks" INTEGER
      CHECK ("Blocks" >= 0 OR "Blocks" IS NULL),
    "Turnovers" INTEGER
      CHECK ("Turnovers" >= 0 OR "Turnovers" IS NULL),
    "Fouls" INTEGER
      CHECK ("Fouls" >= 0 OR "Fouls" IS NULL),
    PRIMARY KEY ("Season ID", "Player ID")
  );


--*** IMPORT DATA ***--
  --| CSV Import
    COPY --@ Declare the destination SQL table
      player_stats_csv
    FROM --@ Declare file path, delimiter and whether headings should be read
      'D:\Projects\Data\nba\Assets\data\Player Totals.csv'
      DELIMITER ','
      CSV HEADER;


--*** VALIDATE DATA ***--
-- Create a for loop that checks if the cast is possible then continue to the SELECT
-- Validate each column in the csv (player_stats_csv) that it matches the data type in the destination table (player_stats
--| Season ID
SELECT
    CAST(seas_id AS INTEGER) AS seas_id
FROM player_stats_csv;

--| Season
SELECT
    TO_DATE(
        CAST(season AS TEXT),
        'YYYY-MM-DD'
    ) AS season
FROM player_stats_csv;

--| Player ID
SELECT
    CAST(player_id AS INTEGER) AS player_id
FROM player_stats_csv;

--| Player
SELECT
    CAST(player AS VARCHAR(50)) AS player
FROM player_stats_csv;

--| Position
SELECT
    CAST(pos AS VARCHAR(16)) AS pos
FROM player_stats_csv;

--| League
SELECT
    CAST(lg AS VARCHAR(3)) AS lg
FROM player_stats_csv;

--| Team
SELECT
    CAST(tm AS VARCHAR(3)) AS tm
FROM player_stats_csv;

--| Games
SELECT CAST(g AS INTEGER) AS g
FROM player_stats_csv;

--| Games Started
SELECT
    CAST(NULLIF(gs, 'NA') AS INT) AS gs
FROM player_stats_csv;

--| Minutes
SELECT
    CAST(NULLIF(mp, 'NA') AS INT) AS mp
FROM player_stats_csv;

--| 3-Point Field Goals
SELECT
    CAST(NULLIF(x3p, 'NA') AS INT) AS x3p
FROM player_stats_csv;

--| 3-Point Field Goal Attempts
SELECT
    CAST(NULLIF(x3pa, 'NA') AS INT) AS x3pa
FROM player_stats_csv;

--| 2-Point Field Goals
SELECT
    CAST(NULLIF(x2p, 'NA') AS INT) AS x2p
FROM player_stats_csv;

--| 2-Point Field Goal Attempts
SELECT
    CAST(NULLIF(x2pa, 'NA') AS INT) AS x2pa
FROM player_stats_csv;

--| Free Throws
SELECT
    CAST(NULLIF(ft, 'NA') AS INT) AS ft
FROM player_stats_csv;

--| Free Throw Attempts
SELECT
    CAST(NULLIF(fta, 'NA') AS INT) AS fta
FROM player_stats_csv;

--| Offensive Rebounds
SELECT
    CAST(NULLIF(orb, 'NA') AS INT) AS orb
FROM player_stats_csv;

--| Defensive Rebounds
SELECT
    CAST(NULLIF(drb, 'NA') AS INT) AS drb
FROM player_stats_csv;

--| Assists
SELECT
    CAST(NULLIF(ast, 'NA') AS INT) AS ast
FROM player_stats_csv;

--| Steals
SELECT
    CAST(NULLIF(stl, 'NA') AS INT) AS stl
FROM player_stats_csv;

--| Blocks
SELECT
    CAST(NULLIF(blk, 'NA') AS INT) AS blk
FROM player_stats_csv;

--| Turnovers
SELECT
    CAST(NULLIF(tov, 'NA') AS INT) AS tov
FROM player_stats_csv;

--| Fouls
SELECT
    CAST(NULLIF(pf, 'NA') AS INT) AS pf
FROM player_stats_csv;

--*** CHECK TABLES ***--
--| Data
--@ Validate data
SELECT
    "Season ID",
    CAST(
        to_char("Season", 'YYYY') AS INTEGER
    ) as "Season",
    "Player ID",
    "Player",
    "Position",
    "League",
    "Team",
    "Games",
    "Games Started",
    "Minutes",
    "3-Point Field Goals",
    "3-Point Field Goal Attempts",
    "2-Point Field Goals",
    "2-Point Field Goal Attempts",
    "Free Throws",
    "Free Throw Attempts",
    "Offensive Rebounds",
    "Defensive Rebounds",
    "Assists",
    "Steals",
    "Blocks",
    "Turnovers",
    "Fouls"
FROM player_stats
WHERE
    1 = 1
    AND "Team" NOT LIKE 'TOT'
ORDER BY
    "Season" DESC,
    "Minutes" DESC,
    "Games" DESC,
    "Player"
LIMIT 100;