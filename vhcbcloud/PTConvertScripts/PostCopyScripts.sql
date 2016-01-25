USE PTConvert
GO
TRUNCATE TABLE  Applicant
TRUNCATE TABLE  ApplicantAppName
truncate table ApplicantContact
truncate table [dbo].[AppName]
truncate table [dbo].[Contact]
truncate table [dbo].[Project]
truncate table [dbo].[ProjectApplicant]
truncate table [dbo].[ProjectContact]
truncate table [dbo].[ProjectName]

delete from  Applicant
delete from  ApplicantAppName
delete from ApplicantContact
delete from [dbo].[AppName]
delete from [dbo].[Contact]
delete from [dbo].[Project]
delete from [dbo].[ProjectApplicant]
delete from [dbo].[ProjectContact]
delete from [dbo].[ProjectName]
delete from [LookupValues] where [LookupType] = 118

--select * from project
--select * from AppName
--select * from Contact
--select * from ptprojectvhcb$ 
--select * from [dbo].[LookupValues]
--select * from ptorgs$
--select * from leadorgs$
--select * from [dbo].[LookupValues]
--select * from [dbo].[leadorgsvhcb$] where Contact =1
--select * from [LookupValues] where [LookupType] = 118
--select * from [ProjectApplicant]
--select * from [ProjectContact]
--select * from [ProjectName]
--select * from Applicant
--select * from ApplicantAppName
--select * from AppName

----------------------------------------------------------------------------------------------------

insert into Project (Proj_num )
select number  from ptprojectvhcb$ where number is not null

insert into Project (Proj_num )
select distinct tl.[pnumber] from [dbo].[translead$] tl join [dbo].[leadprojectsvhcb$]
 lp on tl.[proj_key] = lp.[key] where pnumber is not null
 
create table #temp (name varchar(max), number varchar (12))
insert into #temp (name, number)

 select distinct lp.name as name, tl.pnumber as number from [dbo].[translead$] tl join [dbo].[leadprojectsvhcb$]
 lp on tl.[proj_key] = lp.[key] where lp.name is not null
 
 insert into #temp (name, number)
 select distinct name as name,number as number from ptprojectvhcb$ where name is not null

insert into [LookupValues] ([LookupType],[Description], pnumber)
select 118, name, number from #temp
--select * from #temp

insert into AppName(Applicantname, ApplicantAbbrv)
select org, abbrv from [dbo].[leadorgsvhcb$] 

insert into AppName(Applicantname, ApplicantAbbrv)
select [name], abbrv from [dbo].[ptorgsvhcb$]

insert into ApplicantAppName(ApplicantID, AppNameID)
select [AppNameID], [AppNameID] from [dbo].[AppName]

insert into [dbo].[Applicant]([ApplicantId])
select ApplicantID from ApplicantAppName


insert into [dbo].[Contact]([Firstname],[Lastname])
select dbo.fnFirstName(org), dbo.fnLastName(org) from [dbo].[leadorgsvhcb$] where Contact =1

insert into [dbo].[Contact]([Firstname],[Lastname])
select dbo.fnFirstName([name]), dbo.fnLastName(name) from [dbo].[ptorgsvhcb$] where Contact = 1

insert into [dbo].[ProjectName] ([LkProjectname],[ProjectID])
 select distinct lv.TypeID, p.ProjectId  from
 [dbo].[LookupValues] lv 
 join
 Project p on p.[Proj_num] = lv.pnumber
 where lv.LookupType = 118
 
 
 
 drop table #temp
