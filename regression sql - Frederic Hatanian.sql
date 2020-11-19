# question 5
ALTER TABLE housing.regression_data_clean 
DROP column date;

select * from regression_data_clean
limit 10;

# question 6
select count(id) from regression_data_clean;

# question 7
#bedrooms
select distinct(bedrooms), count(id)
from regression_data_clean
group by bedrooms
order by bedrooms;
# it seems we have a few houses with a lot of bedrooms and even one house with 33 bedrooms, let check what it looks like

select * from regression_data_clean
where bedrooms > 7
order by bedrooms;
# considering the surface it is very likely that the data for the house with 33 rooms is wrong
# we should delete that row as it is an outlier
delete from regression_data_clean
where bedrooms = 33;

#bathrooms
select distinct(bathrooms), count(id)
from regression_data_clean
group by bathrooms
order by bathrooms;
# I had to look up what 1.75 bathroom means but apart from that everything looks normal
# we can still check the lower and upper ends to make sure everything is normal

select * from regression_data_clean
where bathrooms >=6 or bathrooms <1
order by bathrooms;
# there seem to be an issue with some of the houses with 0.5 bathrooms, 
# especially the one that has 4 bedrooms and 0.5 bathrooms,
# as this is not too far from the the rest of the values, we should leave them

#Floors
select distinct(floors), count(id)
from regression_data_clean
group by floors
order by floors;
# let's check houses that have 4 floors

select * from regression_data_clean
where floors =4
order by sqft_living;
# as we can see, apart from the biggest house,
# it is very unlikely that this houses would actually have 4 floors as the sqft_living is too small,
# it is however not impossible so I will leave them

#Condition
select distinct(regression_data_clean.condition), count(id), avg(price)
from regression_data_clean
group by regression_data_clean.condition
order by regression_data_clean.condition;
# it looks like the average price of houses in condition 1 is higher than the ones in condition 2

select * from regression_data_clean
where regression_data_clean.condition = 1
order by price;
# the previous observation is probable caused by a bunch of huge very old houses that skew the data

#Condition
select distinct(grade), count(id)
from regression_data_clean
group by grade
order by grade;
# let's look at the lower and higher ends

select * from regression_data_clean
where grade <= 3 or grade = 13
order by price;
# nothing particular to observe

# question 8
select id, price from regression_data_clean
order by price desc
limit 10;

# question 9
select round(avg(price),0) from regression_data_clean;

# question 10
select bedrooms, round(avg(price),0) as average_price from regression_data_clean
group by bedrooms
order by bedrooms;

select bedrooms, round(avg(sqft_living),0) as average_sqft, round((avg(sqft_living)/10.764),0) as average_sqm from regression_data_clean
group by bedrooms
order by bedrooms;

select waterfront, round(avg(price),0) as average_price from regression_data_clean
group by waterfront
order by waterfront;

select regression_data_clean.condition, avg(grade) from regression_data_clean
group by regression_data_clean.condition
order by regression_data_clean.condition;
# there is no correlation between the condition and the grade

# question 11
select * from regression_data_clean
where bedrooms in (3,4) 
	and bathrooms>3 
    and floors =1 
    and waterfront = 0 
    and regression_data_clean.condition >= 3 
    and grade >= 5 
    and price < 300000;
# nothing for these very demanding people

# question 12
select id, price from regression_data_clean
where price > (select avg(price) from regression_data_clean);

# question 13
create view more_than_average as 
(select id, price from regression_data_clean
where price > (select avg(price) from regression_data_clean));

# question 14
select bedrooms, round(avg(price),0) from regression_data_clean
where bedrooms in (3,4) 
group by bedrooms
order by bedrooms;

# question 15
select distinct(zipcode) from regression_data_clean;

# question 16
SELECT id FROM housing.regression_data_clean
where sqft_living15 != sqft_above;

# question 17
select * from (select *, rank() over (order by price desc) as ranking from regression_data_clean) as ranking_table
where ranking = 11;

# I then exported the data and will use it to work in jupyter notebook (that did not work in the end)