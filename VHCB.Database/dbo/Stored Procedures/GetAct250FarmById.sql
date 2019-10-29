
create procedure GetAct250FarmById  
(
	@Act250FarmID	int
)
as
begin
--exec GetAct250FarmsList 1
	select UsePermit, LkTownDev, CDist, Type, DevName, Primelost, Statelost, TotalAcreslost, 
		AcresDevelop, Developer, convert(varchar(10), AntFunds) AntFunds, MitDate, URL, RowIsActive
	from  Act250Farm act250(nolock)
	where Act250FarmID = @Act250FarmID
	order by act250.DateModified desc
end