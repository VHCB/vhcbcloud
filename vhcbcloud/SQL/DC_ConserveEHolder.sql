use PTConvert
go


truncate table VHCb.dbo.conserveeholder
go

insert into VHCb.dbo.conserveeholder(ConserveID, ApplicantId)
select c.ConserveID,  aan.ApplicantID
from ptorganizations org(nolock)
join pteholders hold(nolock) on hold.orgkey = org.[key]
join MasterProj p1(nolock) on p1.[key] = hold.projkey
---oin ptapplctn ap(nolock) on ap.projkey = p1.[key]
join VHCb.dbo.AppName an(nolock) on an.ApplicantAbbrv = org.abbrv
join VHCB.dbo.applicantappname aan(nolock) on aan.AppNameID = an.AppNameID
join vhcb.dbo.conserve c(nolock) on c.ProjectID = p1.ProjectId
order by org.abbrv desc


select * from VHCb.dbo.conserveeholder 

--ALTER TABLE dbo.ptorganizations ALTER COLUMN abbrv nvarchar (255)  
--            COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL;

--select * from [dbo].[pteholders]
--select * from ptorganizations 
--select * from MasterProj
--select * from ptapplctn
--select * from ptconsacres
--select * from VHCb.dbo.AppName
--select * from VHCB.dbo.applicantappname 



--select * from vhcb.dbo.conserve