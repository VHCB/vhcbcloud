declare @ProjectCheckReqid int

set @ProjectCheckReqid = 93

select * from ProjectCheckReq where ProjectCheckReqid = @ProjectCheckReqid

select * from Trans where ProjectCheckReqid = @ProjectCheckReqid

select * from Detail where TransId in(select transid from Trans where ProjectCheckReqid = @ProjectCheckReqid)

select * from ProjectCheckReqNOD where  ProjectCheckReqid = @ProjectCheckReqid

select * from ProjectCheckReqQuestions where  ProjectCheckReqid = @ProjectCheckReqid
