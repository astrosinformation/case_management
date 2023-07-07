DROP VIEW IF EXISTS Case_Activities_Aggregated;

-- Aggregated case activities
CREATE VIEW Case_Activities_Aggregated AS
SELECT 
  "_CASE_KEY", 
  "ACTIVITY_EN",
  EXTRACT(EPOCH FROM (MAX("EVENTTIME") - MIN("Case"."CreatedDate"))) AS "Time_Diff"
FROM 
  (
    SELECT 
      "_CASE_KEY", 
      "ACTIVITY_EN",
      "EVENTTIME",
      ROW_NUMBER() OVER (PARTITION BY "_CASE_KEY", "ACTIVITY_EN" ORDER BY "EVENTTIME") AS "Row_Number"
    FROM 
      "_CEL_SF_CASE_ACTIVITIES"
    WHERE 
      "ACTIVITY_EN" IN ('Change Workaround_Provided__c to true', 'Change First_Qualified_Response__c to true')
  ) AS "Numbered_Case_Activities"
LEFT JOIN
  "Case"
ON
  "Numbered_Case_Activities"."_CASE_KEY" = "Case"."Id"
WHERE "Row_Number" = 1 -- Only consider the first activity for each case and activity type
GROUP BY 
  "_CASE_KEY", 
  "ACTIVITY_EN", 
  "Case"."CreatedDate";
