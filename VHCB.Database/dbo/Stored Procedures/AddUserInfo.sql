CREATE procedure AddUserInfo  
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