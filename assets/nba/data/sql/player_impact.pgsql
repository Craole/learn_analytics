--*** DELETE TABLES ***--

--@ Drop the tables if they exists

DROP TABLE
    IF EXISTS player_stats_csv,
    player_stats;

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
CREATE TABLE
    --@ Declare the set of desired columns
    player_stats (
        "Season ID" INTEGER,
        "Season" DATE,
        "Player ID" SMALLINT,
        "Player" VARCHAR(50),
        "Position" VARCHAR(16),
        "League" VARCHAR(3),
        "Team" VARCHAR(3),
        "Games" INT,
        "Games Started" INT,
        "Minutes" INT,
        "3-Point Field Goals" INT,
        "3-Point Field Goal Attempts" INT,
        "2-Point Field Goals" INT,
        "2-Point Field Goal Attempts" INT,
        "Free Throws" INT,
        "Free Throw Attempts" INT,
        "Offensive Rebounds" INT,
        "Defensive Rebounds" INT,
        "Assists" INT,
        "Steals" INT,
        "Blocks" INT,
        "Turnovers" INT,
        "Fouls" INT,
        PRIMARY KEY ("Season ID", "Player ID")
    );

--*** IMPORT DATA ***--
--| CSV Import
COPY
    --@ Declare the destination SQL table
    player_stats_csv
FROM
    --@ Declare file path, delimiter and whether headings should be read
    '/home/craole/Projects/Data/assets/nba/csv/Player Totals.csv' DELIMITER ',' CSV HEADER;

--*** VALIDATE DATA ***--
-- Create a for loop that checks if the cast is possible then continue to the SELECT
-- Validate each column in the csv (player_stats_csv) that it matches the data type in the destination table (player_stats
-- --| Season ID
-- SELECT
--     CAST(seas_id AS INTEGER) AS seas_id
-- FROM player_stats_csv;
-- --| Season
-- SELECT
--     TO_DATE(
--         CAST(season AS TEXT),
--         'YYYY-MM-DD'
--     ) AS season
-- FROM player_stats_csv;
-- --| Player ID
-- SELECT
--     CAST(player_id AS INTEGER) AS player_id
-- FROM player_stats_csv;
-- --| Player
-- SELECT
--     CAST(player AS VARCHAR(50)) AS player
-- FROM player_stats_csv;
-- --| Position
-- SELECT
--     CAST(pos AS VARCHAR(16)) AS pos
-- FROM player_stats_csv;
-- --| League
-- SELECT
--     CAST(lg AS VARCHAR(3)) AS lg
-- FROM player_stats_csv;
-- --| Team
-- SELECT
--     CAST(tm AS VARCHAR(3)) AS tm
-- FROM player_stats_csv;
-- --| Games
-- SELECT CAST(g AS INTEGER) AS g
-- FROM player_stats_csv;
-- --| Games Started
-- SELECT
--     CAST(NULLIF(gs, 'NA') AS INT) AS gs
-- FROM player_stats_csv;
-- --| Minutes
-- SELECT
--     CAST(NULLIF(mp, 'NA') AS INT) AS mp
-- FROM player_stats_csv;
-- --| 3-Point Field Goals
-- SELECT
--     CAST(NULLIF(x3p, 'NA') AS INT) AS x3p
-- FROM player_stats_csv;
-- --| 3-Point Field Goal Attempts
-- SELECT
--     CAST(NULLIF(x3pa, 'NA') AS INT) AS x3pa
-- FROM player_stats_csv;
-- --| 2-Point Field Goals
-- SELECT
--     CAST(NULLIF(x2p, 'NA') AS INT) AS x2p
-- FROM player_stats_csv;
-- --| 2-Point Field Goal Attempts
-- SELECT
--     CAST(NULLIF(x2pa, 'NA') AS INT) AS x2pa
-- FROM player_stats_csv;
-- --| Free Throws
-- SELECT
--     CAST(NULLIF(ft, 'NA') AS INT) AS ft
-- FROM player_stats_csv;
-- --| Free Throw Attempts
-- SELECT
--     CAST(NULLIF(fta, 'NA') AS INT) AS fta
-- FROM player_stats_csv;
-- --| Offensive Rebounds
-- SELECT
--     CAST(NULLIF(orb, 'NA') AS INT) AS orb
-- FROM player_stats_csv;
-- --| Defensive Rebounds
-- SELECT
--     CAST(NULLIF(drb, 'NA') AS INT) AS drb
-- FROM player_stats_csv;
-- --| Assists
-- SELECT
--     CAST(NULLIF(ast, 'NA') AS INT) AS ast
-- FROM player_stats_csv;
-- --| Steals
-- SELECT
--     CAST(NULLIF(stl, 'NA') AS INT) AS stl
-- FROM player_stats_csv;
-- --| Blocks
-- SELECT
--     CAST(NULLIF(blk, 'NA') AS INT) AS blk
-- FROM player_stats_csv;
-- --| Turnovers
-- SELECT
--     CAST(NULLIF(tov, 'NA') AS INT) AS tov
-- FROM player_stats_csv;
-- --| Fouls
-- SELECT
--     CAST(NULLIF(pf, 'NA') AS INT) AS pf
-- FROM player_stats_csv;
--*** TRANSFER DATA ***--
--| SQL Import
INSERT INTO
    --@ Set the columns that should be populated
    player_stats (
        "Season ID",
        "Season",
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
    )
SELECT
    --@ Use `NULLIF` for errors and CAST` for data-types
    CAST(seas_id AS INTEGER) AS seas_id,
    TO_DATE(
        CAST(season AS TEXT),
        'YYYY-MM-DD'
    ) AS season,
    CAST(player_id AS SMALLINT) AS player_id,
    CAST(player AS VARCHAR(50)) AS player,
    CAST(pos AS VARCHAR(16)) AS pos,
    CAST(lg AS VARCHAR(3)) AS lg,
    CAST(tm AS VARCHAR(3)) AS tm,
    CAST(g AS INT) AS g,
    CAST(NULLIF(gs, 'NA') AS INT) AS gs,
    CAST(NULLIF(mp, 'NA') AS INT) AS mp,
    CAST(NULLIF(x3p, 'NA') AS INT) AS x3p,
    CAST(NULLIF(x3pa, 'NA') AS INT) AS x3pa,
    CAST(NULLIF(x2p, 'NA') AS INT) AS x2p,
    CAST(NULLIF(x2pa, 'NA') AS INT) AS x2pa,
    CAST(NULLIF(ft, 'NA') AS INT) AS ft,
    CAST(NULLIF(fta, 'NA') AS INT) AS fta,
    CAST(NULLIF(orb, 'NA') AS INT) AS orb,
    CAST(NULLIF(drb, 'NA') AS INT) AS drb,
    CAST(NULLIF(ast, 'NA') AS INT) AS ast,
    CAST(NULLIF(stl, 'NA') AS INT) AS stl,
    CAST(NULLIF(blk, 'NA') AS INT) AS blk,
    CAST(NULLIF(tov, 'NA') AS INT) AS tov,
    CAST(NULLIF(pf, 'NA') AS INT) AS pf
FROM
    --@ Pull data from the temporary table
    player_stats_csv;

--*** CLEAN UP ***--
--@ Drop the temporary table
DROP TABLE player_stats_csv;

--@ Commit the transaction
COMMIT;

--*** CHECK TABLE ***--
--| Data-types
SELECT
    --@ Choose columns that provide relevant info
    column_name,
    data_type,
    is_nullable
FROM
    --@ Get info from the schema
    information_schema.columns
WHERE
    --@ Filter to the relevant table
    table_name = 'player_stats'
ORDER BY
    --@ Sort by the order of columns
    ordinal_position;

--| Data
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