CREATE procedure GetAllFundsByProjectProgram
(
	@ProjectId int
)
as
Begin
--exec GetAllFundsByProjectProgram 6586
	declare @LkProgram int
	select @LkProgram = LkProgram from project (nolock) where ProjectId = @ProjectId

	select f.FundId, f.name, f.account 
	from Fund f (nolock)
	where f.MitFund = 0 and f.RowIsActive = 1
	union
	select f.FundId, f.name, f.account 
	from Fund f (nolock)
	where f.MitFund = 1 and LkProgram = @LkProgram and f.RowIsActive = 1
	order by f.name
end