WITH
  TABLE1 AS (
    (
      SELECT DISTINCT
        "Player",
        LENGTH("Player") AS "Player Name Length"
      FROM
        "Advanced"
      ORDER BY
        LENGTH("Player"),
        "Player"
      LIMIT
        1
    )
    UNION
    (
      SELECT DISTINCT
        "Player",
        LENGTH("Player") AS "Player Name Length"
      FROM
        "Advanced"
      ORDER BY
        LENGTH("Player") DESC,
        "Player"
      LIMIT
        1
    )
  )
SELECT *
FROM TABLE1
ORDER BY
  "Player Name Length",
  "Player"