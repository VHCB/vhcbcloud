CREATE procedure GetFundTypeDescription
(
	@fundTypedesc varchar(150)	
)
as 
Begin
	select lkf.Description from lkfundtype  lkf join LookupValues lkv on lkv.TypeID = lkf.LkSource
	where lkv.LookupType = 40 and lkf.Description like @fundTypedesc +'%'  order by lkf.Description 

end