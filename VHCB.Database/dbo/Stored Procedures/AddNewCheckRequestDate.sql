
Create procedure [dbo].[AddNewCheckRequestDate]
(
	@dtVoucherDate date
)
as 
BEGIN 

	insert into CheckRequestDates(CRDate)
	values (@dtVoucherDate)	

END