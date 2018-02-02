
CREATE procedure [dbo].[GetGrantInfoDetailsByFund]
(
	@FundId int
)
as
Begin

	SELECT gi.GrantinfoID
      ,gi.GrantName
      ,gi.VHCBName
      ,gi.LkGrantor
      ,gi.LkGrantSource
      ,gi.AwardNum
      ,gi.AwardAmt
      ,gi.BeginDate
      ,gi.EndDate
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
	  ,lkg.Description
  FROM dbo.GrantInfo gi join FundGrantinfo fgi  on fgi.GrantinfoID = gi.GrantinfoID
  join 
  (
  select typeid, LookupType, Description from LookupValues 
	where LookupType = (select recordid from LkLookups where tablename = 'lkgrantor')
	and RowIsActive = 1
  ) lkg on lkg.TypeID = gi.LkGrantor
 
  where gi.RowIsActive = 1 and fgi.RowIsActive = 1 and fgi.FundID = @FundId
 End