

CREATE procedure [dbo].[GetGrantInfoDetailsByGrantInfoId]
(
	@GrantInfoId int
)
as
Begin

	SELECT gi.GrantinfoID
      ,gi.GrantName
      ,gi.VHCBName
      ,gi.LkGrantor
      ,gi.LkGrantSource
      ,gi.AwardNum
      ,ROUND(gi.AwardAmt,2) as AwardAmt
      ,CONVERT(VARCHAR(10),gi.BeginDate,101) as BeginDate
      ,CONVERT(VARCHAR(10),gi.EndDate,101) as EndDate
      ,gi.Staff
      ,gi.ContactID
      ,gi.CFDA
      ,gi.SignAgree
      ,gi.FedFunds
      ,gi.Match
      ,gi.Fundsrec
      ,gi.[Admin]
      ,gi.Notes
      ,gi.RowIsActive
      ,gi.DateModified
  FROM dbo.GrantInfo gi  

  where gi.RowIsActive = 1 and gi.GrantinfoID = @GrantInfoId
 End