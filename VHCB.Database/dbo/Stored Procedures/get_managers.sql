
create procedure dbo.get_managers
as	
begin
-- dbo.get_managers
	set nocount on   
	  
	select UserId, ltrim(rtrim(Lname)) + ', ' + ltrim(rtrim(Fname)) Name from userinfo
	order by Lname

	if (@@error <> 0)    
    begin  
        raiserror ( 'get_managers' , 0 ,1)  
        return 1  
    end  
end