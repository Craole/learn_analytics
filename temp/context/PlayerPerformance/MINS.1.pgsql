-- The query provides a list of NBA players who have played in the last five years and recorded an average playing time above the 80th percentile of all players. It also includes their Player Efficiency Rating (PER) - a metric used to evaluate a player's overall performance - and their average minutes per game. This information can help in identifying high-performing players who are also consistent and reliable in their playing time, and therefore more valuable to their team.

WITH players AS (
        SELECT
            "Player",
            AVG("Player Efficiency Rating") AS "Average PER",
            AVG("Minutes") AS "Average Minutes"
        FROM "Advanced"
        WHERE
            1 = 1
            AND "Player Efficiency Rating" IS NOT NULL
            AND "Minutes" > 0
            -- AND EXTRACT(
            --     YEAR
            --     from
            --         "Season"
            -- ) >= EXTRACT(
            --     YEAR
            --     FROM NOW ()
            -- ) - 10
        GROUP BY
            "Player"
    ),
    minutes AS (
        SELECT
            PERCENTILE_CONT(.80) WITHIN GROUP (
                ORDER BY
                    "Minutes"
            ) as "80th Percentile of Average Minutes"
        FROM "Advanced"
    )
SELECT
    "Player",
    "Average PER" AS "Player Efficiency Rating",
    ROUND("Average Minutes", 2) AS "Minutes per Game"
FROM players, minutes
WHERE
    "Average Minutes" > "80th Percentile of Average Minutes"
ORDER BY
    "Player Efficiency Rating" DESC,
    "Minutes per Game" DESC;