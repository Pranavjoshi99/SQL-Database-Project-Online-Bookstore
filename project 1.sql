CREATE TABLE Books (
    Book_ID SERIAL PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Published_Year INT,
    Price NUMERIC(10, 2),
    Stock INT
);
 select * from books;

 CREATE TABLE Customers (
    Customer_ID SERIAL PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Country VARCHAR(150)
);
select * from customers;

CREATE TABLE Orders (
    Order_ID SERIAL PRIMARY KEY,
    Customer_ID INT REFERENCES Customers(Customer_ID),
    Book_ID INT REFERENCES Books(Book_ID),
    Order_Date DATE,
    Quantity INT,
    Total_Amount NUMERIC(10, 2)
);

SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;

Copy books (Book_ID, Title, Author, Genre, Published_Year, Price, Stock)
from 'C:\Users\pranav joshi\OneDrive\Desktop\SQL\Project_1\Books1.csv'
csv header;	

Copy books (Book_ID, Title, Author, Genre, Published_Year, Price, Stock)
from 'C:\Users\pranav joshi\OneDrive\Desktop\SQL\Project_1\Customers.csv'
csv header;	

Copy books (Book_ID, Title, Author, Genre, Published_Year, Price, Stock)
from 'C:\Users\pranav joshi\OneDrive\Desktop\SQL\Project_1\Orders.csv'
csv header;	

-- 1) Retrieve all books in the "Fiction" genre:
select *
from books
where genre = 'Fiction';

-- 2) Find books published after the year 1950:
select * from books
where published_year > 1958;

-- 3) List all customers from the Canada:
select * from customers
where country = 'Canada';

-- 4) Show orders placed in November 2023:
select * from orders
where order_date between '2023-11-01' and '2023-11-30';

-- 5) Retrieve the total stock of books available:
select sum(stock) as Total_stock
from Books;

-- 6) Find the details of the most expensive book:
Select * from books
order by price desc
limit 1;

-- 7) Show all customers who ordered more than 1 quantity of a book:
select * from orders
where quantity > 1
order by quantity desc;

-- 8) Retrieve all orders where the total amount exceeds $20:
select * from orders
where total_amount > 20;

-- 9) List all genres available in the Books table:
select distinct genre from books;

-- 10) Find the book with the lowest stock:
select * from books
order by stock asc;

-- 11) Calculate the total revenue generated from all orders:
select sum(total_amount) as Revenue
from orders;

SELECT * FROM Books;
SELECT * FROM Customers;	
SELECT * FROM Orders;

-- 1) Retrieve the total number of books sold for each genre:

select b.genre, sum(o.quantity)
from orders o
join books b on o.book_id = b.book_id
group by b.genre;

-- 2) Find the average price of books in the "Fantasy" genre:
select avg(price) as Average_Price
from books
where genre ='Fantasy';

-- 3) List customers who have placed at least 2 orders:
select o.customer_ID, c.name, COUNT(o.Order_id) AS ORDER_COUNT
from orders o
join customers c on c.customer_ID = o.customer_ID
group by o.customer_ID, c.name
having count(order_id) >= 2;

-- 4) Find the most frequently ordered book:
select o.book_id, b.title, count(o.order_id) as order_count
from orders o
join books b on b.book_id = o.book_id
group by o.book_id, b.title
order by order_count desc;

-- 5) Show the top 3 most expensive books of 'Fantasy' Genre :
select price from books
where genre = 'Fiction'
order by price desc
limit 3;

-- 6) Retrieve the total quantity of books sold by each author:
select sum(o.quantity) as total_quantity, b.author
from orders o 
join books b on b.book_id = o.book_id
group by b.author;

SELECT b.author, SUM(o.quantity) AS Total_Books_Sold
FROM orders o
JOIN books b ON o.book_id=b.book_id
GROUP BY b.Author;

-- 7) List the cities where customers who spent over $30 are located:
select distinct c.city, o.total_amount 
from orders o
join customers c on c.customer_id = o.customer_id
where o.total_amount > 30;

-- 8) Find the customer who spent the most on orders:
select c.customer_id, c.name, sum(o.total_amount) as most_spent
from orders o 
join customers c on o.customer_id = c.customer_id
group by c.customer_id, c.name
order by most_spent desc;

--9) Calculate the stock remaining after fulfilling all orders:

SELECT b.book_id, b.title, b.stock, COALESCE(SUM(o.quantity),0) AS Order_quantity,  
	b.stock- COALESCE(SUM(o.quantity),0) AS Remaining_Quantity
FROM books b
LEFT JOIN orders o ON b.book_id=o.book_id
GROUP BY b.book_id ORDER BY b.book_id;

SELECT * FROM Books;
SELECT * FROM Customers;	
SELECT * FROM Orders;
--9) Calculate the stock remaining after fulfilling all orders:
select b.stock, b.book_id, b.title