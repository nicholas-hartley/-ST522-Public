/*Q6*/

*A;

proc sql;
	select Department,
		Dept_Salary_Total
	from (
		select Department,
			sum(Salary) as Dept_Salary_Total
		from ST522.employee_payroll as ep,
			ST522.employee_organization as eo
		where ep.Employee_ID = eo.Employee_ID
		group by eo.Department
	)
	order by Department;	
quit;

*B;

proc sql;
	select Employee_ID,
		Employee_Name,
		Department
	from (
		select ea.Employee_ID as Employee_ID,
			eo.Department as Department,
			ea.Employee_Name as Employee_Name
		from ST522.employee_addresses as ea
		inner join ST522.employee_organization as eo
		on ea.Employee_ID = eo.Employee_ID
	) as Combined
	order by Employee_Name;
quit;

*C;

proc sql;
	title "Employee Salaries as a percent of Department Total";
	select C.Department,
		C.Employee_Name,
		ep.Salary,
		(ep.Salary / C.Dept_Salary_Total) as Percent
	from (
		select A.Department as Department,
			A.Dept_Salary_Total as Dept_Salary_Total,
			B.Employee_ID as Employee_ID,
			B.Employee_Name as Employee_Name
		from (
			select Department,
				sum(Salary) as Dept_Salary_Total
			from ST522.employee_payroll as ep,
				ST522.employee_organization as eo
			where ep.Employee_ID = eo.Employee_ID
			group by eo.Department
			) as A
		inner join (
			select ea.Employee_ID as Employee_ID,
				eo.Department as Department,
				ea.Employee_Name as Employee_Name
			from ST522.employee_addresses as ea
			inner join ST522.employee_organization as eo
			on ea.Employee_ID = eo.Employee_ID
			) as B
		on A.Department = B.Department
	) as C
	inner join ST522.employee_payroll as ep
	on ep.Employee_ID = C.Employee_ID
	order by Department, Percent desc;
quit;