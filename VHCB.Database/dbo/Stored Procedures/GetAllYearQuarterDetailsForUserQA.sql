
CREATE procedure GetAllYearQuarterDetailsForUserQA
as
Begin

-- exec GetAllYearQuarterDetailsForUserQA 
 SELECT DISTINCT AYQ.ACYrQtrID
		,cast(AYQ.[Year] AS nvarchar(5)) +'- Quarter' + cast(AYQ.Qtr as varchar(2)) as [Quarter]
		,AYQ.[Year]
		,AYQ.[QTR]	
  FROM ACYrQtr AYQ INNER JOIN ACPerformanceMaster ACPM ON AYQ.ACYrQtrID = ACPM.ACYrQtrID
  ORDER BY AYQ.[Year],AYQ.[QTR]
end