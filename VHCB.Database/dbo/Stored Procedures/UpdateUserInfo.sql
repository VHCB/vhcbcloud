  
CREATE procedure UpdateUserInfo  
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