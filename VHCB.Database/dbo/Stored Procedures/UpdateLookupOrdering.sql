
CREATE procedure UpdateLookupOrdering
(	
	@ordering int,
	@typeid int
)
as
Begin
	update LookupValues set ordering = @Ordering  where TypeID = @typeId;
End