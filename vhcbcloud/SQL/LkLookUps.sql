
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
	@isTiered bit
)
as
begin
	update lklookups set LKDescription = @lkDescription, RowIsActive = @isActive, tiered = @isTiered
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
		select lv.TypeID, lk.RecordID, lk.Tablename, lk.Viewname, lk.lkDescription, lv.Description, lk.Standard, lv.RowIsActive, lk.Ordered, lk.Tiered
		from LkLookups lk join LookupValues lv on lv.LookupType = lk.RecordID	
		where (@IsActiveOnly = 0 or lv.RowIsActive = @IsActiveOnly)
		order by lk.Viewname asc, lv.Description asc
	end
	else
	Begin
		select lv.TypeID, lk.RecordID, lk.Tablename, lk.Viewname, lk.lkDescription, lv.Description, lk.Standard, lv.RowIsActive, lk.Ordered, lk.Tiered
		from LkLookups lk join LookupValues lv on lv.LookupType = lk.RecordID	
		where lk.RecordID = @recordId 
		and (@IsActiveOnly = 0 or lv.RowIsActive = @IsActiveOnly)
		order by   lv.Description asc
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