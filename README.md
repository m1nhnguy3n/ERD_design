# Book Selling Database

[<img alt="Book Selling" src="https://cdn.discordapp.com/attachments/1276085847015292938/1276101238961737788/image.png?ex=66c8f624&is=66c7a4a4&hm=39f3865cee5c12e6a73194aad018dbdcd5eefc6811e137cd948ec7c267fea43b&" >](https://cdn.discordapp.com/attachments/1276085847015292938/1276101238961737788/image.png?ex=66c8f624&is=66c7a4a4&hm=39f3865cee5c12e6a73194aad018dbdcd5eefc6811e137cd948ec7c267fea43b&)

# Database Exercise
  
## 1. List all books along with their authors and publishers, and sort the list by book price in descending order.

```SQL
select
  title,
  publisher_name,
  author_name,
  price
from books
  join publishers on books.publisher_id = publishers.id
  join author_books on books.id = author_books.book_id
  join authors on author_books.author_id = authors.id
order by price desc
```
## 2. Find the renter who has the highest total number of contracts and list the details of their contracts (including the boarding house and lessor information).

```sql
SELECT
  users.first_name,
  users.last_name,
  orders.total_amount,
  shipping_address.address
FROM users
  JOIN orders ON orders.user_id = users.id
  JOIN order_items ON orders.id = order_items.order_id
  JOIN shipping_address ON orders.shipping_address_id = shipping_address.id
WHERE orders.total_amount = (
    SELECT MAX(total_amount)
    FROM orders
  )
GROUP BY
  users.id,
  orders.total_amount,
  shipping_address.address;
```

## 3. List boarding houses that are fully booked (capacity is at max) along with their categories and the total number of comments. Only show boarding houses with 5 or more comments.

```sql
select
  books.title,
  books.quantity_in_stock,
  categories.category_name,
  count(reviews.id) as count_reviews
from books
  join categories on categories.id = books.category_id
  join reviews on reviews.book_id = books.id
where books.quantity_in_stock = 0
group by
  books.id,
  categories.category_name
having count(reviews.id) >= 5;
```
## 4. Query the list of authors and the number of books they have written, sorted by the number of books in descending order, showing only authors with more than 3 books.
Method 1: 
```sql
SELECT
  authors.author_name,
  COUNT ( author_books.book_id ) AS book_counts 
FROM
  authors
  JOIN author_books ON author_books.author_id = authors."id" 
GROUP BY
  authors."id" 
HAVING COUNT ( author_books.book_id ) > 3 
ORDER BY
  book_counts DESC
```
Method 2: 
``` sql
WITH author_book_counts AS (
  SELECT
    author_books.author_id,
    COUNT ( author_books.book_id ) AS book_counts 
  FROM
    author_books 
  GROUP BY
    author_books.author_id 
  HAVING
    COUNT ( author_books.book_id ) > 3 
) SELECT
authors.author_name,
author_book_counts.book_counts 
FROM
  authors
  JOIN author_book_counts ON authors.ID = author_book_counts.author_id 
ORDER BY
  author_book_counts.book_counts DESC;
```
## 5. List all orders from the most recent month, along with the user's name, the total amount for each order, and the names of the books in each order. Sort the results by order date.
```sql 
SELECT 
    users.first_name, 
    users.last_name, 
    orders.total_amount,
    books.title as book_name,
    orders.order_date
FROM 
    orders
JOIN 
    users ON users.id = orders.user_id
JOIN 
    order_items ON order_items.order_id = orders.id
JOIN 
    books ON books.id = order_items.book_id
WHERE 
    orders.order_date >= DATE_TRUNC('month', CURRENT_DATE)
ORDER BY 
    orders.order_date DESC;
```
## 6. Find books priced higher than the average price of all books within their category. List the book titles, prices, and category names.
```sql 
SELECT 
    books.title, 
    books.price, 
    categories.category_name
FROM 
    books
JOIN 
    categories ON categories.id = books.category_id
JOIN 
    (SELECT 
         category_id, 
         AVG(price) AS avg_price
     FROM 
         books
     GROUP BY 
         category_id
    ) AS avg_prices ON avg_prices.category_id = books.category_id
WHERE 
    books.price > avg_prices.avg_price;
```

## 7. List all publishers and the number of books they have published. Show only publishers who have published more than 10 books and sort by the number of books in descending order.

```sql
select publisher_name, count(books."id") as book_counts
from publishers
join books on books.publisher_id = publishers."id"
GROUP BY publishers.publisher_name
order by book_counts desc
```
## 8. List users who have placed at least 2 orders with a total spending of $1,000 or more. Display their email, total amount spent, and the number of orders. (My data don't have total_amount field equal or more $1,000. I changed from $1,000 to $900)

```sql
WITH order_by_user AS (
  SELECT
    user_id,
    SUM ( total_amount ) AS total_amount_spent,
    COUNT ( orders."id" ) AS order_count 
  FROM
    orders 
  WHERE
    total_amount > 900 
  GROUP BY
    user_id 
  HAVING
    COUNT ( orders."id" ) > 2 
) SELECT
email,
order_by_user.total_amount_spent,
order_by_user.order_count 
FROM
  users
  JOIN order_by_user ON order_by_user.user_id = users."id"
```

## 9. List all user reviews, along with the book titles, ratings, and comments. Only show books with an average rating above 4, and sort the results by the average rating in descending order.
```sql
WITH book_reviews AS ( SELECT book_id, rating, COMMENT FROM reviews GROUP BY reviews.book_id, rating, COMMENT ORDER BY AVG ( rating ) DESC ) SELECT
title,
book_reviews.rating,
book_reviews.COMMENT 
FROM
  books
  JOIN book_reviews ON book_reviews.book_id = books."id"
```
## 10. Find users who have never written a review for any book, along with their detailed shipping address information.
Method 1:
```sql
WITH user_review AS (
    SELECT DISTINCT user_id 
    FROM reviews
)
SELECT 
    users.first_name, 
    users.last_name,
    shipping_address.address
FROM 
    users
    join shipping_address on shipping_address.user_id = users."id"
LEFT JOIN 
    user_review ON user_review.user_id = users.id
WHERE 
    user_review.user_id IS NULL;
```
Method 2: 
```sql
SELECT
    users."id",
    users.first_name, 
    users.last_name,
    shipping_address.address
FROM 
    users
join shipping_address on shipping_address.user_id = users."id"
WHERE 
    NOT EXISTS (
        SELECT 1 
        FROM reviews 
        WHERE reviews.user_id = users.id
    );
```
## 11. List all delivered orders (status = 'delivered'), along with book information, user details, and the total amount for the order. Sort by the total amount in descending order.
```sql
SELECT
  first_name,
  last_name,
  total_amount,
  status,
  title 
FROM
  orders
  JOIN order_items ON order_items.order_id = orders."id"
  JOIN users ON users."id" = orders.user_id
  JOIN books ON order_items.book_id = books."id" 
WHERE
  status = 'delivered'
```
## 12. Query the list of books along with their authors and the total number of reviews they have received. Only show books with 3 or more reviews and sort by the number of reviews in descending order.
```sql
SELECT
  books.title,
  authors.author_name,
  COUNT ( reviews."id" ) AS review_counts 
FROM
  books
  JOIN author_books ON author_books.book_id = books."id"
  JOIN authors ON authors."id" = author_books.author_id
  JOIN reviews ON reviews.book_id = books."id" 
GROUP BY
    books.title,
    authors.author_name
ORDER BY
    review_counts DESC; 
```
## 13. List user names and the total amount they have spent on orders shipped to a specific city, sorted by total spending in descending order.
```sql
SELECT
  first_name,
  last_name,
  total_amount,
  address 
FROM
  users
  JOIN orders ON orders.user_id = users."id"
  JOIN shipping_address ON shipping_address.user_id = users."id" 
ORDER BY
  total_amount DESC
```
## 14. Find books with an inventory value higher than the average inventory value of all books. List the book titles, inventory value, and publisher names.
```sql
WITH avg_quantity AS (
    SELECT AVG(quantity_in_stock) AS avg_qty
    FROM books
)
SELECT 
    books.title, 
    books.quantity_in_stock, 
    publishers.publisher_name
FROM 
    books
JOIN 
    publishers ON books.publisher_id = publishers.id
WHERE 
    books.quantity_in_stock > (SELECT avg_qty FROM avg_quantity);

```
## 15. List all books and their publishers, along with the authors who wrote those books. Only display books with at least 2 authors and sort by book title.
```sql
SELECT 
    books.title AS book_title, 
    publishers.publisher_name, 
    authors.author_name
FROM 
    books
JOIN 
    publishers ON books.publisher_id = publishers.id
JOIN 
    author_books ON books.id = author_books.book_id
JOIN 
    authors ON author_books.author_id = authors.id
WHERE 
    books.id IN (
        SELECT 
            book_id
        FROM 
            author_books
        GROUP BY 
            book_id
        HAVING 
            COUNT(author_id) >= 2
    )
ORDER BY 
    books.title, 
    authors.author_name;

```
