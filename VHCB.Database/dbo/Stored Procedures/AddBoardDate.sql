Create procedure [dbo].[AddBoardDate]
(
	@BoardDate datetime,
	@meetingType varchar(50)
)
as

Begin
	Insert into LkBoardDate (BoardDate, MeetingType)
	values (@BoardDate, @meetingType)
End