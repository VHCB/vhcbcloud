

CREATE procedure [dbo].[GetVHCBUser]
as
begin
	select ui.userid,  (LNAME+', '+FNAME) as Name, ui.Username, ui.password, ui.email 
		from UserInfo ui(nolock)	where rowisactive = 1	
	 order by ui.Lname  
end