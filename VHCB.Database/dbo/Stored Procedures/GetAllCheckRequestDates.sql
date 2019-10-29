
create procedure [dbo].GetAllCheckRequestDates
as
Begin
	select crdateid, crdate from checkrequestdates 
	where rowisactive = 1
	order by crdate desc

End