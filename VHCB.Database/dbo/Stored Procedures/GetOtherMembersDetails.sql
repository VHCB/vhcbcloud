
CREATE procedure GetOtherMembersDetails
@UserId int,
@YrQrtrId int
as
Begin
	 Select MemberIncluded
	 from ACMemberPerfData
	 where UserID=@UserId and ACYrQtrID = @YrQrtrId and RowIsActive = 1
end