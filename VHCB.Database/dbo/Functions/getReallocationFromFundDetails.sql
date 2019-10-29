CREATE function dbo.getReallocationFromFundDetails(@projId int, @transType int, @activeOnly int)
RETURNS  @rtnTable TABLE 
(
    TransID bigint,
    FromFundName nvarchar(255),
	FromTransType nvarchar(255),
	FromTransTypeId int,
	FromLandusePermitId nvarchar(255)
)
AS 
BEGIN
	
	if  (@activeOnly=1)
	begin	
		insert into @rtnTable
		select distinct tr.TransId, f.name, lv.Description, d.LkTransType, af.UsePermit
		from Trans tr 
		join detail d on tr.transid = d.transid and d.amount < 0
		join fund f on f.fundid = d.fundid
		join LookupValues lv on lv.TypeID = d.LkTransType
		left join Act250Farm af on af.Act250FarmID = d.landusepermitid
		where tr.ProjectID = @projId and tr.LkStatus = 261 and tr.LkTransaction = @transType and  tr.RowIsActive= 1
	end
	else
	begin
	insert into @rtnTable
		select distinct tr.TransId, f.name, lv.Description, d.LkTransType, af.UsePermit
		from Trans tr 
		join detail d on tr.transid = d.transid and d.amount < 0
		join fund f on f.fundid = d.fundid
		join LookupValues lv on lv.TypeID = d.LkTransType
		left join Act250Farm af on af.Act250FarmID = d.landusepermitid
		where tr.ProjectID = @projId and tr.LkStatus = 261 and tr.LkTransaction = @transType 
	end

return
END