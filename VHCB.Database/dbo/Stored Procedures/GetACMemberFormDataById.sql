
create procedure dbo.GetACMemberFormDataById
(
	@ACmemberformID		int
) as
begin
	select amf.ACMemberID, amf.ACFormID, amf.Received, convert(varchar(10), amf.Date, 101)   as ReceivedDate, amf.URL, 
	substring( amf.Notes, 0, 25) Notes,  amf.Notes as FullNotes, amf.RowIsActive, amf.DateModified, 
	af.[Name] FormName, af.Groupnum
	from acmemberform amf(nolock)
	join acforms af(nolock) on amf.ACFormID = af.ACFormID
	where ACmemberformID = @ACmemberformID 
end