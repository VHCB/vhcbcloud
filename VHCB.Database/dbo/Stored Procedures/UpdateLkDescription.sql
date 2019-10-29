
CREATE procedure [dbo].[UpdateLkDescription]
(
	@recordId int,
	@lkDescription varchar (40),
	@isActive bit,
	@isTiered bit,
	@isOrdered bit
)
as
begin
	update lklookups set LKDescription = @lkDescription, RowIsActive = @isActive, tiered = @isTiered, Ordered = @isOrdered
	where RecordID = @recordId	
end