CREATE procedure GetGrantInfo  
(
	@GrantInfoId	int
)
as
begin
--exec GetGrantInfo 33
	begin try

		select GrantName, VHCBName, LkGrantAgency, LkGrantSource, Grantor, AwardNum, 
		convert(varchar(50), AwardAmt) AwardAmt, BeginDate, EndDate, Staff, ContactID, CFDA, Program, SignAgree, FedFunds, FedSignDate, Fundsrec, Match, 
		Admin, Notes, DrawDown, RowIsActive, DateModified
		from GrantInfo
		where GrantinfoID = @GrantInfoId
	
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
end