DROP VIEW IF EXISTS Touchpoints_Aggregated;

CREATE VIEW Touchpoints_Aggregated AS
SELECT 
  "ParentId" AS "CaseId",
  COUNT(*) AS "Touchpoint_Count",
  'EmailMessage' AS "Source"
FROM 
  "EmailMessage"
WHERE 
  "Incoming" = true
GROUP BY 
  "ParentId"
UNION ALL
SELECT 
  "ParentId" AS "CaseId",
  COUNT(*) AS "Touchpoint_Count",
  'CaseComment' AS "Source"
FROM 
  "CaseComment"
GROUP BY 
  "ParentId";
