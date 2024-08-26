# Book Selling Database

[<img alt="Book Selling" src="https://cdn.discordapp.com/attachments/1276085847015292938/1276101238961737788/image.png?ex=66c8f624&is=66c7a4a4&hm=39f3865cee5c12e6a73194aad018dbdcd5eefc6811e137cd948ec7c267fea43b&" >](https://cdn.discordapp.com/attachments/1276085847015292938/1276101238961737788/image.png?ex=66c8f624&is=66c7a4a4&hm=39f3865cee5c12e6a73194aad018dbdcd5eefc6811e137cd948ec7c267fea43b&)

# Database Exercise

  
1. List all boarding houses along with their owners (lessors) and their verification status. Sort the boarding houses by price in descending order.

select title, publisher_name, author_name, price 
from books 
join publishers on books.publisher_id = publishers.id
join author_books on books.id = author_books.book_id 
join authors on author_books.author_id = authors.id
order by price desc

2. Find the renter who has the highest total number of contracts and list the details of their contracts (including the boarding house and lessor information).

SELECT 
    users.first_name, 
    users.last_name, 
    orders.total_amount,
	shipping_address.address
FROM 
    users
JOIN 
    orders ON orders.user_id = users.id
JOIN 
    order_items ON orders.id = order_items.order_id
JOIN 
    shipping_address ON orders.shipping_address_id = shipping_address.id
WHERE 
    orders.total_amount = (
        SELECT MAX(total_amount) 
        FROM orders
    )
GROUP BY 
    users.id, orders.total_amount, shipping_address.address;

3. List boarding houses that are fully booked (capacity is at max) along with their categories and the total number of comments. Only show boarding houses with 5 or more comments.

select books.title, books.quantity_in_stock, categories.category_name, count(reviews.id) as count_reviews
from books
join categories on categories.id = books.category_id
join reviews on reviews.book_id = books.id
where books.quantity_in_stock = 0
group by books.id, categories.category_name
having count(reviews.id) >= 5;

