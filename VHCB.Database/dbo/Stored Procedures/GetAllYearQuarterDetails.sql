
CREATE procedure GetAllYearQuarterDetails
as
Begin

-- exec GetAllYearQuarterDetails 
 SELECT ACYrQtrID
		,[Year]
		, 'Quarter' + cast(ACYrQtr.Qtr as varchar(2)) as Qtr
  FROM ACYrQtr ORDER BY [YEAR] DESC,ACYrQtr.Qtr DESC
end