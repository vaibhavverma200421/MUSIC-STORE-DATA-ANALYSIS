
-- EASY QUESTION FROM 1 TO 5 


 -- Question 1 -> who is the senior most employee based on job title ?

select * from employee
order  by levels desc
limit 1 ;  -- shows only one row.

-- Answer 1  is --> madan mohan whi has a level 7.( he is the most senior)



 -- Question 2 -> which countries  have the most invoices ?
select * from invoice;

select count(*) as c, billing_country
from invoice
group by billing_country
order by c  desc;

-- Answer is ---> USA ( it has the highest ivoices among other countries)






 -- Question 3 --> what are the top 3 values of total invoices ?

select * from invoice

order by total desc
limit 1;

-- answer 3 is --->  23.759999999999




-- question 4 -- > which city has the best customers? We would like to throw a promotional
--music festival in the city we made the most money. Write a query that returns one city 
-- that has the highest sum of invoice totals.Return bith the city name and sum of all inovoices total.
 
select * from invoice;


select sum(total ) as invoice_total , billing_city
from invoice
group by billing_city
order by invoice_total desc;


-- answer 4 is ---> so the city with the highest invoice_total is prague = 273.240000007
-- and best custimers are also from the prague city.



-- question 5 -->  who is the best customer? the cutsomer who has spent the most money will be declared the best customer.
-- write a query that returns the person who has spent the mostb amount of money.
select * from customer;
-- one thins is clear from this table that we have nothing is this table realted to invoice data.
-- so we have to join these two tables.



select customer.customer_id,customer.first_name,customer.last_name , sum(invoice.total ) as invoice_total
from customer
join invoice on customer.customer_id  =  invoice.customer_id 
group by customer.customer_id
order by invoice_total desc
limit 5 ;




-- MODERATE QUESTION 5 TO  10.


-- question 5 --> write a query to retuurn the emoail , first_name , last_name and genre 
-- all rock music listners. return your list ordered alphabetically  by email starting with A .

select * from customer;
select * from genre;

select  distinct email,first_name,last_name 
from customer
join invoice on customer.customer_id = invoice.customer_id
join invoice_line on invoice.invoice_id = invoice_line.invoice_id
where track_id in(
    select track_id from track 
	join genre on track.genre_id = genre.genre_id
	where genre.name like 'Rock'
)
order by email ;


-- question 6  --> 	return the name and milliseonds from each track order by the song length 
-- with the longest listed first .



-- question 6  --> 	return the name and milliseonds from each track order by the song length 
-- with the longest listed first .

select * from track;

select name, milliseconds 
from track 
where milliseconds > ( 
select avg(milliseconds) as average_songs_legth  
from track
)

order by milliseconds desc;



--ADVANCED QUESTIONS 

-- question 8 ---> find how much amount spent by each customer on artists? write a query to return customer name 
-- artist name and total spent.

select * from invoice;

-- so for this we will have to take data from customer,artist and invoice table and invoice_line table.

with best_selling_artist as (
select artist.artist_id as artist_id, artist.name as artist_name, -- to now which artist has made the most amount of sales. 
sum(invoice_line.unit_price * invoice_line.quantity) as total_sales -- to now the sales proce of tracks
from invoice_line 
join track on track.track_id = invoice_line.track_id
join album on album.album_id = track.album_id
join artist on artist.artist_id = album.artist_id
group by 1
order by 3 desc
limit 5
)
select c.customer_id, c.first_name, c.last_name, bsa.artist_name,
sum(il.unit_price * il.quantity) as amount_spent
from invoice i
join customer c on c.customer_id = i.customer_id 

join invoice_line il on il.invoice_id = i.invoice_id
join track t on t.track_id = il.track_id
join album alb on alb.album_id = t.album_id 
join best_selling_artist bsa  on bsa.artist_id = alb.artist_id
group by 1,2,3,4
order by 5 desc;




--- QUESTION 9 --> we want to find out the most popular music genre for 
                -- each country. we determine the most popular 
                -- genre as the genre with the highest amount of purchases.
			    -- write a query that returns each country along with the top genre.
				-- for countries where the maximum number of purchases is shared return all 
				-- genres.
				
select * from track;

with popular_genres as 
(
    select count(invoice_line.quantity) as purchases,customer.country, genre.name, genre.genre_id,
	row_number () over(partition  by customer.country order by count(invoice_line.quantity) desc ) as RowNo
	from invoice_line 
	
	join invoice on invoice.invoice_id = invoice_line.invoice_id 
	join customer on customer.customer_id = invoice.customer_id 
	join track on   track.track_id = invoice_line.track_id
	join genre on genre.genre_id = track.genre_id 
	
	group by 2,3,4             -- 2 → customer.country  3 → genre.name  4 → genre.genre_id
    order by 2 asc, 1 desc
)

select * from popular_genres where RowNo  <= 1;



--  question 10  --- >    

-- write a query that determines the customer that has spent the most on music for each country.
-- wrtite a query that returns the country along with the top customer and how much they spent.
-- for each country where the top amount spent is shared, provide all customers who spent this amount


with recursive 
    customer_with_country as
	(
         select customer.customer_id, first_name, last_name, billing_country, sum(total)
		 as total_spending from invoice

		 join customer on customer.customer_id =  invoice.customer_id 
		 group by 1,2,3,4
		 order by 2,3 desc 
		 -- limit 5
	),

	country_max_spending as 
	(
       select billing_country, max(total_spending) as max_spending 
	   from customer_with_country 
	   group by billing_country
	)

	select cc.billing_country, cc.total_spending, cc.first_name, cc.last_name 
	from customer_with_country cc

	join country_max_spending  ms 
	on ms.billing_country = cc.billing_country
	where cc.total_spending = ms.max_spending 
	order by 1; -- it won't repeat the country name 
	

	-- OR 
	-- WE CAN USE AN EASY METHOD 

with customer_with_country as 
(
   select customer.customer_id, first_name, last_name, billing_country, sum(total)
   as total_spending, 
   row_number() over(partition by billing_country order by sum(total) desc )
   
   as RowNo	 from invoice 

   join customer on customer.customer_id = invoice.customer_id 
   group by 1,2,3,4 
   order by 4 asc, 5 desc  -- total_spending = descending order & billing_country = ascending order
   
)

select * from customer_with_country where RowNo <=1;









	

	













	



 





	



 



