use vhcb
go

DECLARE @act250FarmID int, @AntFunds decimal

declare NewCursor Cursor for
select act250FarmID, AntFunds 
from act250Farm
	

	open NewCursor
	fetch next from NewCursor into @act250FarmID, @AntFunds
	WHILE @@FETCH_STATUS = 0
	begin

	declare @AmtRecFunds decimal
	select @AmtRecFunds = sum(isnull(AmtRec, 0))
	from  Act250DevPay (nolock)
	where Act250FarmID = @act250FarmID and RowIsActive = 1

	if(@AntFunds != @AmtRecFunds)
	begin
		update act250Farm set AntFunds = @AmtRecFunds where Act250FarmID = @act250FarmID
		print 'updated'
	end

	FETCH NEXT FROM NewCursor INTO  @act250FarmID, @AntFunds
	END

Close NewCursor
deallocate NewCursor
go

--select * into act250Farm_backup_10112020 from act250Farm
--select * from act250Farm_backup_10112020

