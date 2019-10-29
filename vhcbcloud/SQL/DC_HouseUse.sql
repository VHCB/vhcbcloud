use PTConvert
go


--select * from VHCB.dbo.HouseUse

truncate table VHCB.dbo.HouseUse


DECLARE @HouseSUID as int, @HousingID as int,
	@huvacq as int, @huvrcost as int, @huvrmang as int, 
	@huvrsite as int, @huvrap as int, @huvrhm as int, @huvrcon as int, @huvroth as int, @huvccost as int, @huvcmang as int, @huvcsite as int, @huvcap as int, @huvchm as int, @huvccon as int, @huvcoth as int, @huvdev as int, 
	@huvsfee as int, @huvspf as int, @huvsmk as int, @huvsfn as int, @huvscon as int, @huvsre as int, @huvsoth as int, @huvreserve as int, @huvad as int, @huvoth as int, @huoacq as int, @huorcost as int, @huormang as int, 
	@huorsite as int, @huorap as int, @huorhm as int, @huorcon as int, @huoroth as int, @huoccost as int, @huocmang as int, @huocsite as int, @huocap as int, @huochm as int, @huoccon as int, @huocoth as int, @huodev as int, 
	@huosfee as int, @huospf as int, @huosmk as int, @huosfn as int, @huoscon as int, @huosre as int, @huosoth as int, @huoreserve as int, @huoad as int, @huooth  as int

declare NewCursor Cursor for
select h.HousingID, 
	huvacq, huvrcost, huvrmang, 
	huvrsite, huvrap, huvrhm, huvrcon, huvroth, huvccost, huvcmang, huvcsite, huvcap, huvchm, huvccon, huvcoth, huvdev, 
	huvsfee, huvspf, huvsmk, huvsfn, huvscon, huvsre, huvsoth, huvreserve, huvad, huvoth, huoacq, huorcost, huormang, 
	huorsite, huorap, huorhm, huorcon, huoroth, huoccost, huocmang, huocsite, huocap, huochm, huoccon, huocoth, huodev, 
	huosfee, huospf, huosmk, huosfn, huoscon, huosre, huosoth, huoreserve, huoad, huooth
from VHCB.dbo.Housing h(nolock)
join MasterProj mp(nolock) on h.ProjectID = mp.ProjectId
join pthousingsu su(nolock) on su.projkey = mp.[key]


open NewCursor
	fetch next from NewCursor into @HousingID, 
	@huvacq, @huvrcost, @huvrmang, 
	@huvrsite, @huvrap, @huvrhm, @huvrcon, @huvroth, @huvccost, @huvcmang, @huvcsite, @huvcap, @huvchm, @huvccon, @huvcoth, @huvdev, 
	@huvsfee, @huvspf, @huvsmk, @huvsfn, @huvscon, @huvsre, @huvsoth, @huvreserve, @huvad, @huvoth, @huoacq, @huorcost, @huormang, 
	@huorsite, @huorap, @huorhm, @huorcon, @huoroth, @huoccost, @huocmang, @huocsite, @huocap, @huochm, @huoccon, @huocoth, @huodev, 
	@huosfee, @huospf, @huosmk, @huosfn, @huoscon, @huosre, @huosoth, @huoreserve, @huoad, @huooth
	WHILE @@FETCH_STATUS = 0
	begin

	
	select @HouseSUID = HouseSUID from VHCB.dbo.HouseSU(nolock) where HousingId = @HousingId

	if(@huvacq + @huoacq <> 0)
	insert into VHCB.dbo.HouseUse(HouseSUID, LkHouseUseVHCB, VHCBTotal, LKHouseUseOther, OtherTotal) values(@HouseSUID, 26106, @huvacq + @huoacq, 26106, 0)

	if(@huvccon + @huvcmang + @huvchm + @huvcap + @huvcsite + @huvccost + @huvroth + @huvrcon + @huvrmang + @huvrhm + @huvrap + @huvrsite + @huvrcost + 
	@huocoth + @huoccon + @huocmang + @huochm + @huocap + @huocsite + @huoccost + @huoroth + @huorcon + @huormang + @huorhm + @huorap + @huorsite + @huorcost + @huvcoth <> 0)
	insert into VHCB.dbo.HouseUse(HouseSUID, LkHouseUseVHCB, VHCBTotal, LKHouseUseOther, OtherTotal) values(@HouseSUID, 26107, 
		@huvccon + @huvcmang + @huvchm + @huvcap + @huvcsite + @huvccost + 
		@huvroth + @huvrcon + @huvrmang + @huvrhm + @huvrap + @huvrsite + 
		@huvrcost + @huocoth + @huoccon + @huocmang + @huochm + 
		@huocap + @huocsite + @huoccost + @huoroth + @huorcon +
		@huormang + @huorhm + @huorap + @huorsite + @huorcost + @huvcoth, 26107, 0)

	if(@huodev + @huvdev <> 0)
	insert into VHCB.dbo.HouseUse(HouseSUID, LkHouseUseVHCB, VHCBTotal, LKHouseUseOther, OtherTotal) values(@HouseSUID, 26108, @huodev + @huvdev, 26108, 0)

	if(@huoreserve + @huvreserve <> 0)
	insert into VHCB.dbo.HouseUse(HouseSUID, LkHouseUseVHCB, VHCBTotal, LKHouseUseOther, OtherTotal) values(@HouseSUID, 26109, @huoreserve + @huvreserve, 26109, 0)

	if(@huosoth + @huosre + @huoscon + @huosfn + @huosmk + @huospf + @huosfee + @huvsre + @huvscon + @huvsfn + @huvsmk + @huvspf + @huvsfee + @huvsoth <> 0)
	insert into VHCB.dbo.HouseUse(HouseSUID, LkHouseUseVHCB, VHCBTotal, LKHouseUseOther, OtherTotal) values(@HouseSUID, 26110, 
		@huosoth + @huosre + @huoscon + @huosfn + @huosmk + @huospf + @huosfee + @huvsre + @huvscon + @huvsfn + @huvsmk + @huvspf + @huvsfee + @huvsoth, 26110, 0)

	if( @huvad + @huvoth + @huoad + @huooth <> 0)
	insert into VHCB.dbo.HouseUse(HouseSUID, LkHouseUseVHCB, VHCBTotal, LKHouseUseOther, OtherTotal) values(@HouseSUID, 27697, @huvad + @huvoth + @huoad + @huooth, 27697, 0)

	FETCH NEXT FROM NewCursor INTO @HousingID, 
	@huvacq, @huvrcost, @huvrmang, 
	@huvrsite, @huvrap, @huvrhm, @huvrcon, @huvroth, @huvccost, @huvcmang, @huvcsite, @huvcap, @huvchm, @huvccon, @huvcoth, @huvdev, 
	@huvsfee, @huvspf, @huvsmk, @huvsfn, @huvscon, @huvsre, @huvsoth, @huvreserve, @huvad, @huvoth, @huoacq, @huorcost, @huormang, 
	@huorsite, @huorap, @huorhm, @huorcon, @huoroth, @huoccost, @huocmang, @huocsite, @huocap, @huochm, @huoccon, @huocoth, @huodev, 
	@huosfee, @huospf, @huosmk, @huosfn, @huoscon, @huosre, @huosoth, @huoreserve, @huoad, @huooth
	END

Close NewCursor
deallocate NewCursor
go
