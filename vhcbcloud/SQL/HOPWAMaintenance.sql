use VHCBSandbox
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[GetHOPWAMasterList]') and type in (N'P', N'PC'))
drop procedure [dbo].GetHOPWAMasterList
go

create procedure dbo.GetHOPWAMasterList
(
	@IsActiveOnly	bit
) as
--GetHOPWAMasterList 1
begin transaction

	begin try

	select HOPWAID, UUID, HHincludes, PrimaryASO, lv.description as PrimaryASOST,  WithHIV, InHousehold, Minors, Gender, Age, Ethnic, 
		Race, GMI, AMI, Beds, Notes, hm.RowisActive, hm.DateModified
	from HOPWAMaster hm(nolock) 
	join lookupvalues lv(nolock) on hm.PrimaryASO = lv.TypeID
	where (@IsActiveOnly = 0 or hm.RowIsActive = @IsActiveOnly)
		order by hm.DateModified desc

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

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[AddHOPWAMaster]') and type in (N'P', N'PC'))
drop procedure [dbo].AddHOPWAMaster
go

create procedure dbo.AddHOPWAMaster
(
	@UUID			nvarchar(6), 
	@HHincludes		nchar(6), 
	@PrimaryASO		int, 
	@WithHIV		int, 
	@InHousehold	int, 
	@Minors			int, 
	@Gender			int, 
	@Age			int, 
	@Ethnic			int, 
	@Race			int, 
	@GMI			money, 
	@AMI			money, 
	@Beds			int, 
	@Notes			nvarchar(max),
	@isDuplicate	bit output,
	@isActive		bit Output
) as
begin transaction

	begin try
	set @isDuplicate = 1
	set @isActive = 1
	
	if not exists
    (
		select 1 
		from HOPWAMaster(nolock)
		where UUID = @UUID 
	)
	begin

		insert into HOPWAMaster(UUID, HHincludes, PrimaryASO, WithHIV, InHousehold, Minors, Gender, Age, 
			Ethnic, Race, GMI, AMI, Beds, Notes)
		values(@UUID, @HHincludes, @PrimaryASO, @WithHIV, @InHousehold, @Minors, @Gender, @Age, 
			@Ethnic, @Race, @GMI, @AMI, @Beds, @Notes)

		set @isDuplicate = 0
	end

	if(@isDuplicate = 1)
	begin
		select @isActive =  RowIsActive 
		from HOPWAMaster(nolock)
		where  UUID = @UUID 
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
go

if  exists (select * from sys.objects where object_id = object_id(N'[dbo].[UpdateHOPWAMaster]') and type in (N'P', N'PC'))
drop procedure [dbo].UpdateHOPWAMaster
go

create procedure dbo.UpdateHOPWAMaster
(
	@HOPWAID		int, 
	@HHincludes		nchar(6), 
	@PrimaryASO		int, 
	@WithHIV		int, 
	@InHousehold	int, 
	@Minors			int, 
	@Gender			int, 
	@Age			int, 
	@Ethnic			int, 
	@Race			int, 
	@GMI			money, 
	@AMI			money, 
	@Beds			int,  
	@Notes			nvarchar(max),
	@IsRowIsActive	bit
) as
begin transaction

	begin try

	update HOPWAMaster set HHincludes = @HHincludes, PrimaryASO = @PrimaryASO, WithHIV = @WithHIV, InHousehold = @InHousehold, 
		Minors = @Minors, Gender = @Gender, Age = @Age, Ethnic = @Ethnic, Race = @Race, GMI = @GMI, AMI = @AMI, Beds = @Beds, Notes = @Notes, 
		RowIsActive = @IsRowIsActive, DateModified = getdate()
	from HOPWAMaster
	where HOPWAID = @HOPWAID
	
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