
create procedure dbo.UpdateACMemberForm
(
	@ACMemberFormId	int, 
	@Received		bit, 
	@Date			datetime, 
	@URL			nvarchar(50),
	@Notes			nvarchar(max),
	@RowisActive	bit
) as
begin 

	update ACMemberForm set Received = @Received, Date = @Date, URL = @URL, Notes = @Notes, RowisActive = @RowisActive
	where ACMemberFormId = @ACMemberFormId
		
end