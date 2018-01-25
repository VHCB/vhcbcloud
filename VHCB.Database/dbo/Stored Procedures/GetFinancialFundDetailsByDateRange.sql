CREATE procedure [dbo].[GetFinancialFundDetailsByDateRange]
(
	@startDate datetime,
	@endDate datetime
)
as
Begin
	
	create table #temp
	(
		ProjectId int,
		FundType varchar(50),
		Amount money
	)
	insert into #temp (ProjectId, fundType, amount)
	SELECT   dbo.Project.ProjectId,  dbo.LkFundType.Description AS FundType, 
	sum(case when Trans.LkTransaction IN (238, 239, 240, 26552) then dbo.Detail.Amount else 0 end) - sum(case when Trans.LkTransaction IN (236, 237) then dbo.Detail.Amount else 0 end)
	 as Tot_Amt
                      
	FROM         dbo.LkFundType INNER JOIN
						  dbo.Detail INNER JOIN
						  dbo.Trans ON dbo.Detail.TransId = dbo.Trans.TransId INNER JOIN
						  dbo.Fund ON dbo.Detail.FundId = dbo.Fund.FundId INNER JOIN
						  dbo.Project ON dbo.Trans.ProjectID = dbo.Project.ProjectId ON dbo.LkFundType.TypeId = dbo.Fund.LkFundType INNER JOIN
						  dbo.LookupValues ON dbo.Trans.LkTransaction = dbo.LookupValues.TypeID
	WHERE    (trans.Date between @startDate and @endDate) AND Trans.rowisactive=1
			 and LkFundType.rowisactive = 1 and Trans.LkStatus = 262
	GROUP BY  dbo.Project.ProjectId, dbo.LkFundType.Description
	ORDER BY dbo.Project.ProjectId, FundType

	--select * from  #temp

	DECLARE @cols AS NVARCHAR(MAX),
		@query  AS NVARCHAR(MAX);

	SET @cols = STUFF((SELECT distinct ',' + QUOTENAME(c.fundType) 
				FROM #temp c
				FOR XML PATH(''), TYPE
				).value('.', 'NVARCHAR(MAX)') 
			,1,1,'')

	set @query = 'SELECT ProjectId, ' + @cols + ' from 
				(
					select ProjectId
						, FundType
						, Amount
					from #temp
			   ) x
				pivot 
				(
					 max(amount)
					for fundtype in (' + @cols + ')
				) p '


	execute(@query)
	drop table #temp
	
End