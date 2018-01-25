Create procedure UpdateBoardDates
(
	@typeId tinyint,
	@boardDate date,
	@meetingType varchar(50)
)
as 

begin
	update LkBoardDate set BoardDate = @boardDate, MeetingType = @meetingType
	where TypeID = @typeId
End