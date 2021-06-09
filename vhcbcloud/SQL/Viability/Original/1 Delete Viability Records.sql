use VHCB
go


select  * from vhcb.dbo.Final_Viab_Conversion where [Project #] not like '8387%'

select * from EnterpriseAttributes where projectid in (select projectid from project where Proj_num in(select [Project #] from vhcb.dbo.Final_Viab_Conversion where [Project #] not like '8387%'))
--1064
select * from projectaddress where projectid in (select projectid from project where Proj_num in(select [Project #] from vhcb.dbo.Final_Viab_Conversion where [Project #] not like '8387%'))
--1343

select * from lookupvalues where [Description] in (select v.[Project Name] as ProjName from dbo.Project p(nolock) join dbo.Final_Viab_Conversion v on v.[Project #] = p.Proj_num)
--751
select * from dbo.projectname where projectid in (select projectid from project where Proj_num in(select [Project #] from vhcb.dbo.Final_Viab_Conversion where [Project #] not like '8387%'))
--751
select * from ProjectRelated  where Relprojectid in (select projectid from project where Proj_num in(select [Project #] from vhcb.dbo.Final_Viab_Conversion where [Project #] not like '8387%'))
--0

select * from applicantaddress where Addressid in (select projectid from project where Proj_num in(select [Project #] from VHCB.dbo.Final_Viab_Conversion where [Project #] not like '8387%'))
--26
select * from ApplicantApplicant where applicantid in(select applicantid from ProjectApplicant where projectid in (select projectid from project where Proj_num in(select [Project #] from vhcb.dbo.Final_Viab_Conversion where [Project #] not like '8387%')))
--0
select * from applicantappname where applicantid in(select applicantid from ProjectApplicant where projectid in (select projectid from project where Proj_num in(select [Project #] from vhcb.dbo.Final_Viab_Conversion where [Project #] not like '8387%')))
--0
select * from appname where appnameId in(select appnameId from applicantappname where applicantid in(select applicantid from ProjectApplicant where projectid in (select projectid from project where Proj_num in(select [Project #] from vhcb.dbo.Final_Viab_Conversion where [Project #] not like '8387%'))))
--0
select * from Contact where contactId in(select ContactID from applicantcontact where applicantid in(select applicantid from ProjectApplicant where projectid in (select projectid from project where Proj_num in(select [Project #] from vhcb.dbo.Final_Viab_Conversion where [Project #] not like '8387%'))))
--0
select * from applicantcontact where applicantid in(select applicantid from ProjectApplicant where projectid in (select projectid from project where Proj_num in(select [Project #] from vhcb.dbo.Final_Viab_Conversion where [Project #] not like '8387%')))
--0

select * from ProjectApplicant where projectid in (select projectid from project where Proj_num in(select [Project #] from vhcb.dbo.Final_Viab_Conversion where [Project #] not like '8387%'))
select * from Dbo.project where Proj_num in(select [Project #] from vhcb.dbo.Final_Viab_Conversion where [Project #] not like '8387%')



delete from EnterpriseAttributes where projectid in (select projectid from project where Proj_num in(select [Project #] from VHCB.dbo.Final_Viab_Conversion where [Project #] not like '8387%'))
--delete from Address where addressId in (select AddressId from projectaddress where  projectid in (select projectid from project where Proj_num in(select [Project #] from VHCB.dbo.Final_Viab_Conversion where [Project #] not like '8387%')))
delete from projectaddress where projectid in (select projectid from project where Proj_num in(select [Project #] from VHCB.dbo.Final_Viab_Conversion where [Project #] not like '8387%'))
delete from lookupvalues where [Description] in (select v.[Project Name] as ProjName from dbo.Project p(nolock) join dbo.Final_Viab_Conversion v on v.[Project #] = p.Proj_num)
delete from dbo.projectname where projectid in (select projectid from project where Proj_num in(select [Project #] from VHCB.dbo.Final_Viab_Conversion where [Project #] not like '8387%'))
delete from ProjectRelated  where Relprojectid in (select projectid from project where Proj_num in(select [Project #] from VHCB.dbo.Final_Viab_Conversion where [Project #] not like '8387%'))

begin tran

delete from ApplicantApplicant where applicantid in(select applicantid from ProjectApplicant where projectid in (select projectid from project where Proj_num in(select [Project #] from VHCB.dbo.Final_Viab_Conversion where [Project #] not like '8387%')))
delete from applicantaddress where Addressid in (select projectid from project where Proj_num in(select [Project #] from VHCB.dbo.Final_Viab_Conversion where [Project #] not like '8387%'))
delete from appname where appnameId in(select appnameId from applicantappname where applicantid in(select applicantid from ProjectApplicant where projectid in (select projectid from project where Proj_num in(select [Project #] from VHCB.dbo.Final_Viab_Conversion where [Project #] not like '8387%'))))
delete from applicantappname where applicantid in(select applicantid from ProjectApplicant where projectid in (select projectid from project where Proj_num in(select [Project #] from VHCB.dbo.Final_Viab_Conversion where [Project #] not like '8387%')))


delete from Contact where contactId in(select ContactID from applicantcontact where applicantid in(select applicantid from ProjectApplicant where projectid in (select projectid from project where Proj_num in(select [Project #] from vhcb.dbo.Final_Viab_Conversion where [Project #] not like '8387%'))))

delete from applicantcontact where applicantid in(select applicantid from ProjectApplicant where projectid in (select projectid from project where Proj_num in(select [Project #] from VHCB.dbo.Final_Viab_Conversion where [Project #] not like '8387%')))

rollback
commit

delete from ProjectApplicant where projectid in (select projectid from project where Proj_num in(select [Project #] from VHCB.dbo.Final_Viab_Conversion where [Project #] not like '8387%'))

delete from Dbo.project where Proj_num in(select [Project #] from VHCB.dbo.Final_Viab_Conversion where [Project #] not like '8387%')


--delete from ProjectApplicant where DateModified > '2018-10-14 20:24:59.140'
--select * from Address where DateModified > '2018-10-14 23:24:59.140' order by 1 desc

delete  from ApplicantApplicant where DateModified > getdate() - 1
--670

select * from Address where Street# = 414 and Address1 = 'Cilley Hill Road'

select * from Address where Addressid > 8574
