CREATE procedure [dbo].[GetBoardDates]
as	
begin
-- dbo.GetBoardDates
	set nocount on   
	  
	select TypeID, convert(varchar(10), BoardDate, 101) as BoardDate, MeetingType
	from [dbo].[LkBoardDate]
	order by BoardDate desc

	if (@@error <> 0)    
    begin  
        raiserror ( 'GetBoardDates' , 0 ,1)  
        return 1  
    end  
end