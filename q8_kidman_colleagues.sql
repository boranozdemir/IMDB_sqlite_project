WITH kidman_titles AS (
     SELECT
          DISTINCT(crew.title_id)
     FROM
          people
     INNER JOIN
          crew ON crew.person_id == people.person_id AND people.name == "Nicole Kidman" AND people.born == 1967
),
kidman_colleagues AS (
     SELECT
          DISTINCT(crew.person_id) AS id
     FROM crew
     WHERE (crew.category == "actor" OR crew.category == "actress") AND crew.title_id in kidman_titles
)
SELECT
     name
FROM
     people
JOIN
     kidman_colleagues ON kidman_colleagues.id = people.person_id
ORDER BY name ASC;
