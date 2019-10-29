
CREATE procedure GetMenuDetailsByUser
(
@UserId int
)
as

Begin

-- exec GetMenuDetailsByUser 7 
  SELECT MenuID
		,MenuText
		,MenuDescription
		,Handler
		,IsDropDownToggle
		,ParentID
  FROM MENU where MenuDescription NOT IN
  (SELECT LUV.[Description]
  FROM  LOOKUPVALUES LUV INNER JOIN UserPageSecurity UPS ON LUV.TypeID = UPS.pageid AND lookuptype = 193 AND UPS.Userid = @UserId) and rowisactive = 1
end