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
	'Ändere Owner' as "ACTIVITY_DE",
	'Change Owner' as "ACTIVITY_EN",
	"CaseHistory"."CreatedDate" as "EVENTTIME",
	10 as "_SORTING",
	"Field" as "CHANGED_FIELD",
	"OldValue" as "CHANGED_FROM",
	"NewValue" as "CHANGED_TO"
FROM 
	"Case"
	JOIN "CaseHistory" ON
		"Case"."Id" = "CaseHistory"."CaseId"
	JOIN (
		SELECT
			"Id",
			ROW_NUMBER() OVER(PARTITION BY "CaseId" ORDER BY "OldValue" desc, "NewValue" desc) AS ROW_NR
		FROM
			"CaseHistory"
		WHERE
			"Field" LIKE 'Owner'
	) AS TMP ON
		"CaseHistory"."Id" = TMP."Id"
WHERE
	TMP.ROW_NR = 1
;
