create procedure [dbo].[get_sublookup_values]
(
	@TypeId int
) as	
begin
-- dbo.get_lookup_values 29
-- dbo.get_lookup_values 113
	set nocount on   
	

		select SubTypeID, SubDescription, Ordered
		from LookupSubValues 
		where rowisactive = 1 and typeid = @TypeId
		order by Ordered
	
	if (@@error <> 0)    
    begin  
        raiserror ( 'get_lookup_values %d' , 0 ,1 , @TypeId)  
        return 1  
    end  
end