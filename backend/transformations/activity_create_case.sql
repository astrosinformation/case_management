INSERT INTO "_CEL_SF_CASE_ACTIVITIES"(
	"_CASE_KEY",
	"ACTIVITY_DE",
	"ACTIVITY_EN",
	"EVENTTIME",
	"_SORTING"
)
SELECT 
	"Case"."Id" as "_CASE_KEY",
	COALESCE('Lege Case an', 'Default Value') as "ACTIVITY_DE",
	COALESCE('Create Case', 'Default Value') as "ACTIVITY_EN",
	"Case"."CreatedDate" as "EVENTTIME",
	10 as "_SORTING"
FROM 
	"Case";
