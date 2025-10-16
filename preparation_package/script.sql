-- Summarize concept usage across OMOP CDM tables
-- Works in most SQL dialects (Postgres, SQL Server, Oracle, MySQL, BigQuery, etc.)

WITH concept_counts AS (
    SELECT 'condition_occurrence' AS table_name,
           condition_concept_id AS concept_id,
           COUNT(*) AS row_count
      FROM condition_occurrence
     WHERE condition_concept_id <> 0
     GROUP BY condition_concept_id

    UNION ALL

    SELECT 'drug_exposure' AS table_name,
           drug_concept_id AS concept_id,
           COUNT(*) AS row_count
      FROM drug_exposure
     WHERE drug_concept_id <> 0
     GROUP BY drug_concept_id

    UNION ALL

    SELECT 'procedure_occurrence' AS table_name,
           procedure_concept_id AS concept_id,
           COUNT(*) AS row_count
      FROM procedure_occurrence
     WHERE procedure_concept_id <> 0
     GROUP BY procedure_concept_id

    UNION ALL

    SELECT 'measurement' AS table_name,
           measurement_concept_id AS concept_id,
           COUNT(*) AS row_count
      FROM measurement
     WHERE measurement_concept_id <> 0
     GROUP BY measurement_concept_id

    UNION ALL

    SELECT 'observation' AS table_name,
           observation_concept_id AS concept_id,
           COUNT(*) AS row_count
      FROM observation
     WHERE observation_concept_id <> 0
     GROUP BY observation_concept_id
)

SELECT c.table_name,
       c.concept_id,
       co.concept_name,
       co.vocabulary_id,
       c.row_count
  FROM concept_counts c
  LEFT JOIN concept co
    ON c.concept_id = co.concept_id
 ORDER BY c.table_name, c.row_count DESC;
