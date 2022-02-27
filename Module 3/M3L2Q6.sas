* A ;

proc sql;
create view ST522.current_catalogM3Q6 as
	select  *
 	from ST522.product_dim as d,
		(
		select Product_ID,
			Unit_Sales_Price*(Factor**(year(Today())-year(Start_date))) as Price format=DOLLAR7.2
		from ST522.price_list
		) as l
	where d.Product_ID = l.Product_ID;
quit;

* B ;

proc sql;
	title "Current Roller Skate Prices";
	select Supplier_Name,
		Product_Name,
		Price
	from ST522.current_catalogM3Q6
	where find(Product_Name, "Roller Skate") ne 0
	order by Supplier_Name, Price;
quit;

* C ;


proc sql;
	title "2012 prices > 5 higher than original";
	select c.Product_Name as Product_Name,
		l.Unit_Sales_Price as Unit_Sales_Price,
		c.Price as Price,
		c.Price-l.Unit_Sales_Price as Increase format=DOLLAR7.2
	from ST522.current_catalogM3Q6 as c,
		ST522.price_list as l
	where c.Product_ID = l.Product_ID and
		c.Price-l.Unit_Sales_Price > 5 
	order by Increase desc;
quit;