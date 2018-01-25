Create procedure AddFundingSource
(	
	@fsName varchar(35)
	
)
as

insert into fund (name)
values (@fsName)