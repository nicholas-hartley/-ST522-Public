* A ;

proc sql;
create table ST522.employeesM3Q1 as
	select  a.Employee_ID as Employee_ID format=z8.,
        p.Employee_Hire_Date as Hire_date format=MMDDYY10.,
        p.Salary as Salary format=COMMA12.2,
        p.Birth_Date as Birth_Date format=MMDDYY10.,
        p.Employee_Gender as Gender format=$1.,
        a.Country as Country format=$2.,
        a.City as City format=$30.
	from ST522.employee_payroll as p,
        ST522.employee_addresses as a
	where p.Employee_ID=a.Employee_ID
	order by year(Hire_date),salary desc;

quit;

* B ;

proc sql;
	select *
	from ST522.employeesM3Q1
	order by year(Hire_date),salary desc;
quit;