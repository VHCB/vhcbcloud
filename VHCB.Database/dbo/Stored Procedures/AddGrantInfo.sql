CREATE procedure [dbo].[AddGrantInfo]

(
	@fundId int
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
INSERT INTO dbo.GrantInfo
           (
		   
		   GrantName
           ,VHCBName
           --,LkGrantor
           ,LkGrantSource
           ,AwardNum
           ,AwardAmt
           ,BeginDate
           ,EndDate
           ,Staff
           ,ContactID
           ,CFDA
           ,SignAgree
           ,FedFunds
           ,Match
           ,Fundsrec
           ,[Admin]
           
          )
     VALUES
            (
	
	@GrantName 
	,@VHCBName 
	--,@LkGrantor
    ,@LkGrantSource
    ,@AwardNum 
    ,@AwardAmt 
    ,@BeginDate 
    ,@EndDate 
    ,@Staff
    ,@ContactID
    ,@CFDA 
    ,@SignAgree
    ,@FedFunds
    ,@Match
    ,@Fundsrec
    ,@Admin
     );

	insert into FundGrantinfo (FundID, GrantinfoID)
	values(@fundId, @@IDENTITY);
End


select * from FundGrantinfo