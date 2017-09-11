alter  procedure GetUserInfo  
as  
begin  
--exec GetUserInfo  
 select ui.userid, ui.Fname, ui.Lname, ui.Username, ui.password, ui.email, lv.typeid, ui.DfltPrg, lv.description, ui.securityLevel, usg.UserGroupName  
  from UserInfo ui(nolock)  
  left outer join LookupValues lv on lv.typeid = ui.DfltPrg  
  left outer join UserSecurityGroup usg on usg.UserGroupId = ui.securityLevel
  order by ui.DateModified desc   
end  
go

alter procedure AddUserInfo  
(  
 @Fname  varchar(40),   
 @Lname  varchar(50),   
 @password varchar(40),   
 @email  varchar(150),  
 @DfltPrg int,
 @dfltSecGrp int 
)  
as  
begin  
  
 declare @Username varchar(100)  
  
 set @Username = lower(left(@Fname, 1) + @Lname)  
  
 insert into UserInfo( Fname, Lname, Username, password, email, DfltPrg, securityLevel) values   
   ( @Fname, @Lname, @Username, @password, @email, @DfltPrg, @dfltSecGrp)  
end  
go

alter procedure UpdateUserInfo    
(    
 @userid  int,    
 @Fname  varchar(40),     
 @Lname  varchar(50),     
 @password varchar(40),     
 @email  varchar(150),    
 @DfltPrg int,  
 @dfltSecGrp int  
)    
as    
begin    
    
 declare @Username varchar(100)    
    
 set @Username = lower(left(@Fname, 1) + @Lname)    
    
 update UserInfo set Fname = @Fname, Lname = @Lname, Username = @Username, email = @email, password = @password, DfltPrg = @DfltPrg,  
 securityLevel = @dfltSecGrp  
  
 where userid = @userid    
     
end 
go

alter procedure GetFundTypeDescription
(
	@fundTypedesc varchar(150)	
)
as 
Begin
	select lkf.Description from lkfundtype  lkf join LookupValues lkv on lkv.TypeID = lkf.LkSource
	where lkv.LookupType = 40 and lkf.Description like @fundTypedesc +'%'  order by lkf.Description 

end