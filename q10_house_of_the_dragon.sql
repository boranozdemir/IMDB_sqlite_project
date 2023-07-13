WITH p AS (
      SELECT titles.primary_title AS name, akas.title AS dubbed
      FROM titles
      INNER JOIN akas ON titles.title_id = akas.title_id
      WHERE titles.primary_title = "House of the Dragon" AND titles.type = 'tvSeries'
      GROUP BY titles.primary_title, akas.title
      ORDER BY akas.title
),
c AS (
      SELECT row_number() OVER (ORDER BY p.name ASC) AS seqnum, p.dubbed AS dubbed
      FROM p
),
flattened AS (
      SELECT seqnum, dubbed
      FROM c
      WHERE seqnum = 1
      UNION ALL
      SELECT c.seqnum, f.dubbed || ', ' || c.dubbed
      FROM c JOIN
            flattened f
            ON c.seqnum = f.seqnum + 1
)
SELECT dubbed FROM flattened
ORDER BY seqnum DESC LIMIT 1;