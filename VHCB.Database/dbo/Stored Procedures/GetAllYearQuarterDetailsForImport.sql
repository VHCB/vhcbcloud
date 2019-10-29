
CREATE procedure GetAllYearQuarterDetailsForImport
as
Begin

-- exec GetAllYearQuarterDetailsForImport 
 SELECT DISTINCT ACYrQtr.ACYrQtrID
		,CASE Qtr
		    WHEN 1 THEN CAST(YEAR AS varchar) + ' - Q1'
			WHEN 2 THEN CAST(YEAR AS varchar) + ' - Q2'
			WHEN 3 THEN CAST(YEAR AS varchar) + ' - Q3'
			WHEN 4 THEN CAST(YEAR AS varchar) + ' - Q4'
		END AS YEARQTR
  FROM ACYrQtr INNER JOIN ACPerformanceMaster ON ACYrQtr.ACYrQtrID = ACPerformanceMaster.ACYrQtrID 
end