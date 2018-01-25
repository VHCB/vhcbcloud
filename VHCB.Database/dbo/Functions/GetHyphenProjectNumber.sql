CREATE FUNCTION dbo.GetHyphenProjectNumber 
(
	@Original_Project_Num VARCHAR(50)
)
RETURNS VARCHAR(50)
AS BEGIN
Declare @Project_Num varchar(50)
set @Project_Num = replace(@Original_Project_Num, '-', '')-- '1222222221'
Declare @FinalNum varchar(50)

if(len(@Project_Num) > 4)
begin
	--print 'Here1'
	--set @FinalNum = STUFF(STUFF(@Project_Num, LEN(@Project_Num)-  2, 0,'-'), LEN(@Project_Num) + 1, 0,'-')
	set @FinalNum = STUFF(@Project_Num, 5, 0,'-')
	if(len(@Project_Num) > 7)
	begin
		--print 'Here2'
		set @FinalNum = STUFF(@FinalNum, 9, 0,'-')
	end
end
else
begin
	--print 'Here'
	set @FinalNum = @Project_Num
end
return  @FinalNum
end