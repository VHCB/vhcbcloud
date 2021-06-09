use VHCB
go

begin tran

insert into FederalProjectInspection(ProjectFederalID, InspectDate, InspectLetter,RespDate, RespNotNeed)
select pf.ProjectFederalID, [Date of Inspection], [Date Letter Sent] , [Date of Response], isnull([No Response Needed], 0)
from FedInspections fi(nolock)
join project p(nolock) on p.proj_num = fi.[Project Number]
join ProjectFederal pf(nolock) on pf.ProjectID = p.ProjectId

commit
