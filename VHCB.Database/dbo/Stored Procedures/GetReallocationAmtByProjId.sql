CREATE procedure [dbo].[GetReallocationAmtByProjId]
(	
	@fromProjId int
	
)
as
Begin	
	
	create table #temp ( transid int, toProjId int )
	insert into #temp (transid, toProjId)
	select FromTransID, ToProjectId from ReallocateLink where FromProjectId = @fromProjId
	insert into #temp (transid, toProjId)
	select ToTransID, ToProjectId from ReallocateLink  where FromProjectId = @fromProjId

	Select  format(sum(d.Amount), 'N2') as amount  from Fund f 
		join Detail d on d.FundId = f.FundId
		join Trans t on t.TransId = d.TransId
		join project p on p.projectid = t.projectid
		join LookupValues lv on lv.TypeID = d.LkTransType
	Where     f.RowIsActive=1 and t.LkTransaction = 240 and d.amount > 0  and t.lkstatus = 261
	and t.TransId in(select distinct transid from #temp)
	group by LkTransaction	 
	

End