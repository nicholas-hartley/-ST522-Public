* A ;

proc sql;
create view ST522.phone_listM3Q4 as
	select  o.Department as Department format=$25.,
		a.Employee_Name as Name format=$25.,
		p.Phone_Number as Phone_Number label='Home Phone' format=$16.
 	from ST522.employee_addresses as a,
		ST522.employee_organization as o,
		ST522.employee_phones as p
	where p.Phone_Type = 'Home' and
		p.Employee_ID = o.Employee_ID and
		o.Employee_ID = a.Employee_ID
	order by Department;
quit;

* B ;

proc sql;
	title "Engineering Department Home Phone Numbers";
	select Name,
		Phone_Number
	from ST522.phone_listM3Q4
	where Department = "Engineering"
	order by Name;
quit;