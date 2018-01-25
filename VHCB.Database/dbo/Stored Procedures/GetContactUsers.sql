
CREATE procedure [dbo].[GetContactUsers]
as
Begin
	select c.contactid, c.Lastname + ', '+c.firstname +' - '+lv.Description as name from Contact c join
	LookupValues lv on lv.TypeID = c.LkPosition order by c.Lastname
	
End