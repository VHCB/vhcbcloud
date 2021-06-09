select * from address where datemodified > '2019-08-20 22:17:58.780' and datemodified < '2019-08-20 22:19:59.873' order by datemodified desc
--404

select * from address where datemodified > '2019-08-22 22:13:14.047' and datemodified < '2019-08-23 00:14:15.213' order by datemodified desc
--387

select * from ProjectAddress where datemodified > '2019-08-20 22:17:58.780' and datemodified < '2019-08-20 22:19:59.873' order by datemodified desc
--478

select * from ProjectAddress where datemodified > '2019-08-22 22:13:14.047' and datemodified < '2019-08-23 00:14:15.213' order by datemodified desc
--462


select * from AddressConversion
--478

select * from AddressConversion2
--462

begin tran

delete from ProjectAddress where datemodified > '2019-08-20 22:17:58.780' and datemodified < '2019-08-20 22:19:59.873'

delete from ProjectAddress where datemodified > '2019-08-22 22:13:14.047' and datemodified < '2019-08-23 00:14:15.213'


delete from address where datemodified > '2019-08-20 22:17:58.780' and datemodified < '2019-08-20 22:19:59.873'


delete from address where datemodified > '2019-08-22 22:13:14.047' and datemodified < '2019-08-23 00:14:15.213'

commit


select * from ProjectAddress where userid = 9999 order by 1 desc
select * from Address where userid = 9999 order by 1 desc


delete from Address where userid = 9999
delete from ProjectAddress where userid = 9999 