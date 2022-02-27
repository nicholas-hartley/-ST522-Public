/*Q3*/

%let date = 02FEB2013;
%PUT &date;

proc sql;
	title "Level I or II Purchasing Agents Who are older than ALL Purchasing Agent IIIs ";
	select Employee_ID, 
		Job_Title LABEL="Employee Job Title ", 
		Birth_Date LABEL="Employee Birth Date",
		floor(yrdif(Birth_Date, '02FEB2013'd)) as Age
	from ST522.staff
	where Job_Title in ('Purchasing Agent I', 'Purchasing Agent II') 
		and yrdif(Birth_Date, '02FEB2013'd) > all(
			select yrdif(Birth_Date, '02FEB2013'd) as Age
			from ST522.staff
			where Job_Title = 'Purchasing Agent III'
			);
quit;