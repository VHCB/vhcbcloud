
create procedure dbo.SubmitOtherMembers
(
	@UserId int,
	@YrQrtrId int,
	@MemberIncluded nvarchar(350)
)
as
begin transaction

	begin try
	if exists( Select MemberIncludedId from  ACMemberPerfData where UserID = @UserId and ACYrQtrID = @YrQrtrId)
	begin
		UPDATE ACMemberPerfData
		SET MemberIncluded = @MemberIncluded
		WHERE UserId = @UserId AND ACYrQtrID = @YrQrtrId
	end
	else
	begin
		 if(@MemberIncluded != '')	
		 begin  
			 insert into [dbo].ACMemberPerfData ([UserID],[ACYrQtrID],[MemberIncluded],[RowIsActive],[DateModified])
			 values (@UserId,@YrQrtrId,@MemberIncluded,1,GETDATE())
		 end
	end
	end try
	begin catch
		if @@trancount > 0
		rollback transaction;

		DECLARE @msg nvarchar(4000) = error_message()
		RAISERROR (@msg, 16, 1)
		return 1  
	end catch

	if @@trancount > 0
		commit transaction;