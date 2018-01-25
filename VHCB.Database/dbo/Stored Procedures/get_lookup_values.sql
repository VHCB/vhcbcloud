
create procedure [dbo].[get_lookup_values]
(
	@lookuptype int
) as	
begin
-- dbo.get_lookup_values 29
-- dbo.get_lookup_values 113
	set nocount on   
	
	declare @Count int
	declare @MaxOrdering int

	select @Count = count(*), @MaxOrdering = max(lv.ordering) 
	from lookupvalues lv(nolock)
	join LkLookups lu(nolock) on lv.lookuptype = lu.recordid
	where lv.rowisactive = 1 and lu.ordered = 1
	and lookuptype = @lookuptype

	if(@Count = @MaxOrdering)
	begin
		select typeid, description, ordering
		from lookupvalues 
		where rowisactive = 1 and lookuptype = @lookuptype
		order by ordering
	end 
	else
	begin
		select typeid, description, ordering
		from lookupvalues 
		where rowisactive = 1 and lookuptype = @lookuptype
		order by description
	end

	if (@@error <> 0)    
    begin  
        raiserror ( 'get_lookup_values failed for lookuptype %d' , 0 ,1 , @lookuptype)  
        return 1  
    end  
end