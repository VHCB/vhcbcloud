
--exec GetNODDataByPCRID 66
create procedure GetNODDataByPCRID
(
	@ProjectCheckReqId int
)
as
begin
	select LKNOD from ProjectCheckReqNOD(nolock) where ProjectCheckReqID = @ProjectCheckReqID
end