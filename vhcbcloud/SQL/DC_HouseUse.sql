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

	if(@huvacq <> 0)
	insert into VHCB.dbo.HouseUse(HouseSUID, LkHouseUseVHCB, VHCBTotal, LKHouseUseOther, OtherTotal) values(@HouseSUID, 26106, @huvacq, 26106, 0)

	if(@huvrcost <> 0)
	insert into VHCB.dbo.HouseUse(HouseSUID, LkHouseUseVHCB, VHCBTotal, LKHouseUseOther, OtherTotal) values(@HouseSUID, 26107, @huvrcost, 26107, 0)

	if(@huvrsite <> 0)
	insert into VHCB.dbo.HouseUse(HouseSUID, LkHouseUseVHCB, VHCBTotal, LKHouseUseOther, OtherTotal) values(@HouseSUID, 26107, @huvrsite + @huvrcost, 26107, 0)

	if(@huvrap <> 0)
	insert into VHCB.dbo.HouseUse(HouseSUID, LkHouseUseVHCB, VHCBTotal, LKHouseUseOther, OtherTotal) values(@HouseSUID, 26107, @huvrap + @huvrsite + @huvrcost, 26107, 0)

	if(@huvrhm <> 0)
	insert into VHCB.dbo.HouseUse(HouseSUID, LkHouseUseVHCB, VHCBTotal, LKHouseUseOther, OtherTotal) values(@HouseSUID, 26107, @huvrhm + @huvrap + @huvrsite + @huvrcost, 26107, 0)
	
	if(@huvrmang <> 0)
	insert into VHCB.dbo.HouseUse(HouseSUID, LkHouseUseVHCB, VHCBTotal, LKHouseUseOther, OtherTotal) values(@HouseSUID, 26107, @huvrmang + @huvrhm + @huvrap + @huvrsite + @huvrcost, 26107, 0)

	if(@huvrcon <> 0)
	insert into VHCB.dbo.HouseUse(HouseSUID, LkHouseUseVHCB, VHCBTotal, LKHouseUseOther, OtherTotal) values(@HouseSUID, 26107, @huvrcon + @huvrmang + @huvrhm + @huvrap + @huvrsite + @huvrcost, 26107, 0)

	if(@huvroth <> 0)
	insert into VHCB.dbo.HouseUse(HouseSUID, LkHouseUseVHCB, VHCBTotal, LKHouseUseOther, OtherTotal) values(@HouseSUID, 26107, @huvroth + @huvrcon + @huvrmang + @huvrhm + @huvrap + @huvrsite + @huvrcost, 26107, 0)
	
	if(@huvccost <> 0)
	insert into VHCB.dbo.HouseUse(HouseSUID, LkHouseUseVHCB, VHCBTotal, LKHouseUseOther, OtherTotal) values(@HouseSUID, 26107, @huvccost + @huvroth + @huvrcon + @huvrmang + @huvrhm + @huvrap + @huvrsite + @huvrcost, 26107, 0)

	if(@huvcsite <> 0)
	insert into VHCB.dbo.HouseUse(HouseSUID, LkHouseUseVHCB, VHCBTotal, LKHouseUseOther, OtherTotal) values(@HouseSUID, 26107, @huvcsite + @huvccost + @huvroth + @huvrcon + @huvrmang + @huvrhm + @huvrap + @huvrsite + @huvrcost, 26107, 0)

	if(@huvcap <> 0)
	insert into VHCB.dbo.HouseUse(HouseSUID, LkHouseUseVHCB, VHCBTotal, LKHouseUseOther, OtherTotal) values(@HouseSUID, 26107, @huvcap + @huvcsite + @huvccost + @huvroth + @huvrcon + @huvrmang + @huvrhm + @huvrap + @huvrsite + @huvrcost, 26107, 0)

	if(@huvchm <> 0)
	insert into VHCB.dbo.HouseUse(HouseSUID, LkHouseUseVHCB, VHCBTotal, LKHouseUseOther, OtherTotal) values(@HouseSUID, 26107, @huvchm + @huvcap + @huvcsite + @huvccost + @huvroth + @huvrcon + @huvrmang + @huvrhm + @huvrap + @huvrsite + @huvrcost, 26107, 0)

	if(@huvcmang <> 0)
	insert into VHCB.dbo.HouseUse(HouseSUID, LkHouseUseVHCB, VHCBTotal, LKHouseUseOther, OtherTotal) values(@HouseSUID, 26107, @huvcmang + @huvchm + @huvcap + @huvcsite + @huvccost + @huvroth + @huvrcon + @huvrmang + @huvrhm + @huvrap + @huvrsite + @huvrcost, 26107, 0)

	if(@huvccon <> 0)
	insert into VHCB.dbo.HouseUse(HouseSUID, LkHouseUseVHCB, VHCBTotal, LKHouseUseOther, OtherTotal) values(@HouseSUID, 26107, @huvccon + @huvcmang + @huvchm + @huvcap + @huvcsite + @huvccost + @huvroth + @huvrcon + @huvrmang + @huvrhm + @huvrap + @huvrsite + @huvrcost, 26107, 0)
	
	if(@huvdev <> 0)
	insert into VHCB.dbo.HouseUse(HouseSUID, LkHouseUseVHCB, VHCBTotal, LKHouseUseOther, OtherTotal) values(@HouseSUID, 26108, @huvdev, 26108, 0)

	if(@huvsfee <> 0)
	insert into VHCB.dbo.HouseUse(HouseSUID, LkHouseUseVHCB, VHCBTotal, LKHouseUseOther, OtherTotal) values(@HouseSUID, 26110, @huvsfee, 26110, 0)

	if(@huvspf <> 0)
	insert into VHCB.dbo.HouseUse(HouseSUID, LkHouseUseVHCB, VHCBTotal, LKHouseUseOther, OtherTotal) values(@HouseSUID, 26110, @huvspf + @huvsfee, 26110, 0)

	if(@huvsmk <> 0)
	insert into VHCB.dbo.HouseUse(HouseSUID, LkHouseUseVHCB, VHCBTotal, LKHouseUseOther, OtherTotal) values(@HouseSUID, 26110, @huvsmk + @huvspf + @huvsfee, 26110, 0)

	if(@huvsfn <> 0)
	insert into VHCB.dbo.HouseUse(HouseSUID, LkHouseUseVHCB, VHCBTotal, LKHouseUseOther, OtherTotal) values(@HouseSUID, 26110, @huvsfn + @huvsmk + @huvspf + @huvsfee, 26110, 0)

	if(@huvscon <> 0)
	insert into VHCB.dbo.HouseUse(HouseSUID, LkHouseUseVHCB, VHCBTotal, LKHouseUseOther, OtherTotal) values(@HouseSUID, 26110, @huvscon + @huvsfn + @huvsmk + @huvspf + @huvsfee, 26110, 0)

	if(@huvsre <> 0)
	insert into VHCB.dbo.HouseUse(HouseSUID, LkHouseUseVHCB, VHCBTotal, LKHouseUseOther, OtherTotal) values(@HouseSUID, 26110, @huvsre + @huvscon + @huvsfn + @huvsmk + @huvspf + @huvsfee, 26110, 0)

	if(@huvreserve <> 0)
	insert into VHCB.dbo.HouseUse(HouseSUID, LkHouseUseVHCB, VHCBTotal, LKHouseUseOther, OtherTotal) values(@HouseSUID, 26109, @huvreserve, 26109, 0)

	if(@huvad <> 0)
	insert into VHCB.dbo.HouseUse(HouseSUID, LkHouseUseVHCB, VHCBTotal, LKHouseUseOther, OtherTotal) values(@HouseSUID, 26891, @huvad, 26891, 0)

	if(@huvoth <> 0)
	insert into VHCB.dbo.HouseUse(HouseSUID, LkHouseUseVHCB, VHCBTotal, LKHouseUseOther, OtherTotal) values(@HouseSUID, 26891, @huvoth + @huvad, 26891, 0)

	if(@huoacq <> 0)
	insert into VHCB.dbo.HouseUse(HouseSUID, LkHouseUseVHCB, VHCBTotal, LKHouseUseOther, OtherTotal) values(@HouseSUID, 26106, @huoacq, 26106, 0)

	if(@huorcost <> 0)
	insert into VHCB.dbo.HouseUse(HouseSUID, LkHouseUseVHCB, VHCBTotal, LKHouseUseOther, OtherTotal) values(@HouseSUID, 26107, @huorcost, 26107, 0)

	if(@huorsite <> 0)
	insert into VHCB.dbo.HouseUse(HouseSUID, LkHouseUseVHCB, VHCBTotal, LKHouseUseOther, OtherTotal) values(@HouseSUID, 26107, @huorsite + @huorcost, 26107, 0)

	if(@huorap <> 0)
	insert into VHCB.dbo.HouseUse(HouseSUID, LkHouseUseVHCB, VHCBTotal, LKHouseUseOther, OtherTotal) values(@HouseSUID, 26107, @huorap + @huorsite + @huorcost, 26107, 0)

	if(@huorhm <> 0)
	insert into VHCB.dbo.HouseUse(HouseSUID, LkHouseUseVHCB, VHCBTotal, LKHouseUseOther, OtherTotal) values(@HouseSUID, 26107, @huorhm + @huorap + @huorsite + @huorcost, 26107, 0)
	
	if(@huormang <> 0)
	insert into VHCB.dbo.HouseUse(HouseSUID, LkHouseUseVHCB, VHCBTotal, LKHouseUseOther, OtherTotal) values(@HouseSUID, 26107, @huormang + @huorhm + @huorap + @huorsite + @huorcost, 26107, 0)
	
	if(@huorcon <> 0)
	insert into VHCB.dbo.HouseUse(HouseSUID, LkHouseUseVHCB, VHCBTotal, LKHouseUseOther, OtherTotal) values(@HouseSUID, 26107, @huorcon + @huormang + @huorhm + @huorap + @huorsite + @huorcost, 26107, 0)
	
	if(@huoroth <> 0)
	insert into VHCB.dbo.HouseUse(HouseSUID, LkHouseUseVHCB, VHCBTotal, LKHouseUseOther, OtherTotal) values(@HouseSUID, 26107, @huoroth + @huorcon + @huormang + @huorhm + @huorap + @huorsite + @huorcost, 26107, 0)
	
	if(@huoccost <> 0)
	insert into VHCB.dbo.HouseUse(HouseSUID, LkHouseUseVHCB, VHCBTotal, LKHouseUseOther, OtherTotal) values(@HouseSUID, 26107, @huoccost + @huoroth + @huorcon + @huormang + @huorhm + @huorap + @huorsite + @huorcost, 26107, 0)
	
	if(@huocsite <> 0)
	insert into VHCB.dbo.HouseUse(HouseSUID, LkHouseUseVHCB, VHCBTotal, LKHouseUseOther, OtherTotal) values(@HouseSUID, 26107, @huocsite + @huoccost + @huoroth + @huorcon + @huormang + @huorhm + @huorap + @huorsite + @huorcost, 26107, 0)
	
	if(@huocap <> 0)
	insert into VHCB.dbo.HouseUse(HouseSUID, LkHouseUseVHCB, VHCBTotal, LKHouseUseOther, OtherTotal) values(@HouseSUID, 26107, @huocap + @huocsite + @huoccost + @huoroth + @huorcon + @huormang + @huorhm + @huorap + @huorsite + @huorcost, 26107, 0)
	
	if(@huochm <> 0)
	insert into VHCB.dbo.HouseUse(HouseSUID, LkHouseUseVHCB, VHCBTotal, LKHouseUseOther, OtherTotal) values(@HouseSUID, 26107, @huochm + @huocap + @huocsite + @huoccost + @huoroth + @huorcon + @huormang + @huorhm + @huorap + @huorsite + @huorcost, 26107, 0)
	
	if(@huocmang <> 0)
	insert into VHCB.dbo.HouseUse(HouseSUID, LkHouseUseVHCB, VHCBTotal, LKHouseUseOther, OtherTotal) values(@HouseSUID, 26107, @huocmang + @huochm + @huocap + @huocsite + @huoccost + @huoroth + @huorcon + @huormang + @huorhm + @huorap + @huorsite + @huorcost, 26107, 0)
	
	if(@huoccon <> 0)
	insert into VHCB.dbo.HouseUse(HouseSUID, LkHouseUseVHCB, VHCBTotal, LKHouseUseOther, OtherTotal) values(@HouseSUID, 26107, @huoccon + @huocmang + @huochm + @huocap + @huocsite + @huoccost + @huoroth + @huorcon + @huormang + @huorhm + @huorap + @huorsite + @huorcost, 26107, 0)
	
	if(@huocoth <> 0)
	insert into VHCB.dbo.HouseUse(HouseSUID, LkHouseUseVHCB, VHCBTotal, LKHouseUseOther, OtherTotal) values(@HouseSUID, 26107, @huocoth + @huoccon + @huocmang + @huochm + @huocap + @huocsite + @huoccost + @huoroth + @huorcon + @huormang + @huorhm + @huorap + @huorsite + @huorcost, 26107, 0)
	
	if(@huodev <> 0)
	insert into VHCB.dbo.HouseUse(HouseSUID, LkHouseUseVHCB, VHCBTotal, LKHouseUseOther, OtherTotal) values(@HouseSUID, 26107, @huodev + @huocoth + @huoccon + @huocmang + @huochm + @huocap + @huocsite + @huoccost + @huoroth + @huorcon + @huormang + @huorhm + @huorap + @huorsite + @huorcost, 26107, 0)
	
	if(@huodev <> 0)
	insert into VHCB.dbo.HouseUse(HouseSUID, LkHouseUseVHCB, VHCBTotal, LKHouseUseOther, OtherTotal) values(@HouseSUID, 26108, @huodev + @huvdev, 26108, 0)
	
	if(@huosfee <> 0)
	insert into VHCB.dbo.HouseUse(HouseSUID, LkHouseUseVHCB, VHCBTotal, LKHouseUseOther, OtherTotal) values(@HouseSUID, 26110, @huosfee+@huvsre + @huvscon + @huvsfn + @huvsmk + @huvspf + @huvsfee, 26110, 0)
	
	if(@huospf <> 0)
	insert into VHCB.dbo.HouseUse(HouseSUID, LkHouseUseVHCB, VHCBTotal, LKHouseUseOther, OtherTotal) values(@HouseSUID, 26110, @huospf + @huosfee+@huvsre + @huvscon + @huvsfn + @huvsmk + @huvspf + @huvsfee, 26110, 0)
	
	if(@huosmk <> 0)
	insert into VHCB.dbo.HouseUse(HouseSUID, LkHouseUseVHCB, VHCBTotal, LKHouseUseOther, OtherTotal) values(@HouseSUID, 26110, @huosmk + @huospf + @huosfee+@huvsre + @huvscon + @huvsfn + @huvsmk + @huvspf + @huvsfee, 26110, 0)
	
	if(@huosfn <> 0)
	insert into VHCB.dbo.HouseUse(HouseSUID, LkHouseUseVHCB, VHCBTotal, LKHouseUseOther, OtherTotal) values(@HouseSUID, 26110, @huosfn + @huosmk + @huospf + @huosfee+@huvsre + @huvscon + @huvsfn + @huvsmk + @huvspf + @huvsfee, 26110, 0)
	
	if(@huoscon <> 0)
	insert into VHCB.dbo.HouseUse(HouseSUID, LkHouseUseVHCB, VHCBTotal, LKHouseUseOther, OtherTotal) values(@HouseSUID, 26110, @huoscon + @huosfn + @huosmk + @huospf + @huosfee+@huvsre + @huvscon + @huvsfn + @huvsmk + @huvspf + @huvsfee, 26110, 0)
	
	if(@huosre <> 0)
	insert into VHCB.dbo.HouseUse(HouseSUID, LkHouseUseVHCB, VHCBTotal, LKHouseUseOther, OtherTotal) values(@HouseSUID, 26110, @huosre + @huoscon + @huosfn + @huosmk + @huospf + @huosfee+@huvsre + @huvscon + @huvsfn + @huvsmk + @huvspf + @huvsfee, 26110, 0)
	
	if(@huosoth <> 0)
	insert into VHCB.dbo.HouseUse(HouseSUID, LkHouseUseVHCB, VHCBTotal, LKHouseUseOther, OtherTotal) values(@HouseSUID, 26110, @huosoth + @huosre + @huoscon + @huosfn + @huosmk + @huospf + @huosfee+@huvsre + @huvscon + @huvsfn + @huvsmk + @huvspf + @huvsfee, 26110, 0)
	
	if(@huoreserve <> 0)
	insert into VHCB.dbo.HouseUse(HouseSUID, LkHouseUseVHCB, VHCBTotal, LKHouseUseOther, OtherTotal) values(@HouseSUID, 26109, @huoreserve + @huvreserve, 26109, 0)
	
	if(@huoad <> 0)
	insert into VHCB.dbo.HouseUse(HouseSUID, LkHouseUseVHCB, VHCBTotal, LKHouseUseOther, OtherTotal) values(@HouseSUID, 26891, @huoad + @huvoth + @huvad, 26891, 0)

	if(@huooth <> 0)
	insert into VHCB.dbo.HouseUse(HouseSUID, LkHouseUseVHCB, VHCBTotal, LKHouseUseOther, OtherTotal) values(@HouseSUID, 26891, @huooth + @huoad + @huvoth + @huvad, 26891, 0)

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
