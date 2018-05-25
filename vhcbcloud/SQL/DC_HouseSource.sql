use PTConvert
go

--select * from VHCB.dbo.HouseSU
----4612
--select * from VHCB.dbo.HouseSource
----6053
truncate table VHCB.dbo.HouseSource
delete from VHCB.dbo.HouseSU

DECLARE @HouseSUID as int, @HousingID as int,
	@hsvhcb as int, @hsfeas as int, @hslead as int, @hsfed as int, @hscdbg as int, @hsvhfa as int, @hsvclf as int, @hsbank as int, @hsothfn as int, @hstxcr as int, @hsoth as int, @huvacq as int, @huvrcost as int, @huvrmang as int, 
	@huvrsite as int, @huvrap as int, @huvrhm as int, @huvrcon as int, @huvroth as int, @huvccost as int, @huvcmang as int, @huvcsite as int, @huvcap as int, @huvchm as int, @huvccon as int, @huvcoth as int, @huvdev as int, 
	@huvsfee as int, @huvspf as int, @huvsmk as int, @huvsfn as int, @huvscon as int, @huvsre as int, @huvsoth as int, @huvreserve as int, @huvad as int, @huvoth as int, @huoacq as int, @huorcost as int, @huormang as int, 
	@huorsite as int, @huorap as int, @huorhm as int, @huorcon as int, @huoroth as int, @huoccost as int, @huocmang as int, @huocsite as int, @huocap as int, @huochm as int, @huoccon as int, @huocoth as int, @huodev as int, 
	@huosfee as int, @huospf as int, @huosmk as int, @huosfn as int, @huoscon as int, @huosre as int, @huosoth as int, @huoreserve as int, @huoad as int, @huooth  as int

declare NewCursor Cursor for
select h.HousingID, 
	hsvhcb, hsfeas, hslead, hsfed, hscdbg, hsvhfa, hsvclf, hsbank, hsothfn, hstxcr, hsoth
from VHCB.dbo.Housing h(nolock)
join MasterProj mp(nolock) on h.ProjectID = mp.ProjectId
join pthousingsu su(nolock) on su.projkey = mp.[key]


open NewCursor
	fetch next from NewCursor into @HousingID, 
	@hsvhcb, @hsfeas, @hslead, @hsfed, @hscdbg, @hsvhfa, @hsvclf, @hsbank, @hsothfn, @hstxcr, @hsoth
	WHILE @@FETCH_STATUS = 0
	begin

	insert into VHCB.dbo.HouseSU(LkBudgetPeriod, HousingId, MostCurrent) values(26083, @HousingID, 1)

	set @HouseSUID =  SCOPE_IDENTITY()

	if(@hsvhcb <> 0)
	insert into VHCB.dbo.HouseSource(HouseSUID, LkHouseSource, Total) values(@HouseSUID, 516, @hsvhcb)

	if(@hsfeas <> 0)
	insert into VHCB.dbo.HouseSource(HouseSUID, LkHouseSource, Total) values(@HouseSUID, 517, @hsfeas)

	if(@hslead <> 0)
	insert into VHCB.dbo.HouseSource(HouseSUID, LkHouseSource, Total) values(@HouseSUID, 518, @hslead)

	if(@hsfed <> 0)
	insert into VHCB.dbo.HouseSource(HouseSUID, LkHouseSource, Total) values(@HouseSUID, 26499, @hsfed)

	if(@hscdbg <> 0)
	insert into VHCB.dbo.HouseSource(HouseSUID, LkHouseSource, Total) values(@HouseSUID, 519, @hscdbg)

	if(@hsvhfa <> 0)
	insert into VHCB.dbo.HouseSource(HouseSUID, LkHouseSource, Total) values(@HouseSUID, 26484, @hsvhfa)

	if(@hsvclf <> 0)
	insert into VHCB.dbo.HouseSource(HouseSUID, LkHouseSource, Total) values(@HouseSUID, 26483, @hsvclf)

	if(@hsbank <> 0)
	insert into VHCB.dbo.HouseSource(HouseSUID, LkHouseSource, Total) values(@HouseSUID, 26483, isnull(@hsbank, 0) + isnull(@hsvclf, 0))

	if(@hsothfn <> 0)
	insert into VHCB.dbo.HouseSource(HouseSUID, LkHouseSource, Total) values(@HouseSUID, 26499, @hsothfn)

	if(@hstxcr <> 0)
	insert into VHCB.dbo.HouseSource(HouseSUID, LkHouseSource, Total) values(@HouseSUID, 26478, @hstxcr)

	if(@hsoth <> 0)
	insert into VHCB.dbo.HouseSource(HouseSUID, LkHouseSource, Total) values(@HouseSUID, 26499, @hsoth)


	FETCH NEXT FROM NewCursor INTO @HousingID, 
	@hsvhcb, @hsfeas, @hslead, @hsfed, @hscdbg, @hsvhfa, @hsvclf, @hsbank, @hsothfn, @hstxcr, @hsoth
	END

Close NewCursor
deallocate NewCursor
go
