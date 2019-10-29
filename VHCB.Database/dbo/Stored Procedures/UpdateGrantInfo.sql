CREATE procedure [dbo].[UpdateGrantInfo]
(	
	@GrantInfoId int
	,@GrantName nvarchar(50)
	,@VHCBName nvarchar(50)
	,@LkGrantor int
	,@LkGrantSource int = null
    ,@AwardNum nvarchar(25)
    ,@AwardAmt money
    ,@BeginDate datetime = null
    ,@EndDate datetime = null
    ,@Staff int = null
    ,@ContactID int = null
    ,@CFDA nchar(5)
    ,@SignAgree bit
    ,@FedFunds bit
    ,@Match bit
    ,@Fundsrec bit
    ,@Admin bit
)
as
Begin
	update GrantInfo set GrantName = @GrantName 
		    ,VHCBName = @VHCBName 
		    --,LkGrantor = @LkGrantor
		    ,LkGrantSource= @LkGrantSource 
			,AwardNum= @AwardNum
			,AwardAmt = @AwardAmt
			,BeginDate = @BeginDate
			,EndDate = @EndDate
			,Staff = @Staff
			,ContactID = @ContactID
			,CFDA = @CFDA
			,SignAgree = @SignAgree
			,FedFunds = @FedFunds
			,Match = @Match
			,Fundsrec = @Fundsrec
			,[Admin] = @Admin
	where GrantinfoID = @GrantInfoId
End