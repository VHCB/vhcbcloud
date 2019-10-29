CREATE procedure GetCRDates
as
begin
	select top 12 convert(varchar(10), CRDate) CRDate  from dbo.CheckRequestDates(nolock) where RowIsActive = 1 and CRDate >= getdate()
	order by CRDate
	

end