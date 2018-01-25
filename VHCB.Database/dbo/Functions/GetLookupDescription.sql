Create FUNCTION [dbo].GetLookupDescription
    (
      @typeid INT 
    )
RETURNS varchar(500)
AS 
    BEGIN
        DECLARE @description AS varchar(500) ;
 
	select top 1 
		@description = description 
	from LookupValues where TypeID = @typeid

	RETURN  @description ;
    END