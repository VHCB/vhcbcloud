CREATE FUNCTION [dbo].[CheckIsBalanceZero] (@TransId int)
RETURNS bit
AS
BEGIN
  DECLARE @TransAmount money
  DECLARE @DetailsAmount money
  Declare @IsBalanceZero bit

  select @TransAmount = isnull(TransAmt, 0) from Trans(nolock) where TransId = @TransId
 
  select @DetailsAmount = sum(isnull(Amount, 0)) from Detail (nolock) where TransId = @TransId and RowIsActive = 1 --and Amount > 0

  if(@TransAmount = @DetailsAmount)
	set @IsBalanceZero = 1
  else
	set @IsBalanceZero = 0

  RETURN @IsBalanceZero
END