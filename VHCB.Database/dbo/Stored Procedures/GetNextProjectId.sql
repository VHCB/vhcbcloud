
create procedure dbo.GetNextProjectId
(
	@Proj_num			varchar(50),
	@Action				int, --1: Next 2:Previous
	@ReturnProjectId	int output
)
as
begin transaction
--exec GetNextProjectId '0000-000-000', 1, null
	begin try
	
	create table #Temp
	(
		RowNumber	int, 
		Proj_num	varchar(50),
		ProjectId	int
	)

	declare @CurrentRowNumber int

	insert into #Temp 
	select row_number() over (order by Proj_num) as RowNumber, Proj_num, ProjectId
	from project

	--select * from #Temp
	select @CurrentRowNumber = RowNumber from #Temp where Proj_num = @Proj_num

	if(@Action = 1)
	begin
		declare @MaxRowNumber int
		select @MaxRowNumber = max(RowNumber) from #Temp

		if(@CurrentRowNumber + 1 <= @MaxRowNumber)
			select @ReturnProjectId = ProjectId from #Temp where RowNumber = @CurrentRowNumber + 1
		else
			select @ReturnProjectId = ProjectId from #Temp where RowNumber = @CurrentRowNumber
	end
	else
	begin
		declare @MinRowNumber int
		select @MinRowNumber = min(RowNumber) from #Temp
		--select @MinRowNumber
		--select @CurrentRowNumber 'Current'
		if(@CurrentRowNumber - 1 < @MinRowNumber)
			select @ReturnProjectId = ProjectId from #Temp where RowNumber = @CurrentRowNumber
		else
			select @ReturnProjectId = ProjectId from #Temp where RowNumber = @CurrentRowNumber - 1
	end

	drop table #Temp

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