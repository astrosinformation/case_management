INSERT INTO "_CEL_SF_CASE_ACTIVITIES"(
    "_CASE_KEY",
    "ACTIVITY_EN",
    "EVENTTIME",
    "_SORTING"
)
SELECT 
    "Case"."Id" AS "_CASE_KEY",
    'Change First_Qualified_Response__c to true' AS "ACTIVITY_EN",
    "Case"."Date_Time_First_Qualified_Response__c" AS "EVENTTIME",
    10 AS "_SORTING"
FROM 
    "Case"
WHERE 
    "Case"."First_Qualified_Response__c" = 'true'
