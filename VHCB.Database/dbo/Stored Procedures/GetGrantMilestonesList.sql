
create procedure GetGrantMilestonesList  
(
	@GrantInfoId	int,
	@IsActiveOnly	bit
)
as
begin
--exec GetGrantMilestonesList 62, 0
	begin try

		select MilestoneGrantID, GrantInfoID, MilestoneID, lpn.description as Milestone, Date, 
			Note as FullNotes, substring(Note, 0, 25) Note, 
			URL, CASE when isnull(m.URL, '') = '' then '' else 'Click here' end as URLText, m.RowIsActive
		from GrantMilestones m(nolock)
		join lookupvalues lpn on lpn.typeid = m.MilestoneID
		where GrantinfoID = @GrantInfoId 
			and (@IsActiveOnly = 0 or m.RowIsActive = @IsActiveOnly)
	
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