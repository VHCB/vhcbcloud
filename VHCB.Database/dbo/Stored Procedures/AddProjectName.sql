
create procedure dbo.AddProjectName
(
	@ProjectId	int,
	@projName	varchar(75),
	@DefName	bit
) as
begin transaction

	begin try
	declare @recordId int
	declare @nameId as int
	declare @ProjectNameID int

	select  @recordId = RecordID from LkLookups where Tablename = 'LkProjectName' 
	
	insert into LookupValues(LookupType, Description)
	values (@recordId, @projName)

	set @nameId = @@IDENTITY

	insert into ProjectName (ProjectID, LkProjectname, DefName)
	values (@ProjectId, @nameId, @DefName)

	set @ProjectNameID = @@IDENTITY

	if(@DefName = 1)
	begin
	 update ProjectName set DefName = 0 where ProjectId = @ProjectId and ProjectNameID != @ProjectNameID
	end

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