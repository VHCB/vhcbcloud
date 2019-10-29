CREATE procedure GetUserInfo  
as  
begin  
--exec GetUserInfo  
 select ui.userid, ui.Fname, ui.Lname, ui.Username, ui.password, ui.email, lv.typeid, ui.DfltPrg, lv.description, ui.securityLevel, usg.UserGroupName  
  from UserInfo ui(nolock)  
  left outer join LookupValues lv on lv.typeid = ui.DfltPrg  
  left outer join UserSecurityGroup usg on usg.UserGroupId = ui.securityLevel
  order by ui.DateModified desc   
end