/*Q7*/

proc sql;
	title "2011 Total Sales Figures";
	select cat(Manager_First, ' ', Manager_Last) as Manager,
		cat(Employee_First, ' ', Employee_Last) as Employee,
		Total_Sales
	from (
		select scan(Names.EName, 1, ', ') as Employee_Last,
			scan(Names.EName, 2, ', ') as Employee_First,
			scan(Names.MName, 1, ', ')as Manager_Last, 
			scan(Names.MName, 2, ', ') as Manager_First,
			Sales.Total_Sales as Total_Sales,
			Names.Country as Country
		from (select e.Employee_ID as Employee_ID,
				e.Employee_Name as EName,
				e.Country as Country,
				m.Employee_ID as Manager_ID,
				m.Employee_Name as MName
			from ST522.employee_organization as o,
				ST522.employee_addresses as m,
				ST522.employee_addresses as e
			where e.Employee_ID = o.Employee_ID and
				o.Manager_ID = m.Employee_ID
		) as Names,
		(
			select Employee_ID,
				sum(Total_Retail_Price) as Total_Sales
			from ST522.order_fact
			where year(Delivery_Date) = 2011
			group by Employee_ID
		) as Sales
		where Names.Employee_ID = Sales.Employee_ID 
	) as Combined

	order by Country, Manager_Last, Manager_First, Total_Sales desc;
quit;