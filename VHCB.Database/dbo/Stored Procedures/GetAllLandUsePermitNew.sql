CREATE procedure GetAllLandUsePermitNew
 (
	 @FundId int
 )
as
begin
	
	if(@FundId = 420)
	begin
		select distinct af.UsePermit, af.Act250FarmId
		from Act250Farm af 
		where af.RowIsActive = 1 and af.type = 145
	end
	else if(@FundId = 415)
	begin
		select distinct af.UsePermit, af.Act250FarmId
		from Act250Farm af 
		where af.RowIsActive = 1 and af.type = 144
	end
end