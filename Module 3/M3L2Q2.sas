* A ;

proc sql;
create table ST522.rewardsM3Q2
	(
	Purchased num format=COMMA6.2,
	Year num format=4.,
	Level char length=8,
	Award char length=50
	);
quit;

* B ;

proc sql;
	insert into ST522.rewardsM3Q2
		values (200.00, 2012, 'Silver', "25% Discount on one item over $25")
		values (300.00, 2012, 'Gold', "15% Discount on one order over $50")
		values (500.00, 2012, 'Platinum', "10% Discount on all 2012 Purchases")
		values (225.00, 2013, 'Silver', "25% Discount on one item over $50")
		values (350.00, 2013, 'Gold', "15% Discount on one order over $100")
		values (600.00, 2013, 'Platinum', "10% Discount on all 2013 Purchases");
quit;

proc sql;
	select *
	from ST522.rewardsM3Q2;
quit;