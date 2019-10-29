
create procedure GetAct250FarmsList  
(
	@IsActiveOnly	bit
)
as
begin
--exec GetAct250FarmsList 1
	select act250.Act250FarmID, act250.UsePermit, act250.LkTownDev, lv.Description 'Town of Development', act250.CDist, act250.Type, 
		lv2.description as 'farmType',
		act250.DevName, act250.Primelost, act250.Statelost, act250.TotalAcreslost, 
		act250.AcresDevelop, act250.Developer, an.ApplicantName as 'DeveloperName', act250.AntFunds, act250.MitDate, 
		act250.RowIsActive, act250.DateModified, act250.URL, 
		CASE when isnull(act250.URL, '') = '' then '' else 'Click here' end as URLText
	from  Act250Farm act250(nolock)
	left join LookupValues lv(nolock) on lv.TypeID = act250.LkTownDev
	left join LookupValues lv2(nolock) on lv2.TypeID = act250.Type
	left join applicantappname aan(nolock) on act250.Developer = aan.applicantid
	left join appname an(nolock) on aan.appnameid = an.appnameid
	where (@IsActiveOnly = 0 or act250.RowIsActive = @IsActiveOnly)
	order by act250.DateModified desc
end