CREATE procedure GetVoucherDet
(
	@pcrId int
)
as
Begin
	select pcrq.projectcheckreqid, pcrq.[Voucher#] as voucherNum, paiddate, pcrq.userid, ui.fname+', '+ui.Lname   as staffid  
	from projectCheckReq pcrq
	left join UserInfo ui on pcrq.Coordinator = ui.UserId
	where pcrq.projectcheckreqid = @pcrId and Voucher# is not null
End