create procedure [dbo].[GetAssignmentByGuid]
(	
	@fromProjId int
	,@reallocateGuid varchar(50)
)
as
Begin	
	
	declare  @temp table ( transid int, toProjId int, projGuid varchar(100) )
	insert into @temp (transid, toProjId, projGuid)
	select FromTransID, ToProjectId,ReallocateGUID  from ReallocateLink where FromProjectId = @fromProjId and ReallocateGUID = @reallocateGuid
	insert into @temp (transid, toProjId, projGuid)
	select ToTransID, ToProjectId, ReallocateGUID from ReallocateLink  where FromProjectId = @fromProjId  and ReallocateGUID = @reallocateGuid

	declare @tblDistinct  table (transid int, projGuid varchar(100))
	insert into @tblDistinct (transid, projGuid)
	select distinct transid, projguid from @temp
	

	Select t.projectid, p.proj_num, d.detailid, f.FundId, f.account, f.name, format(d.Amount, 'N2') as amount, lv.Description, d.LkTransType, t.LkTransaction,t.TransId
		, td. projGuid, t.datemodified
	
	 from Fund f 
		join Detail d on d.FundId = f.FundId
		join Trans t on t.TransId = d.TransId
		join project p on p.projectid = t.projectid
		join LookupValues lv on lv.TypeID = d.LkTransType
		join @tblDistinct td on td.transid = t.transid
	Where     f.RowIsActive=1 and t.LkTransaction = 26552	
	and t.TransId in(select distinct transid from @temp)
	--and p.ProjectId in (select distinct toprojid from #temp)
	order by d.DateModified desc

End