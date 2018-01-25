
create procedure dbo.GetACForms
(
	@Groupnum		int
) as
begin
	select ACFormID, Name 
	from acforms where Groupnum = @Groupnum and RowIsActive = 1
end