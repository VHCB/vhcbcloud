

CREATE procedure [dbo].[UpdateFundType]
(
	@description varchar(100),
	@active bit,
	@typeid int
)
as
Begin

	update LkFundType set description=@description, RowIsActive=@active
	where TypeID = @typeid
end