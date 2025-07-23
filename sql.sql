-- 1) Retrive all books in the "fiction" in Genre:

select * from books where genre="fiction";

-- 2) Find books published  after the year 1950:

select * from books where published_year >1950;

-- 3) Find all customers from the "Canana":

select * from customers where country="canada";

-- 4) Show order placed in November 2023:

select * from orders Where order_date between '2023-07-07' and '2024-08-31';

-- 5) Retrive the total stock of books available:

select sum(stock) as total from books;

-- 6) Find the Details of the most expensive books:

select title,price from books order by price desc limit 1;

-- 7) Show all customers who ordered more than 1:

select * from orders where quantity >1;

-- 8) Retrive all records where the total amount greater than 20:

select * from orders where total_amount >20;

-- 9) List all Genere available in the books table:

select distinct genre from books;

-- 10) Find the book with the lowest stock:

select genre,stock from books order by stock asc;

-- 11) Calculate the total revenue from orders :

select sum(total_amount) as revenue from orders;

-- 12) Retrive the total numbers of books sold for each Genre:

select books.genre,sum(orders.quantity) as total from books 
join orders  on orders.order_id=books.book_id group by books.genre ;

-- 13) Find the average price of books in the Fantasy Genre:

select avg(price) from books where genre="fantasy";

-- 14) List customers who ordered at least 2:

select c.name,o.customer_id,sum(o.order_id) as total  from orders o
join customers c
on o.order_id=c.customer_id
group by c.name,customer_id
having sum(o.order_id)>=2;

-- 15) Find the most frequently ordered book:

select book_id,count(order_id) as total from orders
group by book_id
order by count(order_id) desc;

-- 16) Show the top 3 most expensive books in Fantasy Genre:

select * from books where genre="fantasy" order by price desc limit 3;

-- 17) Retrive the total quantity of book sold by each author:

select author, sum(stock) from books group by author; 

select b.author,sum(o.quantity) as total from  books b
join orders o on o.order_id=b.book_id group by b.author;

-- 18) List the cities where customers who spent more thean 300:

select  distinct c.city,o.total_amount
from customers c
join orders o
on o.order_id=c.customer_id
where o.total_amount >300;

-- 19) Find the top 5 price of books:

select c.customer_id,c.name,sum(o.total_amount) as total from customers c
join orders o
on o.order_id=c.customer_id
group by c.customer_id,c.name
order by sum(o.total_amount) desc limit 5;

-- 20)Calculate the stock remaining after fulfilling all orders 

select  b.book_id,b.title,b.stock,coalesce(sum(o.quantity),0) as order_quantity,
b.stock-coalesce(sum(o.quantity),0) as Remaining_stock
from books b
left join orders o on b.book_id=o.order_id
group by b.book_id,b.title,b.stock
order by coalesce(sum(o.quantity),0) desc;

