CREATE TABLE "ShippingAddress"(
    "shipping_address_id" BIGINT NOT NULL,
    "user_id" BIGINT NOT NULL,
    "created_at" DATE NOT NULL,
    "updated_at" DATE NULL
);
ALTER TABLE
    "ShippingAddress" ADD PRIMARY KEY("shipping_address_id");
CREATE TABLE "Publishers"(
    "publisher_id" BIGINT NOT NULL,
    "publisher_name" VARCHAR(255) NOT NULL,
    "address" TEXT NOT NULL,
    "contact_info" TEXT NOT NULL,
    "created_at" DATE NOT NULL,
    "updated_at" DATE NULL
);
ALTER TABLE
    "Publishers" ADD PRIMARY KEY("publisher_id");
CREATE TABLE "Author_Book"(
    "author_id" BIGINT NOT NULL,
    "book_id" BIGINT NOT NULL
);
ALTER TABLE
    "Author_Book" ADD PRIMARY KEY("author_id");
CREATE TABLE "Books"(
    "book_id" BIGINT NOT NULL,
    "title" VARCHAR(255) NOT NULL,
    "description" TEXT NOT NULL,
    "isbn" VARCHAR(255) NOT NULL,
    "price" DECIMAL(8, 2) NOT NULL,
    "quantity_in_stock" INTEGER NOT NULL,
    "image_url" VARCHAR(255) NOT NULL,
    "publisher_id" BIGINT NOT NULL,
    "published_date" DATE NOT NULL,
    "category_id" BIGINT NOT NULL,
    "created_at" DATE NOT NULL,
    "updated_at" DATE NULL
);
ALTER TABLE
    "Books" ADD PRIMARY KEY("book_id");
CREATE TABLE "Review"(
    "review_id" BIGINT NOT NULL,
    "user_id" BIGINT NOT NULL,
    "book_id" BIGINT NOT NULL,
    "rating" INTEGER NOT NULL,
    "comment" TEXT NULL,
    "created_at" DATE NOT NULL,
    "update_at" DATE NOT NULL
);
ALTER TABLE
    "Review" ADD PRIMARY KEY("review_id");
CREATE TABLE "Roles"(
    "role_id" BIGINT NOT NULL,
    "role_name" VARCHAR(255) NOT NULL,
    "created_at" DATE NOT NULL,
    "updated-at" DATE NULL
);
ALTER TABLE
    "Roles" ADD PRIMARY KEY("role_id");
CREATE TABLE "Authors"(
    "author_id" BIGINT NOT NULL,
    "author_name" VARCHAR(255) NOT NULL,
    "biography" TEXT NOT NULL,
    "image_url" TEXT NOT NULL,
    "created_at" DATE NOT NULL,
    "updated_at" DATE NULL
);
ALTER TABLE
    "Authors" ADD PRIMARY KEY("author_id");
CREATE TABLE "OrderItem"(
    "order_item_id" BIGINT NOT NULL,
    "order_id" BIGINT NOT NULL,
    "book_id" BIGINT NOT NULL,
    "price" DECIMAL(8, 2) NOT NULL,
    "created_at" DATE NOT NULL,
    "updated_at" DATE NULL
);
ALTER TABLE
    "OrderItem" ADD PRIMARY KEY("order_item_id");
CREATE TABLE "User_Role"(
    "user_id" BIGINT NOT NULL,
    "role_id" BIGINT NOT NULL
);
ALTER TABLE
    "User_Role" ADD PRIMARY KEY("user_id");
CREATE TABLE "Order"(
    "order_id" BIGINT NOT NULL,
    "user_id" BIGINT NOT NULL,
    "order_date" DATE NOT NULL,
    "shipping_address_id" BIGINT NOT NULL,
    "status" VARCHAR(255) NOT NULL,
    "total_amount" DECIMAL(8, 2) NOT NULL,
    "created_at" BIGINT NOT NULL,
    "updated_at" BIGINT NULL
);
ALTER TABLE
    "Order" ADD PRIMARY KEY("order_id");
CREATE TABLE "Categories"(
    "category_id" BIGINT NOT NULL,
    "category_name" VARCHAR(255) NOT NULL,
    "created_at" DATE NOT NULL,
    "updated_at" DATE NULL
);
ALTER TABLE
    "Categories" ADD PRIMARY KEY("category_id");
CREATE TABLE "Users"(
    "user_id" BIGINT NOT NULL,
    "email" VARCHAR(255) NOT NULL,
    "password" VARCHAR(255) NOT NULL,
    "first_name" VARCHAR(255) NOT NULL,
    "last_name" VARCHAR(255) NOT NULL,
    "address" TEXT NOT NULL,
    "phone_number" VARCHAR(255) NOT NULL,
    "created_at" DATE NOT NULL,
    "updated_at" DATE NULL
);
ALTER TABLE
    "Users" ADD PRIMARY KEY("user_id");
ALTER TABLE
    "ShippingAddress" ADD CONSTRAINT "shippingaddress_user_id_foreign" FOREIGN KEY("user_id") REFERENCES "Users"("user_id");
ALTER TABLE
    "Books" ADD CONSTRAINT "books_category_id_foreign" FOREIGN KEY("category_id") REFERENCES "Categories"("category_id");
ALTER TABLE
    "Review" ADD CONSTRAINT "review_user_id_foreign" FOREIGN KEY("user_id") REFERENCES "Users"("user_id");
ALTER TABLE
    "Books" ADD CONSTRAINT "books_publisher_id_foreign" FOREIGN KEY("publisher_id") REFERENCES "Publishers"("publisher_id");
ALTER TABLE
    "Author_Book" ADD CONSTRAINT "author_book_author_id_foreign" FOREIGN KEY("author_id") REFERENCES "Authors"("author_id");
ALTER TABLE
    "Order" ADD CONSTRAINT "order_shipping_address_id_foreign" FOREIGN KEY("shipping_address_id") REFERENCES "ShippingAddress"("shipping_address_id");
ALTER TABLE
    "User_Role" ADD CONSTRAINT "user_role_role_id_foreign" FOREIGN KEY("role_id") REFERENCES "Roles"("role_id");
ALTER TABLE
    "Order" ADD CONSTRAINT "order_user_id_foreign" FOREIGN KEY("user_id") REFERENCES "Users"("user_id");
ALTER TABLE
    "Author_Book" ADD CONSTRAINT "author_book_book_id_foreign" FOREIGN KEY("book_id") REFERENCES "Books"("book_id");
ALTER TABLE
    "OrderItem" ADD CONSTRAINT "orderitem_book_id_foreign" FOREIGN KEY("book_id") REFERENCES "Books"("book_id");
ALTER TABLE
    "Users" ADD CONSTRAINT "users_user_id_foreign" FOREIGN KEY("user_id") REFERENCES "User_Role"("user_id");
ALTER TABLE
    "Review" ADD CONSTRAINT "review_book_id_foreign" FOREIGN KEY("book_id") REFERENCES "Books"("book_id");
ALTER TABLE
    "OrderItem" ADD CONSTRAINT "orderitem_order_id_foreign" FOREIGN KEY("order_id") REFERENCES "Order"("order_id");