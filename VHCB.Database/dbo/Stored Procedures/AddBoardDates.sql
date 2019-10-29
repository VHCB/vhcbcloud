Create procedure AddBoardDates
(	
	@boardDate date,
	@meetingType varchar(50)
)
as 

begin
	insert into  LkBoardDate (BoardDate,MeetingType)
	values  (@boardDate,@meetingType)
	
End