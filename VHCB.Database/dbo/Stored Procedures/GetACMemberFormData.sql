
create procedure dbo.GetACMemberFormData
( 
	@ACMemberID		int,
	@Groupnum		int,
	@isActive		bit
) as
begin
--exec GetACMemberFormData 5, 1
	select ACMemberID, af.Groupnum, lv.description GroupName, Name, af.ACFormID, isnull(ACmemberformID, -99) ACmemberformID, isnull(Received, 0) Received, 
	Date as ReceivedDate, isnull(URL, '') URL, CASE when isnull(URL, '') = '' then '' else 'Click here' end as URLText,
	substring(Notes, 0, 25) Notes,  Notes as FullNotes, 
	isnull(amf.RowIsActive, 1) RowIsActive
	from acforms af(nolock)
	left join acmemberform amf(nolock) on amf.ACFormID = af.ACFormID and ACMemberID = @ACMemberID --and (@isActive = 0 or amf.RowIsActive = @isActive)
	join LookupValues lv(nolock) on lv.TypeID = af.Groupnum
	where af.Groupnum = @Groupnum  --and (@isActive = 0 or amf.RowIsActive = @isActive)
	order by ordernum
end