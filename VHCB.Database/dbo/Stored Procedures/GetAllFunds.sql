CREATE procedure [dbo].[GetAllFunds]

as
Begin
	select f.FundId, f.name from Fund f 
			
		where f.RowIsActive = 1
	order by f.name
end