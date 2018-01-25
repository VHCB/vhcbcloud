
create procedure ImportBudgetPeriodData
(
	@ProjectID				int,
	@ImportLKBudgetPeriod	int,
	@LKBudgetPeriod			int
)  
as
/*
exec ImportBudgetPeriodData 6586,26084, 26085


select * from conserve
select * from ConserveSU where conserveid = 3
select * from ConserveSources where ConserveSUId = 7
select * from ConserveUses where ConserveSUId = 7
*/
begin
		declare @ConserveID	int
		declare @ConserveSUID int
		declare @ImportFromConserveSUID int

		if not exists
		(
			select 1 
			from Conserve(nolock) 
			where ProjectID = @ProjectID
		)
		begin
			RAISERROR ('Invalid Import1, No Project exist', 16, 1)
			return 1
		end
		else
		begin
			select @ConserveID = ConserveID 
			from Conserve(nolock) 
			where ProjectID = @ProjectID
		end 

		if not exists
		(
			select 1
			from ConserveSU(nolock)
			where ConserveID = @ConserveID 
				and LKBudgetPeriod = @LKBudgetPeriod
		)
		begin
			update ConserveSU set MostCurrent = 0 where ConserveID = @ConserveID and MostCurrent = 1

			insert into ConserveSU(ConserveID, LKBudgetPeriod, DateModified, MostCurrent)
			values(@ConserveID, @LKBudgetPeriod, getdate(), 1)

			set @ConserveSUID = @@IDENTITY
		end
		else
		begin
			select @ConserveSUID = ConserveSUID
			from ConserveSU(nolock)
			where ConserveID = @ConserveID 
				and LKBudgetPeriod = @LKBudgetPeriod
		end

		select @ImportFromConserveSUID = ConserveSUID 
		from ConserveSU(nolock) 
		where ConserveID = @ConserveID 
			and LKBudgetPeriod = @ImportLKBudgetPeriod

		insert into ConserveSources(ConserveSUID, LkConSource, Total, DateModified)
		select @ConserveSUID, LkConSource, Total, getdate()
		from ConserveSources (nolock)
		where RowIsActive = 1 and ConserveSUID = @ImportFromConserveSUID

		insert into ConserveUses(ConserveSUID, LkConUseVHCB, VHCBTotal, LkConUseOther, OtherTotal, DateModified)
		select @ConserveSUID, LkConUseVHCB, VHCBTotal, LkConUseOther, OtherTotal, getdate()
		from ConserveUses (nolock)
		where RowIsActive = 1 and ConserveSUID = @ImportFromConserveSUID
end