INSERT INTO "_CEL_SF_CASE_ACTIVITIES"(
	"_CASE_KEY",
	"ACTIVITY_DE",
	"ACTIVITY_EN",
	"EVENTTIME",
	"_SORTING"
)
SELECT 
	"Case"."Id" as "_CASE_KEY",
	'Empfange E-Mail' as "ACTIVITY_DE",
	'Receive Email' as "ACTIVITY_EN",
	"EmailMessage"."CreatedDate" as "EVENTTIME",
	20 as "_SORTING"
FROM 
	"Case"
	JOIN "EmailMessage" ON
		"Case"."Id" = "EmailMessage"."ParentId"
WHERE
	"EmailMessage"."Incoming" = true;
