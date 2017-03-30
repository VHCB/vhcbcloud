
alter procedure [dbo].[GetLookupsViewname]
(
 @flagActive bit
)
as
begin
	select RecordID, Viewname from lklookups
	where Standard = 1 and RowIsActive = @flagActive
	order by Viewname asc
end
go

alter procedure [dbo].[UpdateLkDescription]
(
	@recordId int,
	@lkDescription varchar (40),
	@isActive bit,
	@isTiered bit,
	@isOrdered bit
)
as
begin
	update lklookups set LKDescription = @lkDescription, RowIsActive = @isActive, 
		tiered = @isTiered, ordered = @isOrdered
	where RecordID = @recordId	
end
go

alter procedure [dbo].[GetLookupsById]
(
	@recordId int
)
as
begin
	select RecordID, Viewname, LKDescription, Standard, Ordered, Tiered, RowIsActive from lklookups
	where RecordID = @recordId	
end
go

alter procedure [dbo].[GetLookupsViewname]
(
 @flagActive bit
)
as
begin
	select RecordID, Viewname from lklookups
	where Standard = 1 and RowIsActive = @flagActive
	order by Viewname asc
end
go

alter procedure [dbo].[GetLkLookupDetails]
(
	 @recordId int,
	 @IsActiveOnly	bit
 )
as
begin
	if (@recordId = 0)
	begin
		select lv.TypeID, lk.RecordID, lk.Tablename, lk.Viewname, lk.lkDescription, lv.Description, lk.Standard, lv.RowIsActive, lv.Ordering, lk.Tiered
		from LkLookups lk join LookupValues lv on lv.LookupType = lk.RecordID	
		where (@IsActiveOnly = 0 or lv.RowIsActive = @IsActiveOnly)
		order by lk.Ordered desc, lk.Viewname asc
	end
	else
	Begin
		select lv.TypeID, lk.RecordID, lk.Tablename, lk.Viewname, lk.lkDescription, lv.Description, lk.Standard, lv.RowIsActive, lv.Ordering, lk.Tiered
		from LkLookups lk join LookupValues lv on lv.LookupType = lk.RecordID	
		where lk.RecordID = @recordId 
		and (@IsActiveOnly = 0 or lv.RowIsActive = @IsActiveOnly)
		order by lk.Ordered desc, lk.Viewname asc
	end
end
go

alter procedure AddLookupSubValues
(
	@typeId int,
	@subDescription varchar (100)
)
as
Begin
	insert into LookupSubValues(typeid,SubDescription)
	values (@typeId, @subDescription)
End
go

alter procedure [dbo].GetLkLookupSubValues
(
	 @typeId int,
	 @IsActiveOnly	bit
 )
as
begin
		select lv.TypeID, lsv.subtypeid, lv.Description,lv.RowIsActive, lsv.SubDescription
		from LookupValues lv join LookupSubValues lsv on lv.TypeID = lsv.TypeID	
		where lsv.RowIsActive = @IsActiveOnly and lv.typeid = @typeid
		order by lsv.SubDescription asc, lv.Description asc
	
End
go


alter procedure DeleteLkSubValues
(
	@subtypeid int
)
as
Begin
	Delete from lookupsubvalues  where subtypeid = @subtypeid
end
go

alter  procedure [dbo].[updateLookups]
(
	@typeId int,
	@description varchar(50),
	@lookupTypeid int,	
	@isActive bit,
	@isOrdering int
)
as
--exec updatelookups 97, 'Prime soils', 272, 1, 1
begin transaction

	begin try
		update LookupValues set Description = @description, ordering = @isOrdering, RowIsActive=@isActive where TypeID = @typeId;
		--update LkLookups set  RowIsActive=@isActive, Ordered = @isOrdered  where RecordID = @lookupTypeid;
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

go

alter procedure [dbo].[UpdateLkDescription]
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
go