CREATE procedure [dbo].[GetProjectName]
(
	@projName varchar(75)	
)
as 
Begin
	declare @recordId int
	select @recordId = RecordID from LkLookups where Tablename = 'LkProjectName' 
	
	select top 20 Description from LookupValues where LookupType = @recordId and Description like @projName +'%'
		
end