CREATE procedure UpdateVoucherNumber
(
  @voucherNum varchar(10),
  @crDate datetime,
  @userId int,
  @projectCheckReqId int
)
as 
Begin
	update ProjectCheckReq set [Voucher#] = @vouchernum, paiddate = @crdate, Coordinator = @userid where projectcheckreqid = @projectcheckreqid;
	
	Update Trans set LkStatus = 262 where projectCheckReqId = @projectCheckReqId

	select pcrq.projectcheckreqid, pcrq.[Voucher#] as voucherNum, paiddate, pcrq.userid, ui.fname+', '+ui.Lname   as staffid  
	from projectCheckReq pcrq
	left join UserInfo ui on pcrq.Coordinator = ui.UserId
	where pcrq.projectcheckreqid = @projectcheckreqid;
End