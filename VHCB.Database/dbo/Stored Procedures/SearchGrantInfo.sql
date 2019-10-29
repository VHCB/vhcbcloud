
create procedure SearchGrantInfo  
(
	@VHCBName		nvarchar(50) = null,
	@Program		int = null,
	@LkGrantAgency	int = null,
	@Grantor		nvarchar(20) = null,
	@IsActiveOnly	bit = 1
)
as
begin
begin try
--exec SearchGrantInfo 'rk', null, null, null, 0
print @VHCBName
		select GrantinfoID, GrantName, VHCBName, LkGrantAgency, LkGrantSource, Grantor, AwardNum, AwardAmt, BeginDate, EndDate, Staff, ContactID, CFDA, Program, SignAgree, FedFunds, FedSignDate, Fundsrec, Match, Admin, Notes, RowIsActive, DateModified
		from GrantInfo
		where (@VHCBName is null or VHCBName like '%'+ @VHCBName + '%')
			and (@Program is null or Program = @Program)
			and (@LkGrantAgency is null or LkGrantAgency = @LkGrantAgency)
			and (@Grantor is null or ContactID = @Grantor)
			and (@IsActiveOnly = 0 or RowIsActive = @IsActiveOnly) 
		order by VHCBName
	
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