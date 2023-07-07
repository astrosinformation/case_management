DROP VIEW IF EXISTS SLO_Calculations;

CREATE VIEW SLO_Calculations AS
WITH 
    case_data AS (
        SELECT 
            "Case".*,
            COALESCE("Workaround_Provided_Time_Diff"."Time_Diff", 0) AS Time_Diff
        FROM 
            "Case"
        LEFT JOIN 
            "Case_Activities_Aggregated" AS "Workaround_Provided_Time_Diff"
        ON 
            "Case"."Id" = "Workaround_Provided_Time_Diff"."_CASE_KEY" AND
            "Workaround_Provided_Time_Diff"."ACTIVITY_EN" = 'Change Workaround_Provided__c to true'
    )
SELECT 
    *,
    CASE
        WHEN Severity__c = 'Sev 1' AND Time_Diff > (4 * 3600) THEN 1
        WHEN Severity__c = 'Sev 2' AND Time_Diff > (2 * 24 * 3600) THEN 1
        WHEN Severity__c = 'Sev 3' AND Time_Diff > (10 * 24 * 3600) THEN 1
        WHEN Severity__c = 'Sev 4' AND Time_Diff > (14 * 24 * 3600) THEN 1
        WHEN Issue_Type__c = 'Service request' AND Time_Diff > (5 * 24 * 3600) THEN 1
        WHEN Issue_Type__c = 'Question' AND Time_Diff > (5 * 24 * 3600) THEN 1
        ELSE 0
    END AS SLO_Breach_Indicator,
    Time_Diff AS SLO_Breach_Duration,
    AVG(Time_Diff) OVER () AS Average_Duration,
    STDDEV(Time_Diff) OVER () AS StdDev_Duration
FROM 
    case_data;



-- Troubleshooting

-- SELECT MIN("Time_Diff"), MAX("Time_Diff"), AVG("Time_Diff") 
-- FROM "Case_Activities_Aggregated";

-- SELECT 
--   "Severity__c", 
--   "Issue_Type__c", 
--   COUNT(*) 
-- FROM "SLO_Calculations" 
-- WHERE "SLO_Breach_Indicator" = 1 
-- GROUP BY "Severity__c", "Issue_Type__c";

-- SELECT DISTINCT "Severity__c", "Issue_Type__c" 
-- FROM "Case";

-- SELECT DISTINCT "ACTIVITY_EN" 
-- FROM "Case_Activities_Aggregated";

-- SELECT * 
-- FROM SLO_Calculations 
-- LIMIT 10;

-- SELECT COUNT(*) 
-- FROM SLO_Calculations 
-- WHERE SLO_Breach_Indicator = 1;

-- SELECT COUNT(*) 
-- FROM SLO_Calculations 
-- WHERE SLO_Breach_Duration > 0;

-- SELECT MIN(SLO_Breach_Duration), MAX(SLO_Breach_Duration), AVG(SLO_Breach_Duration) 
-- FROM SLO_Calculations;


