
-- Drop the table if it exists
DROP TABLE IF EXISTS player_stats_advanced;

-- Create the table with the expected headers
CREATE TABLE player_stats_advanced (
    "Season ID" INTEGER,
    "Season_TMP" SMALLINT,
    "Season" DATE,
    "Player ID" SMALLINT,
    "Player" VARCHAR(50),
    "Birth_Year_TMP" TEXT,
    "Position" VARCHAR(16),
    "Age" TEXT,
    "Experience" SMALLINT,
    "League" VARCHAR(3),
    "Team" VARCHAR(3),
    "Games" SMALLINT,
    "Minutes" TEXT,
    "Player Efficiency Rating" TEXT,
    "True Shooting Percentage" TEXT,
    "3-Point Attempt Rate" TEXT,
    "Free Throw Attempt Rate" TEXT,
    "Offensive Rebound Percentage" TEXT,
    "Defensive Rebound Percentage" TEXT,
    "Total Rebound Percentage" TEXT,
    "Assist Percentage" TEXT,
    "Steal Percentage" TEXT,
    "Block Percentage" TEXT,
    "Turnover Percentage" TEXT,
    "Usage Percentage" TEXT,
    "Offensive Win Shares" TEXT,
    "Defensive Win Shares" TEXT,
    "Win Shares" TEXT,
    "Win Shares Per 48 Minutes" TEXT,
    "Offensive Box Plus/Minus" TEXT,
    "Defensive Box Plus/Minus" TEXT,
    "Box Plus/Minus" TEXT,
    "Value over Replacement Player" TEXT,
    PRIMARY KEY ("Season ID", "Player ID")
);

-- Import data from the CSV
COPY player_stats_advanced (
    "Season ID",
    "Season_TMP",
    "Player ID",
    "Player",
    "Birth_Year_TMP",
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
)
FROM 'D:\Projects\Data\nba\Assets\data\Advanced.csv' DELIMITER ',' CSV HEADER;

-- Cleanup the data in the table
UPDATE player_stats_advanced
SET
    -- Convert Season_TMP to Season
    "Season" = TO_DATE("Season_TMP"::TEXT, 'YYYY'),

    -- Convert NA to NULL for missing values
    "Age" =
        NULLIF("Age", 'NA'),
    "Minutes" =
        NULLIF("Minutes", 'NA'),
    "Player Efficiency Rating" =
        NULLIF("Player Efficiency Rating", 'NA'),
    "True Shooting Percentage" =
        NULLIF("True Shooting Percentage", 'NA'),
    "3-Point Attempt Rate" =
        NULLIF("3-Point Attempt Rate", 'NA'),
    "Free Throw Attempt Rate" =
        NULLIF("Free Throw Attempt Rate", 'NA'),
    "Offensive Rebound Percentage" =
        NULLIF("Offensive Rebound Percentage", 'NA'),
    "Defensive Rebound Percentage" =
        NULLIF("Defensive Rebound Percentage", 'NA'),
    "Total Rebound Percentage" =
        NULLIF("Total Rebound Percentage", 'NA'),
    "Assist Percentage" =
        NULLIF("Assist Percentage", 'NA'),
    "Steal Percentage" =
        NULLIF("Steal Percentage", 'NA'),
    "Block Percentage" =
        NULLIF("Block Percentage", 'NA'),
    "Turnover Percentage" =
        NULLIF("Turnover Percentage", 'NA'),
    "Usage Percentage" =
        NULLIF("Usage Percentage", 'NA'),
    "Offensive Win Shares" =
        NULLIF("Offensive Win Shares", 'NA'),
    "Defensive Win Shares" =
        NULLIF("Defensive Win Shares", 'NA'),
    "Win Shares" =
        NULLIF("Win Shares", 'NA'),
    "Win Shares Per 48 Minutes" =
        NULLIF("Win Shares Per 48 Minutes", 'NA'),
    "Offensive Box Plus/Minus" =
        NULLIF("Offensive Box Plus/Minus", 'NA'),
    "Defensive Box Plus/Minus" =
        NULLIF( "Defensive Box Plus/Minus", 'NA'),
    "Box Plus/Minus" =
        NULLIF("Box Plus/Minus", 'NA'),
    "Value over Replacement Player" =
        NULLIF(  "Value over Replacement Player", 'NA');
--
-- Update data types and remove unnecessary columns
ALTER TABLE player_stats_advanced
    ALTER COLUMN "Age" TYPE SMALLINT
        USING "Age"::SMALLINT,
    ALTER COLUMN "Minutes" TYPE SMALLINT
        USING "Minutes"::SMALLINT,
    ALTER COLUMN "Player Efficiency Rating" TYPE REAL
        USING "Player Efficiency Rating"::REAL,
    ALTER COLUMN "True Shooting Percentage" TYPE REAL
        USING "True Shooting Percentage"::REAL,
    ALTER COLUMN  "3-Point Attempt Rate" TYPE REAL
        USING "3-Point Attempt Rate"::REAL,
    ALTER COLUMN  "Free Throw Attempt Rate" TYPE REAL
        USING "Free Throw Attempt Rate"::REAL,
    ALTER COLUMN "Offensive Rebound Percentage" TYPE REAL
        USING "Offensive Rebound Percentage"::REAL,
    ALTER COLUMN "Defensive Rebound Percentage" TYPE REAL
        USING "Defensive Rebound Percentage"::REAL,
    ALTER COLUMN "Total Rebound Percentage" TYPE REAL
        USING "Total Rebound Percentage"::REAL,
    ALTER COLUMN "Assist Percentage" TYPE REAL
        USING "Assist Percentage"::REAL,
    ALTER COLUMN "Steal Percentage" TYPE REAL
        USING "Steal Percentage"::REAL,
    ALTER COLUMN "Block Percentage" TYPE REAL
        USING "Block Percentage"::REAL,
    ALTER COLUMN "Turnover Percentage" TYPE REAL
        USING "Turnover Percentage"::REAL,
    ALTER COLUMN "Usage Percentage" TYPE REAL
        USING "Usage Percentage"::REAL,
    ALTER COLUMN "Offensive Win Shares" TYPE REAL
        USING "Offensive Win Shares"::REAL,
    ALTER COLUMN "Defensive Win Shares" TYPE REAL
        USING "Defensive Win Shares"::REAL,
    ALTER COLUMN "Win Shares" TYPE REAL
        USING "Win Shares"::REAL,
    ALTER COLUMN "Win Shares Per 48 Minutes" TYPE REAL
        USING "Win Shares Per 48 Minutes"::REAL,
    ALTER COLUMN "Offensive Box Plus/Minus" TYPE REAL
        USING "Offensive Box Plus/Minus"::REAL,
    ALTER COLUMN "Defensive Box Plus/Minus" TYPE REAL
        USING "Defensive Box Plus/Minus"::REAL,
    ALTER COLUMN "Box Plus/Minus" TYPE REAL
        USING "Box Plus/Minus"::REAL,
    ALTER COLUMN "Value over Replacement Player" TYPE REAL
        USING "Value over Replacement Player"::REAL,
    DROP COLUMN "Season_TMP",
    DROP COLUMN "Birth_Year_TMP";

-- Commit the transaction
COMMIT;
