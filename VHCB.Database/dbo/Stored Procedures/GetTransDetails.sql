CREATE procedure dbo.GetTransDetails
(	
	@detailId int
)
as
BEGIN 
	--exec GetTransDetails 353
	select Amount from Detail(nolock)
	where DetailID = @detailId
END