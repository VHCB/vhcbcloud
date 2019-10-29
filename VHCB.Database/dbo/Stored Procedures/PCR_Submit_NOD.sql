
CREATE procedure PCR_Submit_NOD
(
	@ProjectCheckReqID	int, 
	@LKNOD				int
)
as
begin
	insert into ProjectCheckReqNOD(ProjectCheckReqID, LKNOD)
	values(@ProjectCheckReqID, @LKNOD)
end