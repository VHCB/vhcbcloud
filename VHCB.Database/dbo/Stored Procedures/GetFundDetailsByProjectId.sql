

CREATE procedure [dbo].[GetFundDetailsByProjectId]
(	
	@transId int
)
as
Begin
	Select t.projectid, d.detailid, f.FundId, f.account, f.name, d.Amount, lv.Description, d.LkTransType  from Fund f 
		join Detail d on d.FundId = f.FundId
		join Trans t on t.TransId = d.TransId
		join LookupValues lv on lv.TypeID = d.LkTransType
	Where  t.TransId = @transId and f.RowIsActive=1
End