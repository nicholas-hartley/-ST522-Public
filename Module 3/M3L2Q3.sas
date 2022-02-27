
proc sql;
create table direct_compensation as
	select  s.Employee_ID as Employee_ID format=8.,
        cat(s.First_Name, ' ', s.Last_Name) as Name length=30 format=$30.,
        scan(s.Job_Title, 3, ' ') as Level format=$3.,
        s.Salary as Salary format=COMMA12.2,
        Comm.Commission as Commission,
        Comm.Commission + s.Salary as Direct_Compensation
	from ST522.sales as s,
		(
		select Employee_ID,
			sum(of.Total_Retail_price)*0.15 as Commission
		from ST522.order_fact as of
		group by Employee_ID
		) as Comm
	where Comm.Employee_ID=s.Employee_ID 
	order by Level, Direct_Compensation desc;
quit;

proc sql;
	select *
	from direct_compensation;
quit;