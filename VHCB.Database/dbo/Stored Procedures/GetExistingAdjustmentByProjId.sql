CREATE procedure [dbo].[GetExistingAdjustmentByProjId]
(
	@projId int
)
as
Begin
	
	select t.TransId, CONVERT(varchar, t.Date, 101) as TransDate, t.ReallAssignAmt, d.DetailID, d.FundId, d.LkTransType as FundTransType, convert(varchar(10), d.Amount) as DetailAmount,
	isnull(t.Comment, '') as Comments
	from Trans t(nolock) 
	join Detail d(nolock) on d.TransId = t.TransId
	where t.ProjectID = @projId and LkTransaction = 26733 and LkStatus = 261
End