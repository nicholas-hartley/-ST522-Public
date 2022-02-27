/*Q4*/

proc sql;
	title "Latest Order Date for Orion Club Low Activity Members";
	select Customer_ID,
		Last LABEL="Order Date" FORMAT=date9. as Order
	from
		/* This gets the last date per customer in the low activity subquery*/
		(
			select Customer_ID, 
				max(Order_Date) as Last
			from ST522.order_fact as of
			where of.Customer_ID in 
			/* This subquery just gets the unique customer id's that are low
			activity, also the column names are apparently different in the 
			different tables*/
				(
				select unique CustomerID
				from ST522.customer_type as ct,
					ST522.customer as c
				where ct.Customer_Type = 'Orion Club members low activity' and
					c.CustomerTypeID = ct.Customer_Type_ID
				)
			group by of.Customer_ID
			) as MaxDate
			/* This is the condition for if the last order date for the 
			virtual table is old enough*/
	where '01JAN2012'd > MaxDate.Last;
quit;