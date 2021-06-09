alter view FinalViabConversionApplicant_v
as

select p.Projectid, SUBSTRING([Project Name], 0, PATINDEX('%-%', [Project Name])) as 'ProjectName', [Convert],
[FarmName/Primary applicant] OrganizationName, LKEntityType, LKEntityType2,
[FirstName], [Lastname],
case when len(RIGHT(replace(replace(replace([PhoneHome], '-', ''), '(', ''), ')', ''), 10)) = 10 or len(RIGHT(replace(replace(replace([PhoneHome], '-', ''), '(', ''), ')', ''), 7)) = 7  then replace(replace(replace([PhoneHome], '-', ''), '(', ''), ')', '') else null end [PhoneHome], 
case when len(RIGHT(replace(replace(replace([PhoneWork], '-', ''), '(', ''), ')', ''), 10)) = 10 or len(RIGHT(replace(replace(replace([PhoneWork], '-', ''), '(', ''), ')', ''), 7)) = 7  then replace(replace(replace([PhoneWork], '-', ''), '(', ''), ')', '') else null end [PhoneWork], 
case when len(RIGHT(replace(replace(replace([PhoneCell], '-', ''), '(', ''), ')', ''), 10)) = 10 or len(RIGHT(replace(replace(replace([PhoneCell], '-', ''), '(', ''), ')', ''), 7)) = 7  then replace(replace(replace([PhoneCell], '-', ''), '(', ''), ')', '')else null end [PhoneCell], 
[Email],
case when ISNUMERIC(SUBSTRING(Address1, 0, PATINDEX('% %', Address1))) = 1 then SUBSTRING(Address1, 0,PATINDEX('% %', Address1)) else '' end as 'StreetNo',
case when ISNUMERIC(SUBSTRING(Address1, 0,PATINDEX('% %', Address1))) = 1 then rtrim(ltrim(SUBSTRING(Address1, len(SUBSTRING(Address1, 0, PATINDEX('% %', Address1))) + 1, Len(Address1)))) 
else Address1 end as 'Address1', Address2, Town, State, Zip, County,
[Yr began managing business - replace AL column] as YrManageBus, [EnvelopeName-OtherName] as OtherNames, [PrimaryProduct],
OutOFBiz, OutOFBizComment, Organic, Conserved, Transfer, OnFarmProc, LCB, AcresOwned, AcresLeased, AcresLeasedOut, [Acres from Access], AcresInProduction, YearsManagingFarm
from dbo.Project p(nolock)
join dbo.Final_Viab_Conversion v on v.[Project #] = p.Proj_num

go

select ProjectName, count(*) from FinalViabConversionApplicant_v
group by ProjectName
having count(*) > 1

select * from FinalViabConversionApplicant_v
where ProjectName = 'McAllister'

select distinct LkEntityType from dbo.Final_Viab_Conversion