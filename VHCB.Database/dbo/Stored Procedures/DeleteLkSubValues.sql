

CREATE procedure DeleteLkSubValues
(
	@subtypeid int
)
as
Begin
	Delete from lookupsubvalues  where subtypeid = @subtypeid
end