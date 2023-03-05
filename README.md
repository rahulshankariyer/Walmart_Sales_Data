# Walmart Sales Data

## Project Objective

In this project, we gathered sales data from Walmart to gain business related insights

## Data Used

For the purpose of this project, we used data on the <a href = "https://www.kaggle.com/datasets/rutuspatel/walmart-dataset-retail"> Weekly Sales of Walmart across 45 stores from February 2010 to October 2012 </a>

## Tools Used

1. Excel
2. Microsoft SQL Server Management Studio

## Data Cleaning

Using SQL Server Management Studio, the 'Date' column values, which were in different formats, were readjusted. Some of the values were numbers and so those were converted to date format using update operation in SQL:

    --Uniformizing all the dates into the same format

    update ProjectPortfolio..Walmart_Store_Sales
    set Date = cast((convert(datetime,convert(int,Date)) - 2) as date)
    where Date not like '%-%';

This leaves us with two sets of dates in different formats, where the updated set is now in the 'YYYY-MM-DD' format, while the set of dates not updated is in the 'DD-MM-YYYY' format. So to uniformize the dates, 3 new columns were added to the data - 'day','month','year' - using add operation in SQL:

    --Adding 'day','month','year' columns
    
    alter table ProjectPortfolio..Walmart_Store_Sales
    add day int,month int,year int;

The problem with the dates in the 'YYYY-MM-DD' format is that the month and the day are mismatched compared to the dates given in the original data. This results in, for example, February 5th being wrongly denoted as May 2nd from the above conversion. So for these dates, to make the 'day' and 'month' fields match those given in the original data, the 'day' field was updated by extracting month and the 'month' field was updated by extracting the month, as shown below:

    update ProjectPortfolio..Walmart_Store_Sales
    set day = month(Date),
    month = day(Date),
    year = year(Date)
    where Date like '____-%';

For the rest of the dates, which were in the 'DD-MM-YYYY' format, the update operation on the 'day', 'month' and 'year' fields was more straighforward:

    update ProjectPortfolio..Walmart_Store_Sales
    set day = cast(parsename(replace(Date,'-','.'),3) as int),
    month = cast(parsename(replace(Date,'-','.'),2) as int),
    year = cast(parsename(replace(Date,'-','.'),1) as int)
    where Date like '__-%';

Now that there are 3 separated fields for the day, month and year, the 'Date' was dropped using the drop option in SQL:

    --Removing 'Date' column

    alter table ProjectPortfolio..Walmart_Store_Sales
    drop column Date;

## Analysis

Using SQL, 4 Scatter Plots were created to determine the Correlation of the Weekly Sales against the following 4 factors:

    (i) Fuel Price
    (ii) Consumer Price Index (CPI)
    (iii) Unemployment Rate
    (iv) Temperature

Below are the scatter plots which depict the relationship between the Weekly Sales and the above 4 factors:

![alt text](https://raw.githubusercontent.com/rahulshankariyer/Walmart_Sales_Data/main/Correlation%20of%20Weekly%20Sales%20with%20Fuel%20Price%2C%20CPI%2C%20Unemployment%20and%20Temperature.png?token=GHSAT0AAAAAAB7SU4QATWOSYTDD2DYSQKO2ZAD3RKQ)

The correlation of Weekly Sales with these 4 factors is given in the below table:

![image](https://user-images.githubusercontent.com/103128153/222934162-b1c5bd89-2d22-4748-9338-b124a6269c66.png)

Many weeks in a year obviously have some holidays on weekdays, here's a look below at what percentage of the weeks had a holiday.

![alt text](https://raw.githubusercontent.com/rahulshankariyer/Walmart_Sales_Data/main/Percentage%20of%20Weeks%20with%20Holidays.png?token=GHSAT0AAAAAAB7SU4QADNNJAC6EHGLZ6WT4ZAD3QJQ)

Speaking of holidays, Weekly Sales are likely to be reduced on weeks having holidays. So below is a chart of the Average Weekly Sales on Full Weeks and Weeks with Holidays

![alt text](https://raw.githubusercontent.com/rahulshankariyer/Walmart_Sales_Data/main/Weekly%20Sales%20vs%20Holidays.png?token=GHSAT0AAAAAAB7SU4QAYQRDBY5KKTIM4P4AZAD3TNQ)

Walmart has 45 different stores, below is given the Average Weekly Sales of each of the Stores:

![alt text](https://raw.githubusercontent.com/rahulshankariyer/Walmart_Sales_Data/main/Sales%20per%20Store.png?token=GHSAT0AAAAAAB7SU4QBCVEEFP4HZEH5UX4EZAD33JA)

## Insights

1. The Stores had a Holiday during only 7% of the weeks
2. While the Weekly Wales generally increased with increase in Fuel Price, it generally decreased with increase in CPI, Unemployment Rate and Temperature
3. The Weekly Sales had the highest correlation with Unemployment Rate and lowest correlation with Fuel Price
4. Store #20 made the highest amount worth of Average Weekly Sales in the given period while Store #33 made the lowest amount worth of Average Weekly Sales
5. Only 4 out of the 45 stores made Average Weekly Sales of more than $2 Million - Store #s 20, 4, 14 & 13
6. Nearly half the stores - 20 of them - made a Average Weekly Sales of less than $1 Million
7. The month of December in this period saw the maximum sales, which could be attributed to Christmas and New Year, followed by July and April, which could be attributed to 4th of July and Easter respectively
8. The Average Weekly Sales on Weeks without holidays is roughly 80K more than that on Weeks with Holidays, thus showing that the Weekly Sales of Walmart were only affected by 7% on Weeks with Holidays
