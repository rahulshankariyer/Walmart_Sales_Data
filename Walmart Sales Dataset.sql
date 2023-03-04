select * from ProjectPortfolio..Walmart_Store_Sales;

select *,
cast((convert(datetime,convert(int,Date)) - 2) as date)
from ProjectPortfolio..Walmart_Store_Sales
where Date not like '%-%';

select *,
day(Date) as date,
month(Date) as month_of_year,
year(Date) as annum
from ProjectPortfolio..Walmart_Store_Sales
where Date like '____-%';

--Uniformizing all the dates into the same format

update ProjectPortfolio..Walmart_Store_Sales
set Date = cast((convert(datetime,convert(int,Date)) - 2) as date)
where Date not like '%-%';

alter table ProjectPortfolio..Walmart_Store_Sales
add day int,month int,year int;

update ProjectPortfolio..Walmart_Store_Sales
set day = cast(parsename(replace(Date,'-','.'),3) as int),
month = cast(parsename(replace(Date,'-','.'),2) as int),
year = cast(parsename(replace(Date,'-','.'),1) as int)
where Date like '__-%';

update ProjectPortfolio..Walmart_Store_Sales
set day = month(Date),
month = day(Date),
year = year(Date)
where Date like '____-%';

--Removing Date column

alter table ProjectPortfolio..Walmart_Store_Sales
drop column Date;

--View in Ascending order of dates

select * from ProjectPortfolio..Walmart_Store_Sales
order by year,month,day,store;

--Number of Days of data: 143

select day,month,year,count(*)
from ProjectPortfolio..Walmart_Store_Sales
group by day,month,year
order by year,month,day;

--Number of Stores: 45

select store,count(*) as weeks
from ProjectPortfolio..Walmart_Store_Sales
group by store
order by store;

--Check how may days are holidays

select Holiday_Flag,count(*) as No_of_Days
from ProjectPortfolio..Walmart_Store_Sales
group by Holiday_Flag;

--Monthly sales

select month,year,sum(weekly_sales) as total_monthly_sales
from ProjectPortfolio..Walmart_Store_Sales
group by month,year
order by year,month;

--Average sales per store

select Store,avg(weekly_sales) as avg_store_sales
from ProjectPortfolio..Walmart_Store_Sales
group by Store
order by Store;

--Average Weekly Sales on Full Weeks & Weeks with Holidays

select Holiday_Flag,avg(weekly_sales) as avg_store_sales
from ProjectPortfolio..Walmart_Store_Sales
group by Holiday_Flag
order by Holiday_Flag;