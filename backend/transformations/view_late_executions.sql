DROP VIEW IF EXISTS Late_Execution_Calculations;

-- Late Execution calculations
CREATE VIEW Late_Execution_Calculations AS
SELECT 
  "Case"."Id",
  CASE
    WHEN "Severity__c" = 'Sev 1' AND EXTRACT(EPOCH FROM ("Date_Time_First_Qualified_Response__c" - "CreatedDate")) > (4 * 3600) THEN 1
    WHEN "Severity__c" = 'Sev 2' AND EXTRACT(EPOCH FROM ("Date_Time_First_Qualified_Response__c" - "CreatedDate")) > (2 * 24 * 3600) THEN 1
    WHEN "Severity__c" = 'Sev 3' AND EXTRACT(EPOCH FROM ("Date_Time_First_Qualified_Response__c" - "CreatedDate")) > (10 * 24 * 3600) THEN 1
    WHEN "Severity__c" = 'Sev 4' AND EXTRACT(EPOCH FROM ("Date_Time_First_Qualified_Response__c" - "CreatedDate")) > (14 * 24 * 3600) THEN 1
    WHEN "Issue_Type__c" = 'Service request' AND EXTRACT(EPOCH FROM ("Date_Time_First_Qualified_Response__c" - "CreatedDate")) > (5 * 24 * 3600) THEN 1
    WHEN "Issue_Type__c" = 'Question' AND EXTRACT(EPOCH FROM ("Date_Time_First_Qualified_Response__c" - "CreatedDate")) > (5 * 24 * 3600) THEN 1
    ELSE 0
  END AS Late_Execution,
  EXTRACT(EPOCH FROM ("Date_Time_First_Qualified_Response__c" - "CreatedDate")) AS Time_To_First_Qualified_Response
FROM 
  "Case"
WHERE 
  "First_Qualified_Response__c" = 'true';



-- DROP VIEW IF EXISTS Late_Execution_Calculations;

-- -- Late Execution calculations
-- CREATE VIEW Late_Execution_Calculations AS
-- SELECT 
--   "Case"."Id",
--   CASE
--     WHEN "Severity__c" = 'Sev 1' AND COALESCE("First_Qualified_Response_Time_Diff"."Time_Diff", 0) > (4 * 3600) THEN 1
--     WHEN "Severity__c" = 'Sev 2' AND COALESCE("First_Qualified_Response_Time_Diff"."Time_Diff", 0) > (2 * 24 * 3600) THEN 1
--     WHEN "Severity__c" = 'Sev 3' AND COALESCE("First_Qualified_Response_Time_Diff"."Time_Diff", 0) > (10 * 24 * 3600) THEN 1
--     WHEN "Severity__c" = 'Sev 4' AND COALESCE("First_Qualified_Response_Time_Diff"."Time_Diff", 0) > (14 * 24 * 3600) THEN 1
--     WHEN "Issue_Type__c" = 'Service request' AND COALESCE("First_Qualified_Response_Time_Diff"."Time_Diff", 0) > (5 * 24 * 3600) THEN 1
--     WHEN "Issue_Type__c" = 'Question' AND COALESCE("First_Qualified_Response_Time_Diff"."Time_Diff", 0) > (5 * 24 * 3600) THEN 1
--     ELSE 0
--   END AS Late_Execution
-- FROM 
--   "Case"
-- LEFT JOIN 
--   "Case_Activities_Aggregated" AS "First_Qualified_Response_Time_Diff"
-- ON  "Case"."Id" = "First_Qualified_Response_Time_Diff"."_CASE_KEY" AND
--   "First_Qualified_Response_Time_Diff"."ACTIVITY_EN" = 'Change First_Qualified_Response__c to true';


-- Troubleshooting
-- SELECT DISTINCT "Severity__c", "Issue_Type__c" FROM "Case";

-- SELECT DISTINCT "ACTIVITY_EN", "Time_Diff" FROM "Case_Activities_Aggregated";

-- SELECT COUNT(*) 
-- FROM "Case" 
-- LEFT JOIN "Case_Activities_Aggregated" AS "First_Qualified_Response_Time_Diff"
-- ON "Case"."Id" = "First_Qualified_Response_Time_Diff"."_CASE_KEY" AND
-- "First_Qualified_Response_Time_Diff"."ACTIVITY_EN" = 'Change First_Qualified_Response__c to true';

-- SELECT "Severity__c", "Issue_Type__c", "First_Qualified_Response_Time_Diff"."Time_Diff"
-- FROM "Case"
-- LEFT JOIN "Case_Activities_Aggregated" AS "First_Qualified_Response_Time_Diff"
-- ON "Case"."Id" = "First_Qualified_Response_Time_Diff"."_CASE_KEY" AND
-- "First_Qualified_Response_Time_Diff"."ACTIVITY_EN" = 'Change First_Qualified_Response__c to true';

-- SELECT * FROM Late_Execution_Calculations;

-- SELECT COUNT(*) FROM Late_Execution_Calculations WHERE Late_Execution = 1;

-- SELECT * FROM Case;
-- SELECT * FROM Case_Activities_Aggregated;



