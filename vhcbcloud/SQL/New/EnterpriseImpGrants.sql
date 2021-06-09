use vhcb
go

select * from dbo.EnterpriseImpGrants

begin tran

insert into [dbo].[EnterpriseImpGrants](ProjectID, FYGrantRound, ProjTitle, ProjCost, Request, AwardAmt, Comments)
select p.ProjectID, [FYGrantRound], SUBSTRING([ImpGrantProjTitle], 0 , 80), isnull([ImpGrantProjCost], 0), isnull([ImpGrantProjReq], 0), isnull([ImpGrantAmount], 0), rtrim(ltrim([ImpGrantComment]))
from  [FFVConvert].dbo.ImpGrants g(nolock)
join project p(nolock) on g.[PROJECT NUMBER]  = p.proj_num

--rollback

--select max(len( [ImpGrantProjTitle]))
--from  [FFVConvert].dbo.ImpGrants g(nolock)
--join project p(nolock) on g.[PROJECT NUMBER]  = p.proj_num