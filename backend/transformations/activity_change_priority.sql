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
	'Setze Priorität auf ' || "NewValue" as "ACTIVITY_DE",
	'Set Priority to ' || "NewValue" as "ACTIVITY_EN",
	"CaseHistory"."CreatedDate" as "EVENTTIME",
	10 as "_SORTING",
	"Field" as "CHANGED_FIELD",
	"OldValue" as "CHANGED_FROM",
	"NewValue" as "CHANGED_TO"
FROM 
	"Case"
	JOIN "CaseHistory" ON
		"Case"."Id" = "CaseHistory"."CaseId"
WHERE
	"Field" like 'Priority'
;
