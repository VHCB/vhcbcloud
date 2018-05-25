use PTConvert
go

--select * from VHCB.dbo.ConserveUses

	truncate table VHCB.dbo.ConserveUses
	go

	DECLARE @ConserveID as int, @ConserveSUID int, @cuvease float, @cuvfee float, @cuvcstf float, @cuvcmap float, @cuvccost  float, 
	@cuvclgl float,	@cuvcuni float, @cuvstew float, @cuvappr float, @cuvsur float, @cuvad float, @cuvpre float, @cuvrcost float,
	@cuoease float, @cuofee float, @cuocstf float, @cuostew float, @cuoappr float, @cuosur float, @cuodon float, @cuopre float, @cuorcost float,
	@cuvrsite float, @cuvrres float, @cuvrdev float, @cuvrhm float, @cuvrcon float, @cuvroth float, @cuvoth float,
	@cuocmap float, @cuoccost float, @cuoclgl float, @cuocuni float,  @cuoad float,  @cuorsite float, @cuorres float, @cuordev float, @cuorhm float, @cuorcon float, @cuoroth float, @cuooth float

	declare NewCursor Cursor for
	select c.ConserveID, cuvease, cuvfee, cuvcstf, cuvcmap, cuvccost, cuvclgl, cuvcuni, cuvstew, cuvappr, cuvsur, cuvad, cuvpre, cuvrcost,
	cuoease, cuofee, cuocstf, cuostew, cuoappr, cuosur, cuodon, cuopre, cuorcost,
	cuvrsite, cuvrres, cuvrdev, cuvrhm, cuvrcon, cuvroth, cuvoth,
	cuocmap, cuoccost, cuoclgl, cuocuni,  cuoad,  cuorsite, cuorres, cuordev, cuorhm, cuorcon, cuoroth, cuooth
	from VHCB.dbo.Conserve c(nolock)
	join MasterProj p1(nolock) on c.ProjectID = p1.ProjectId
	join ptproj p2(nolock) on p2.[number] = p1.Proj_num
	join ptapplctn ap(nolock) on ap.projkey = p1.[key]
	join ptconsacres pc(nolock) on ap.[key] = pc.applctnkey
	join ptconssu con(nolock) on con.projkey = p2.[key]
	where p2.conserv = 1

open NewCursor
	fetch next from NewCursor into @ConserveID, @cuvease, @cuvfee, @cuvcstf, @cuvcmap, @cuvccost, @cuvclgl, 
		@cuvcuni, @cuvstew, @cuvappr, @cuvsur, @cuvad, @cuvpre, @cuvrcost,
		@cuoease, @cuofee, @cuocstf, @cuostew, @cuoappr, @cuosur, @cuodon, @cuopre, @cuorcost,
		@cuvrsite, @cuvrres, @cuvrdev, @cuvrhm, @cuvrcon, @cuvroth, @cuvoth,
		@cuocmap, @cuoccost, @cuoclgl, @cuocuni,  @cuoad,  @cuorsite, @cuorres, @cuordev, @cuorhm, @cuorcon, @cuoroth, @cuooth
	WHILE @@FETCH_STATUS = 0
	begin

		--insert into VHCB.dbo.ConserveSU(ConserveID, LKBudgetPeriod, DateModified)
		--values(@ConserveID, 26083, getdate())

		select @ConserveSUID = ConserveSUID from VHCB.dbo.ConserveSU(nolock) where ConserveID = @ConserveID
	
		if(@cuvease <> 0)
		insert into VHCB.dbo.ConserveUses(ConserveSUID, LkConUseVHCB, VHCBTotal) values(@ConserveSUID, 439, @cuvease)

		if(@cuvfee <> 0)
		insert into VHCB.dbo.ConserveUses(ConserveSUID, LkConUseVHCB, VHCBTotal) values(@ConserveSUID, 440, @cuvfee)

		if(@cuvcstf <> 0)
		insert into VHCB.dbo.ConserveUses(ConserveSUID, LkConUseVHCB, VHCBTotal) values(@ConserveSUID, 442, isnull(@cuvcstf, 0) +  isnull(@cuvcmap, 0) +  isnull(@cuvccost, 0) +
		  isnull(@cuvclgl, 0) +  isnull(@cuvcuni, 0) + isnull(@cuvad, 0))

		if(@cuvstew <> 0)
		insert into VHCB.dbo.ConserveUses(ConserveSUID, LkConUseVHCB, VHCBTotal) values(@ConserveSUID, 441, @cuvstew)

		if(@cuvappr <> 0)
		insert into VHCB.dbo.ConserveUses(ConserveSUID, LkConUseVHCB, VHCBTotal) values(@ConserveSUID, 443, @cuvappr)

		if(@cuvsur <> 0)
		insert into VHCB.dbo.ConserveUses(ConserveSUID, LkConUseVHCB, VHCBTotal) values(@ConserveSUID, 26611, @cuvsur)
		
		if(@cuvpre <> 0)
		insert into VHCB.dbo.ConserveUses(ConserveSUID, LkConUseVHCB, VHCBTotal) values(@ConserveSUID, 444, @cuvpre)

		if(@cuvrcost <> 0)
		insert into VHCB.dbo.ConserveUses(ConserveSUID, LkConUseVHCB, VHCBTotal) values(@ConserveSUID, 445, isnull(@cuvrcost, 0) +  isnull(@cuvrsite, 0) +  isnull(@cuvrres, 0) +
		  isnull(@cuvrdev, 0) +  isnull(@cuvrhm, 0) + isnull(@cuvrcon, 0)+ isnull(@cuvroth, 0))


		--OTHER
		if(@cuoease <> 0)
		insert into VHCB.dbo.ConserveUses(ConserveSUID, LkConUseOther, OtherTotal) values(@ConserveSUID, 447, @cuoease)

		if(@cuofee <> 0)
		insert into VHCB.dbo.ConserveUses(ConserveSUID, LkConUseOther, OtherTotal) values(@ConserveSUID, 448, @cuofee)

		if(@cuocstf <> 0)
		insert into VHCB.dbo.ConserveUses(ConserveSUID, LkConUseOther, OtherTotal) values(@ConserveSUID, 449, isnull(@cuocstf, 0) +  isnull(@cuocmap, 0) +  isnull(@cuoccost, 0) +
		  isnull(@cuoclgl, 0) +  isnull(@cuocuni, 0) +  isnull(@cuoad, 0))

		if(@cuostew <> 0)
		insert into VHCB.dbo.ConserveUses(ConserveSUID, LkConUseOther, OtherTotal) values(@ConserveSUID, 450, @cuostew)

		if(@cuoappr <> 0)
		insert into VHCB.dbo.ConserveUses(ConserveSUID, LkConUseOther, OtherTotal) values(@ConserveSUID, 451, @cuoappr)

		if(@cuosur <> 0)
		insert into VHCB.dbo.ConserveUses(ConserveSUID, LkConUseOther, OtherTotal) values(@ConserveSUID, 26612, @cuosur)

		if(@cuodon <> 0)
		insert into VHCB.dbo.ConserveUses(ConserveSUID, LkConUseOther, OtherTotal) values(@ConserveSUID, 453, @cuodon)

		if(@cuopre <> 0)
		insert into VHCB.dbo.ConserveUses(ConserveSUID, LkConUseOther, OtherTotal) values(@ConserveSUID, 454, @cuopre)

		if(@cuorcost <> 0)
		insert into VHCB.dbo.ConserveUses(ConserveSUID, LkConUseOther, OtherTotal) values(@ConserveSUID, 455, isnull(@cuorcost, 0) +  isnull(@cuorsite, 0) +  isnull(@cuorres, 0) + 
			isnull(@cuordev, 0) + isnull(@cuorhm, 0) + isnull(@cuorcon, 0) + isnull(@cuoroth, 0))

	FETCH NEXT FROM NewCursor INTO @ConserveID, @cuvease, @cuvfee, @cuvcstf, @cuvcmap, @cuvccost, @cuvclgl, 
		@cuvcuni, @cuvstew, @cuvappr, @cuvsur, @cuvad, @cuvpre, @cuvrcost,
		@cuoease, @cuofee, @cuocstf, @cuostew, @cuoappr, @cuosur, @cuodon, @cuopre, @cuorcost,
		@cuvrsite, @cuvrres, @cuvrdev, @cuvrhm, @cuvrcon, @cuvroth, @cuvoth,
		@cuocmap, @cuoccost, @cuoclgl, @cuocuni,  @cuoad,  @cuorsite, @cuorres, @cuordev, @cuorhm, @cuorcon, @cuoroth, @cuooth
	END

Close NewCursor
deallocate NewCursor