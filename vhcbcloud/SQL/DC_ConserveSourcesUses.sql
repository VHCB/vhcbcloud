use PTConvert
go
--select * from VHCB.dbo.ConserveSU
----1651
--select * from VHCB.dbo.ConserveSources
----3521
--select * from VHCB.dbo.ConserveUses
----4400

truncate table VHCB.dbo.ConserveSU
truncate table VHCB.dbo.ConserveSources
truncate table VHCB.dbo.ConserveUses

DECLARE @ConserveID as int, @ConserveSUID int, @csvhcb as float, @csvfa as float, @csvfea as float, @csloc as float, @csfnd as float, 
	@csapp as float, @csfed as float, @csstate as float, @csmun as float, @csbar as float, @csedon as float, @csidon as float, @csoth as float,
	@cuvease float, @cuvfee float, @cuvcstf float, @cuvcmap float, @cuvccost  float, 
	@cuvclgl float,	@cuvcuni float, @cuvstew float, @cuvappr float, @cuvsur float, @cuvad float, @cuvpre float, @cuvrcost float,
	@cuoease float, @cuofee float, @cuocstf float, @cuostew float, @cuoappr float, @cuosur float, @cuodon float, @cuopre float, @cuorcost float

	declare NewCursor Cursor for
	select c.ConserveID, csvhcb, csvfa, csvfea, csloc, csfnd, csapp, csfed, csstate, csmun, csbar, csedon, csidon, csoth,
		cuvease, cuvfee, cuvcstf, cuvcmap, cuvccost, cuvclgl, cuvcuni, cuvstew, cuvappr, cuvsur, cuvad, cuvpre, cuvrcost,
		cuoease, cuofee, cuocstf, cuostew, cuoappr, cuosur, cuodon, cuopre, cuorcost
	from VHCB.dbo.Conserve c(nolock)
	join MasterProj p1(nolock) on c.ProjectID = p1.ProjectId
	join ptproj p2(nolock) on p2.[number] = p1.Proj_num
	join ptapplctn ap(nolock) on ap.projkey = p1.[key]
	join ptconsacres pc(nolock) on ap.[key] = pc.applctnkey
	join ptconssu con(nolock) on con.projkey = p2.[key]
	where p2.conserv = 1

open NewCursor
	fetch next from NewCursor into @ConserveID, @csvhcb, @csvfa, @csvfea, @csloc, @csfnd, @csapp, @csfed, @csstate, @csmun, @csbar, @csedon, 
		@csidon, @csoth,
		@cuvease, @cuvfee, @cuvcstf, @cuvcmap, @cuvccost, @cuvclgl, 
		@cuvcuni, @cuvstew, @cuvappr, @cuvsur, @cuvad, @cuvpre, @cuvrcost,
		@cuoease, @cuofee, @cuocstf, @cuostew, @cuoappr, @cuosur, @cuodon, @cuopre, @cuorcost
	WHILE @@FETCH_STATUS = 0
	begin

		insert into VHCB.dbo.ConserveSU(ConserveID, LKBudgetPeriod, DateModified)
		values(@ConserveID, 26083, getdate())

		set @ConserveSUID =  SCOPE_IDENTITY()
	
		if(@csvhcb <> 0)
		insert into VHCB.dbo.ConserveSources(ConserveSUID, LkConSource, Total) values(@ConserveSUID, 495, @csvhcb)

		if(@csvfa <> 0)
		insert into VHCB.dbo.ConserveSources(ConserveSUID, LkConSource, Total) values(@ConserveSUID, 496, @csvfa)

		if(@csvfea <> 0)
		insert into VHCB.dbo.ConserveSources(ConserveSUID, LkConSource, Total) values(@ConserveSUID, 497, @csvfea)

		if(@csloc <> 0)
		insert into VHCB.dbo.ConserveSources(ConserveSUID, LkConSource, Total) values(@ConserveSUID, 498, @csloc)

		if(@csfnd <> 0)
		insert into VHCB.dbo.ConserveSources(ConserveSUID, LkConSource, Total) values(@ConserveSUID, 499, @csfnd)

		if(@csapp <> 0)
		insert into VHCB.dbo.ConserveSources(ConserveSUID, LkConSource, Total) values(@ConserveSUID, 500, @csapp)

		if(@csfed <> 0)
		insert into VHCB.dbo.ConserveSources(ConserveSUID, LkConSource, Total) values(@ConserveSUID, 501, @csfed)

		if(@csstate <> 0)
		insert into VHCB.dbo.ConserveSources(ConserveSUID, LkConSource, Total) values(@ConserveSUID, 502, @csstate)

		if(@csmun <> 0)
		insert into VHCB.dbo.ConserveSources(ConserveSUID, LkConSource, Total) values(@ConserveSUID, 503, @csmun)

		if(@csbar <> 0)
		insert into VHCB.dbo.ConserveSources(ConserveSUID, LkConSource, Total) values(@ConserveSUID, 504, @csbar)

		if(@csedon <> 0)
		insert into VHCB.dbo.ConserveSources(ConserveSUID, LkConSource, Total) values(@ConserveSUID, 505, @csedon)

		if(@csidon <> 0)
		insert into VHCB.dbo.ConserveSources(ConserveSUID, LkConSource, Total) values(@ConserveSUID, 506, @csidon)

		if(@csoth <> 0)
		insert into VHCB.dbo.ConserveSources(ConserveSUID, LkConSource, Total) values(@ConserveSUID, 507, @csoth)

		--if(@cuvease <> 0)
		--insert into VHCB.dbo.ConserveUses(ConserveSUID, LkConUseVHCB, VHCBTotal) values(@ConserveSUID, 439, @cuvease)

	FETCH NEXT FROM NewCursor INTO @ConserveID, @csvhcb, @csvfa, @csvfea, @csloc, @csfnd, @csapp, @csfed, @csstate, @csmun, @csbar, @csedon, 
		@csidon, @csoth,
		@cuvease, @cuvfee, @cuvcstf, @cuvcmap, @cuvccost, @cuvclgl, 
		@cuvcuni, @cuvstew, @cuvappr, @cuvsur, @cuvad, @cuvpre, @cuvrcost,
		@cuoease, @cuofee, @cuocstf, @cuostew, @cuoappr, @cuosur, @cuodon, @cuopre, @cuorcost
	END

Close NewCursor
deallocate NewCursor