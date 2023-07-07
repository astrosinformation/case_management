INSERT INTO "_CEL_SF_CASE_ACTIVITIES"(
	"_CASE_KEY",
	"ACTIVITY_DE",
	"ACTIVITY_EN",
	"EVENTTIME",
	"_SORTING",
	"CHANGED_FIELD",
	"CHANGED_FROM",
	"CHANGED_TO"
)
SELECT 
	"Case"."Id" as "_CASE_KEY",
	'Change',
	CASE 
		WHEN "Field" IN ('On_hold_reasons__c', 'Close_Reason__c', 'Jira_Status__c', 'Severity__c', 'Product_Area__c', 'Workaround_Provided__c', 'X2nd_Level_c', 'Cause_Code__c', 'Service__c', 'caseMerged', 'Escalation_Status__c', 'Partner_Success__c', 'Licensing__c', 'Data_Science__c', 'Splitted Case_Numer__c', 'Is_Master_Incident__c', 'IsEscalated', 'Deal_Critical_new__c', 'Premium_Customer_c') THEN
			'Change ' || "Field" || ' to ' || "NewValue"
		ELSE
			'Change ' || "Field"
	END as "ACTIVITY_EN",
	"CaseHistory"."CreatedDate" as "EVENTTIME",
	10 as "_SORTING",
	"Field" as "CHANGED_FIELD",
	"OldValue" as "CHANGED_FROM",
	"NewValue" as "CHANGED_TO"
FROM 
	"Case"
	JOIN (
		SELECT
			"CaseId",
			"Id",
			"Field",
			"OldValue",
			"NewValue",
			"CreatedDate",
			ROW_NUMBER() OVER(PARTITION BY "CaseId", "Field" ORDER BY "CreatedDate" DESC) AS ROW_NR
		FROM
			"CaseHistory"
		WHERE
			"Field" IN ('On_hold_reasons__c', 'Close_Reason__c', 'Jira_Status__c', 'Severity__c', 'First Qualified_Response__c', 'Product_Area__c', 'Workaround_Provided__c', 'X2nd_Level_c', 'Cause_Code__c', 'Service__c', 'caseMerged', 'Escalation_Status__c', 'Partner_Success__c', 'Licensing__c', 'Data_Science__c', 'Splitted Case_Numer__c', 'Is_Master_Incident__c', 'IsEscalated', 'Deal_Critical_new__c', 'Premium_Customer_c')
	) AS "CaseHistory" ON
		"Case"."Id" = "CaseHistory"."CaseId"
WHERE
	"CaseHistory".ROW_NR = 1 AND
	"Field" NOT IN ('Status', 'Priority', 'Owner', 'Account', 'Type', 'created')
;


-- -- Drop the existing temporary table if it exists
-- DROP TABLE IF EXISTS temp_table_1;

-- -- Create a temporary table
-- CREATE TEMPORARY TABLE temp_table_1 AS (
-- 	SELECT 
-- 		"Case"."Id" as "_CASE_KEY",
-- 		CASE 
-- 			WHEN "Field" IN ('On_hold_reasons__c', 'Close_Reason__c', 'Jira_Status__c', 'Severity__c', 'First Qualified_Response__c', 'Product_Area__c', 'Workaround_Provided__c', 'X2nd_Level_c', 'Cause_Code__c', 'Service__c', 'caseMerged', 'Escalation_Status__c', 'Partner_Success__c', 'Licensing__c', 'Data_Science__c', 'Splitted Case_Numer__c', 'Is_Master_Incident__c', 'IsEscalated', 'Deal_Critical_new__c', 'Premium_Customer_c') THEN
-- 				'Change ' || "Field" || ' to ' || "NewValue"
-- 			ELSE
-- 				'Change ' || "Field"
-- 		END as "ACTIVITY_EN",
-- 		"CaseHistory"."CreatedDate" as "EVENTTIME",
-- 		10 as "_SORTING",
-- 		"Field" as "CHANGED_FIELD",
-- 		"OldValue" as "CHANGED_FROM",
-- 		"NewValue" as "CHANGED_TO"
-- 	FROM 
-- 		"Case"
-- 	JOIN "CaseHistory" ON
-- 			"Case"."Id" = "CaseHistory"."CaseId"
--   WHERE
-- 	  "Field" NOT IN ('Status', 'Priority', 'Owner', 'Account', 'Type', 'created')
-- );

-- -- Insert the data from the temporary table into the _CEL_SF_CASE_ACTIVITIES table
-- INSERT INTO "_CEL_SF_CASE_ACTIVITIES"(
-- 	"_CASE_KEY",
-- 	"ACTIVITY_DE",
-- 	"ACTIVITY_EN",
-- 	"EVENTTIME",
-- 	"_SORTING",
-- 	"CHANGED_FIELD",
-- 	"CHANGED_FROM",
-- 	"CHANGED_TO"
-- )
-- SELECT 
-- 	"_CASE_KEY",
-- 	'Change',
-- 	"ACTIVITY_EN",
-- 	"EVENTTIME",
-- 	"_SORTING",
-- 	"CHANGED_FIELD",
-- 	"CHANGED_FROM",
-- 	"CHANGED_TO"
-- FROM 
-- 	temp_table_1;







-- INSERT INTO "_CEL_SF_CASE_ACTIVITIES"(
-- 	"_CASE_KEY",
-- 	"ACTIVITY_DE",
-- 	"ACTIVITY_EN",
-- 	"EVENTTIME",
-- 	"_SORTING",
-- 	"CHANGED_FIELD",
-- 	"CHANGED_FROM",
-- 	"CHANGED_TO"
-- )
-- SELECT 
-- 	"Case"."Id" as "_CASE_KEY",
-- 	'Ändere ' || "Field" as "ACTIVITY_DE",
-- 	'Change ' || "Field" as "ACTIVITY_EN",
-- 	"CaseHistory"."CreatedDate" as "EVENTTIME",
-- 	10 as "_SORTING",
-- 	"Field" as "CHANGED_FIELD",
-- 	"OldValue" as "CHANGED_FROM",
-- 	"NewValue" as "CHANGED_TO"
-- FROM 
-- 	"Case"
-- 	JOIN "CaseHistory" ON
-- 		"Case"."Id" = "CaseHistory"."CaseId"
-- WHERE
-- 	"Field" NOT IN ('Status', 'Priority', 'Owner', 'Account', 'Type', 'created')
-- ;

-- INSERT INTO "_CEL_SF_CASE_ACTIVITIES"(
-- 	"_CASE_KEY",
-- 	"ACTIVITY_DE",
-- 	"ACTIVITY_EN",
-- 	"EVENTTIME",
-- 	"_SORTING",
-- 	"CHANGED_FIELD",
-- 	"CHANGED_FROM",
-- 	"CHANGED_TO"
-- )
-- SELECT 
-- 	"Case"."Id" as "_CASE_KEY",
-- 	'Ändere ' || "Field" || ' zu ' || "NewValue" as "ACTIVITY_DE",
-- 	'Change ' || "Field" || ' to ' || "NewValue" as "ACTIVITY_EN",
-- 	"CaseHistory"."CreatedDate" as "EVENTTIME",
-- 	10 as "_SORTING",
-- 	"Field" as "CHANGED_FIELD",
-- 	"OldValue" as "CHANGED_FROM",
-- 	"NewValue" as "CHANGED_TO"
-- FROM 
-- 	"Case"
-- 	JOIN "CaseHistory" ON
-- 		"Case"."Id" = "CaseHistory"."CaseId"
-- WHERE
-- 	"Field" NOT IN ('Status', 'Priority', 'Owner', 'Account', 'Type', 'created', 'issue_clarification_c', 'issue_verification_c', 'description_of_solution_implemented_c', 'action_plan_c');
