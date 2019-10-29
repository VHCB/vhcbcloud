Create procedure [dbo].[GetFundWithDetails]
as
Begin
	select distinct dt.fundid, f.name from Fund f 
	join Detail dt on dt.fundid = f.fundid
	order by f.name asc
End