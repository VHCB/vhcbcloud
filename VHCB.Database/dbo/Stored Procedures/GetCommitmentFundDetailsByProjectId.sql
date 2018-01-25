CREATE procedure [dbo].[GetCommitmentFundDetailsByProjectId]
(	
	@transId int,
	@commitmentType int,
	@activeOnly int
)
as
Begin
-- exec dbo.GetCommitmentFundDetailsByProjectId 409, 239,1
if @activeOnly = 1
	Begin
	if @commitmentType = 238  --Board Commitment
		Begin
			Select t.projectid, d.detailid, f.FundId, f.account, f.name, format(d.Amount, 'N2') as amount, lv.Description, 
				d.LkTransType, t.LkTransaction, t.TransId, d.LandUsePermitID,
				CASE 
				WHEN isnull(d.LandUsePermitID, '') != ''  then f.name + ' - ' + af.UsePermit
				ELSE f.name
				END as FundName
			from Fund f 
				join Detail d on d.FundId = f.FundId
				join Trans t on t.TransId = d.TransId
				join LookupValues lv on lv.TypeID = d.LkTransType
				left join Act250Farm af(nolock) on af.Act250FarmId = d.LandUsePermitID
			Where f.RowIsActive = 1 and d.RowIsActive = 1 and t.LkTransaction = @commitmentType
			and t.TransId = @transId and t.RowIsActive = 1 
		end
	Else if (@commitmentType = 239 or @commitmentType = 237) -- Decommitment or Cash refund
		Begin
			Select t.projectid, d.detailid, f.FundId, f.account, f.name, format(d.Amount, 'N2') as amount, lv.Description, 
				d.LkTransType, t.LkTransaction, t.TransId, d.LandUsePermitID,
				CASE 
				WHEN isnull(d.LandUsePermitID, '') != ''  then f.name + ' - ' + af.UsePermit
				ELSE f.name
				END as FundName
			from Fund f 
				join Detail d on d.FundId = f.FundId
				join Trans t on t.TransId = d.TransId
				join LookupValues lv on lv.TypeID = d.LkTransType
				left join Act250Farm af(nolock) on af.Act250FarmId = d.LandUsePermitID
			Where f.RowIsActive = 1 and d.RowIsActive = 1 and t.LkTransaction = @commitmentType
			and t.TransId = @transId and t.RowIsActive = 1 
		End
	Else if (@commitmentType = 240) --Relocation
		Begin
			Select t.projectid, d.detailid, f.FundId, f.account, f.name, format(d.Amount, 'N2') as amount, lv.Description, 
				d.LkTransType, t.LkTransaction, t.TransId, af.UsePermit
			from Fund f 
				join Detail d on d.FundId = f.FundId
				join Trans t on t.TransId = d.TransId
				join LookupValues lv on lv.TypeID = d.LkTransType
				left join Act250Farm af on af.Act250FarmID = d.landusepermitid
			Where  f.RowIsActive=1 and d.RowIsActive=1 and t.LkTransaction = @commitmentType and d.Amount > 0
			and t.TransId = @transId and t.RowIsActive=1 
		End
	End
else
	Begin
	if @commitmentType = 238
		Begin
			Select t.projectid, d.detailid, f.FundId, f.account, f.name, format(d.Amount, 'N2') as amount, lv.Description, 
				d.LkTransType, t.LkTransaction, t.TransId   
			from Fund f 
				join Detail d on d.FundId = f.FundId
				join Trans t on t.TransId = d.TransId
				join LookupValues lv on lv.TypeID = d.LkTransType
			Where     f.RowIsActive=1 and t.LkTransaction = @commitmentType
			and t.TransId = @transId 
		end
	Else if (@commitmentType = 239 or @commitmentType = 237) -- Decommitment or Cash refund
		Begin
			Select t.projectid, d.detailid, f.FundId, f.account, f.name, format(d.Amount, 'N2') as amount, lv.Description, 
				d.LkTransType, t.LkTransaction , t.TransId  
			from Fund f 
				join Detail d on d.FundId = f.FundId
				join Trans t on t.TransId = d.TransId
				join LookupValues lv on lv.TypeID = d.LkTransType
			Where     f.RowIsActive=1 and t.LkTransaction = @commitmentType
			and t.TransId = @transId 
		End
		Else if (@commitmentType = 240) -- Relocation
		Begin
			Select t.projectid, d.detailid, f.FundId, f.account, f.name, format(d.Amount, 'N2') as amount, lv.Description, 
				d.LkTransType, t.LkTransaction , t.TransId, af.UsePermit
			from Fund f 
				join Detail d on d.FundId = f.FundId
				join Trans t on t.TransId = d.TransId
				join LookupValues lv on lv.TypeID = d.LkTransType
				left join Act250Farm af on af.Act250FarmID = d.landusepermitid
			Where     f.RowIsActive=1 and t.LkTransaction = @commitmentType and d.Amount > 0
			and t.TransId = @transId 
		End
	End
End