/*Q2*/

%let my_date_formatted = %sysfunc(today(), MONTH.);
%PUT &my_date_formatted;

/* A;
proc sql;
	title "Employee IDs for Current Month Anniversaries";
	select Employee_ID
	from ST522.employee_payroll 
	having MONTH(Employee_Hire_Date) = &my_date_formatted;  
quit;
*/

* B ;

proc sql;
	title "Employees with Current Month Anniversaries";
	select Employee_ID, 
		scan(Employee_Name, 2, ",") LENGTH=15 LABEL="First Name" as First, 
		scan(Employee_Name, 1, ",") LENGTH=15 LABEL="Last Name" as Last
	from ST522.employee_addresses
	where Employee_ID in 
		(select Employee_ID
		from ST522.employee_payroll 
		where MONTH(Employee_Hire_Date) = &my_date_formatted
		)
	order by Last;
quit;