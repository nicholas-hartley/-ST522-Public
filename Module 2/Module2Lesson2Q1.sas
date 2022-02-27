/*Q1*/

*A;
/*
proc sql;
	select avg(Total_Retail_Price) as MeanSales
	from ST522.order_fact
	where Order_Type=1;
	
quit;
*/
*B;

proc sql;
	title "Customers Whose Average Retail Price Exceeds the Average Retail Price for All Customers";
	select Customer_ID, avg(Total_Retail_Price) as MeanPrice /*This is meansales in the output in the doc*/
	from ST522.order_fact
	where Order_Type=1
	group by Customer_ID
	having avg(Total_Retail_Price) > 
		(select avg(Total_Retail_Price)
		 from ST522.order_fact
		 where Order_Type=1
		 );
	
quit;

