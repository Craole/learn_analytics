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
  --@ Check if the data being imported matches the expected data types
  --@ Use `NULLIF` for errors and `CAST` for data-types
  -- SELECT CAST(seas_id AS INTEGER) AS seas_id FROM player_stats_csv;
  -- SELECT TO_DATE(CAST(season AS TEXT), 'YYYY-MM-DD') AS season FROM player_stats_csv;
  -- SELECT CAST(player_id AS SMALLINT) AS player_id FROM player_stats_csv;
  -- SELECT CAST(player AS VARCHAR(50)) AS player FROM player_stats_csv;
  -- SELECT CAST(pos AS VARCHAR(16)) AS pos FROM player_stats_csv;
  -- SELECT CAST(lg AS VARCHAR(3)) AS lg FROM player_stats_csv;
  -- SELECT CAST(tm AS VARCHAR(3)) AS tm FROM player_stats_csv;
  -- SELECT CAST(g AS INT) AS g FROM player_stats_csv;
  -- SELECT CAST(NULLIF(gs, 'NA') AS INT) AS gs FROM player_stats_csv;
  -- SELECT CAST(NULLIF(mp, 'NA') AS INT) AS mp FROM player_stats_csv;
  -- SELECT CAST(NULLIF(x3p,'NA') AS INT) AS x3p FROM player_stats_csv;
  -- SELECT CAST(NULLIF(x3pa,'NA') AS INT) AS x3pa FROM player_stats_csv;
  -- SELECT CAST(NULLIF(x2p,'NA') AS INT) AS x2p FROM player_stats_csv;
  -- SELECT CAST(NULLIF(x2pa,'NA') AS INT) AS x2pa FROM player_stats_csv;
  -- SELECT CAST(NULLIF(ft,'NA') AS INT) AS ft FROM player_stats_csv;
  -- SELECT CAST(NULLIF(fta,'NA') AS INT) AS fta FROM player_stats_csv;
  -- SELECT CAST(NULLIF(orb,'NA') AS INT) AS orb FROM player_stats_csv;
  -- SELECT CAST(NULLIF(drb,'NA') AS INT) AS drb FROM player_stats_csv;
  -- SELECT CAST(NULLIF(ast,'NA') AS INT) AS ast FROM player_stats_csv;
  -- SELECT CAST(NULLIF(stl,'NA') AS INT) AS stl FROM player_stats_csv;
  -- SELECT CAST(NULLIF(blk,'NA') AS INT) AS blk FROM player_stats_csv;
  -- SELECT CAST(NULLIF(tov,'NA') AS INT) AS tov FROM player_stats_csv;
  -- SELECT CAST(NULLIF(pf,'NA') AS INT) AS p FROM player_stats_csv;
DO $$
DECLARE
  row record;
BEGIN
  FOR row IN SELECT seas_id FROM player_stats_csv
  LOOP
    IF row.seas_id !~ '^\d+$' THEN
      RAISE EXCEPTION 'seas_id cannot be cast to INTEGER: %', row.seas_id;
    END IF;
  END LOOP;
END $$;


-- SELECT
--   CASE
--     WHEN seas_id ~ '^\d+$' THEN CAST(seas_id AS INTEGER)
--     ELSE RAISE EXCEPTION 'seas_id cannot be cast to INTEGER: %', seas_id
--   END AS seas_id
--   CASE WHEN season ~ '^\d{4}-\d{2}-\d{2}$' THEN TO_DATE(season, 'YYYY-MM-DD') END AS season,
--   CASE WHEN player_id ~ '^\d+$' THEN CAST(player_id AS SMALLINT) END AS player_id,
--   CASE WHEN pos IS NOT NULL THEN CAST(pos AS VARCHAR(16)) END AS pos,
--   CASE WHEN lg IS NOT NULL THEN CAST(lg AS VARCHAR(1)) END AS lg,
--   CASE WHEN tm IS NOT NULL THEN CAST(tm AS VARCHAR(3)) END AS tm,
--   CASE WHEN g ~ '^\d+$' THEN CAST(g AS INTEGER) END AS g,
--   CASE WHEN gs IS NOT NULL AND gs ~ '^\d+$' THEN CAST(gs AS INTEGER) END AS gs,
--   CASE WHEN mp IS NOT NULL AND mp ~ '^\d+$' THEN CAST(mp AS INTEGER) END AS mp,
--   CASE WHEN x3p IS NOT NULL AND x3p ~ '^\d+$' THEN CAST(x3p AS INTEGER) END AS x3p,
--   CASE WHEN x3pa IS NOT NULL AND x3pa ~ '^\d+$' THEN CAST(x3pa AS INTEGER) END AS x3pa,
--   CASE WHEN x2p IS NOT NULL AND x2p ~ '^\d+$' THEN CAST(x2p AS INTEGER) END AS x2p,
--   CASE WHEN x2pa IS NOT NULL AND x2pa ~ '^\d+$' THEN CAST(x2pa AS INTEGER) END AS x2pa,
--   CASE WHEN ft IS NOT NULL AND ft ~ '^\d+$' THEN CAST(ft AS INTEGER) END AS ft,
--   CASE WHEN fta IS NOT NULL AND fta ~ '^\d+$' THEN CAST(fta AS INTEGER) END AS fta,
--   CASE WHEN orb IS NOT NULL AND orb ~ '^\d+$' THEN CAST(orb AS INTEGER) END AS orb,
--   CASE WHEN drb IS NOT NULL AND drb ~ '^\d+$' THEN CAST(drb AS INTEGER) END AS drb,
--   CASE WHEN ast IS NOT NULL AND ast ~ '^\d+$' THEN CAST(ast AS INTEGER) END AS ast,
--   CASE WHEN stl IS NOT NULL AND stl ~ '^\d+$' THEN CAST(stl AS INTEGER) END AS stl,
--   CASE WHEN blk IS NOT NULL AND blk ~ '^\d+$' THEN CAST(blk AS INTEGER) END AS blk,
--   CASE WHEN tov IS NOT NULL AND tov ~ '^\d+$' THEN CAST(tov AS INTEGER) END AS tov,
--   CASE WHEN pf IS NOT NULL AND pf ~ '^\d+$' THEN CAST(pf AS INTEGER) END AS pf
-- FROM player_stats_csv;


--*** CHECK TABLES ***--
  --| Data-types
--     SELECT --@ Choose columns that provide relevant info
--       column_name,
--       data_type,
--       is_nullable
--     FROM --@ Get info from the schema
--       information_schema.columns
--     WHERE --@ Filter to the relevant table
--       table_name = 'player_stats'
--     ORDER BY --@ Sort by the order of columns
--       ordinal_position;

--*** CLEAN UP ***--
-- --   --@ Drop the temporary table
-- --     DROP TABLE player_stats_csv;

-- --   --@ Commit the transaction
-- --     COMMIT;