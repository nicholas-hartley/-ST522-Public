* A ;

proc sql;
create view ST522.t_shirtsM3Q5 as
	select  d.Product_ID as Product_ID,
		d.Supplier_Name as Supplier_Name format=$20.,
		d.Product_Name as Product_Name,
		l.Unit_Sales_Price as Price label='Retail Price'
 	from ST522.product_dim as d,
		ST522.price_list as l
	where d.Product_ID = l.Product_ID and 
		find(d.Product_Name, "T-Shirt") ne 0;
quit;

* B ;

proc sql;
	title "Available T-Shirts";
	select *
	from ST522.t_shirtsM3Q5
	order by Supplier_Name, Product_ID;
quit;

* C ;

proc sql;
	title "T-Shirts under $20";
	select Product_ID,
		Product_Name,
		Price
	from ST522.t_shirtsM3Q5
	where Price < 20
	order by Price;
quit;