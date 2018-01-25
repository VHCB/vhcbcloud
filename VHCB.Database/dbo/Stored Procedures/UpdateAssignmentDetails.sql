create procedure UpdateAssignmentDetails
(	
	@DetailId int,	
	@ProjectId int,	
	@Amount money
)
as
BEGIN 

	DECLARE @guid AS uniqueidentifier

	select @guid = DetailGuId from Detail where DetailID = @detailId;

	update Detail set Amount = @amount, ProjectId = @ProjectId
	where DetailID = @detailId

	update Detail set amount = -@amount, ProjectId = @ProjectId 
	where DetailID != @detailId and DetailGuId = @guid
END