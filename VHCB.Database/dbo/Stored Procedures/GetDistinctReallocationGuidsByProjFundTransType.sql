

CREATE procedure [dbo].GetDistinctReallocationGuidsByProjFundTransType
(	
	@fromProjId int,
	@fundId int,
	@transTypeId int,
	@dateModified date
)
as
Begin	
	
	declare  @temp table ( transid int, toProjId int, projGuid varchar(100) )
	insert into @temp (transid, toProjId, projGuid)
	select FromTransID, ToProjectId, ReallocateGUID from ReallocateLink where FromProjectId = @fromProjId 
	insert into @temp (transid, toProjId, projGuid)
	select ToTransID, ToProjectId, ReallocateGUID from ReallocateLink  where FromProjectId = @fromProjId 

	declare @tblDistinct  table (transid int, projGuid varchar(100))
	insert into @tblDistinct (transid, projGuid)
	select distinct transid, projguid from @temp
	
	Select distinct td.projguid
		 from Fund f 
		join Detail d on d.FundId = f.FundId
		join Trans t on t.TransId = d.TransId
		join project p on p.projectid = t.projectid
		join LookupValues lv on lv.TypeID = d.LkTransType
		join @tblDistinct td on td.transid = t.TransId	
	Where     f.RowIsActive=1 and t.LkTransaction = 240 and t.lkstatus = 261
	and f.fundid = @fundid and d.lktranstype = @transTypeId
	and t.TransId in(select distinct transid from @temp)
	and CONVERT(VARCHAR(101),t.datemodified,110)   =  CONVERT(VARCHAR(101),@dateModified,110) 
	

End