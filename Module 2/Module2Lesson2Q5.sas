/*Q5*/

*A;

proc sql;
	title "2011 Sales Force Sales Statistics For Employees With $200.00 or More In Sales";
	select Country, 
		First_Name, 
		Last_Name, 
		Value_Sold, 
		Orders, 
		Avg_Order
	from (
		select Country, 
			First_Name, 
			Last_Name, 
			sum(Total_Retail_Price) FORMAT=7.2 as Value_Sold, 
			count(distinct Order_ID) as Orders, 
			(calculated Value_Sold/ calculated Orders) FORMAT=7.2 as Avg_Order
		from ST522.order_fact as of,
			ST522.sales as s
		where s.Employee_ID = of.Employee_ID and
			year(Order_Date) = 2011          
		group by Country, First_Name, Last_Name
	) as Combined
	where Value_Sold ge 200
	order by Country, Value_Sold desc, Orders desc;
quit;

*B;

proc sql;
	title "2011 Sales Summary By Country";
	select Country, 
		max(Value_Sold) FORMAT=7.2 as MaxVal, 
		max(Orders) FORMAT=4.2 as MaxOrd, 
		max(Avg_Order) FORMAT=7.2 as MaxAvg,
		min(Avg_Order) FORMAT=7.2 as MinAvg
	from (
		select Country, 
			First_Name, 
			Last_Name, 
			sum(Total_Retail_Price) FORMAT=7.2 as Value_Sold, 
			count(distinct Order_ID) as Orders, 
			(calculated Value_Sold/ calculated Orders) FORMAT=7.2 as Avg_Order
		from ST522.order_fact as of,
			ST522.sales as s
		where s.Employee_ID = of.Employee_ID and
			year(Order_Date) = 2011          
		group by Country, First_Name, Last_Name
	) as Combined
	where Value_Sold ge 200
	group by Country
	order by Country;
quit;