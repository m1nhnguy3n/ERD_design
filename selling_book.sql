CREATE TABLE "shipping_address"(
    "id" BIGINT NOT NULL,
    "user_id" BIGINT NOT NULL,
    "address" TEXT NOT NULL,
    "created_at" DATE NOT NULL,
    "updated_at" DATE NULL
);
ALTER TABLE
    "shipping_address" ADD PRIMARY KEY("id");
CREATE TABLE "publishers"(
    "id" BIGINT NOT NULL,
    "publisher_name" VARCHAR(255) NOT NULL,
    "address" TEXT NOT NULL,
    "contact_info" TEXT NOT NULL,
    "created_at" DATE NOT NULL,
    "updated_at" DATE NULL
);
ALTER TABLE
    "publishers" ADD PRIMARY KEY("id");
CREATE TABLE "author_books"(
    "author_id" BIGINT NOT NULL,
    "book_id" BIGINT NOT NULL
);
CREATE TABLE "books"(
    "id" BIGINT NOT NULL,
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
    "books" ADD PRIMARY KEY("id");
CREATE TABLE "reviews"(
    "id" BIGINT NOT NULL,
    "user_id" BIGINT NOT NULL,
    "book_id" BIGINT NOT NULL,
    "rating" INTEGER NOT NULL,
    "comment" TEXT NULL,
    "created_at" DATE NOT NULL,
    "update_at" DATE NOT NULL
);
ALTER TABLE
    "reviews" ADD PRIMARY KEY("id");
CREATE TABLE "roles"(
    "id" BIGINT NOT NULL,
    "role_name" VARCHAR(255) NOT NULL,
    "created_at" DATE NOT NULL,
    "updated_at" DATE NULL
);
ALTER TABLE
    "roles" ADD PRIMARY KEY("id");
CREATE TABLE "authors"(
    "id" BIGINT NOT NULL,
    "author_name" VARCHAR(255) NOT NULL,
    "biography" TEXT NOT NULL,
    "image_url" TEXT NOT NULL,
    "created_at" DATE NOT NULL,
    "updated_at" DATE NULL
);
ALTER TABLE
    "authors" ADD PRIMARY KEY("id");
CREATE TABLE "order_items"(
    "id" BIGINT NOT NULL,
    "order_id" BIGINT NOT NULL,
    "book_id" BIGINT NOT NULL,
    "price" DECIMAL(8, 2) NOT NULL,
    "created_at" DATE NOT NULL,
    "updated_at" DATE NULL
);
ALTER TABLE
    "order_items" ADD PRIMARY KEY("id");
CREATE TABLE "user_roles"(
    "user_id" BIGINT NOT NULL,
    "role_id" BIGINT NOT NULL
);
ALTER TABLE
    "user_roles" ADD PRIMARY KEY("user_id");
CREATE TABLE "orders"(
    "id" BIGINT NOT NULL,
    "user_id" BIGINT NOT NULL,
    "order_date" DATE NOT NULL,
    "shipping_address_id" BIGINT NOT NULL,
    "status" VARCHAR(255) NOT NULL,
    "total_amount" DECIMAL(8, 2) NOT NULL,
    "created_at" BIGINT NOT NULL,
    "updated_at" BIGINT NULL
);
ALTER TABLE
    "orders" ADD PRIMARY KEY("id");
CREATE TABLE "categories"(
    "id" BIGINT NOT NULL,
    "category_name" VARCHAR(255) NOT NULL,
    "created_at" DATE NOT NULL,
    "updated_at" DATE NULL
);
ALTER TABLE
    "categories" ADD PRIMARY KEY("id");
CREATE TABLE "users"(
    "id" BIGINT NOT NULL,
    "email" VARCHAR(255) NOT NULL,
    "password" VARCHAR(255) NOT NULL,
    "first_name" VARCHAR(255) NOT NULL,
    "last_name" VARCHAR(255) NOT NULL,
    "phone_number" VARCHAR(255) NOT NULL,
    "created_at" DATE NOT NULL,
    "updated_at" DATE NULL
);
ALTER TABLE
    "users" ADD PRIMARY KEY("id");
ALTER TABLE
    "shipping_address" ADD CONSTRAINT "shipping_address_user_id_foreign" FOREIGN KEY("user_id") REFERENCES "users"("id");
ALTER TABLE
    "books" ADD CONSTRAINT "books_category_id_foreign" FOREIGN KEY("category_id") REFERENCES "categories"("id");
ALTER TABLE
    "reviews" ADD CONSTRAINT "reviews_user_id_foreign" FOREIGN KEY("user_id") REFERENCES "users"("id");
ALTER TABLE
    "books" ADD CONSTRAINT "books_publisher_id_foreign" FOREIGN KEY("publisher_id") REFERENCES "publishers"("id");
ALTER TABLE
    "author_books" ADD CONSTRAINT "author_books_author_id_foreign" FOREIGN KEY("author_id") REFERENCES "authors"("id");
ALTER TABLE
    "orders" ADD CONSTRAINT "orders_shipping_address_id_foreign" FOREIGN KEY("shipping_address_id") REFERENCES "shipping_address"("id");
ALTER TABLE
    "user_roles" ADD CONSTRAINT "user_roles_role_id_foreign" FOREIGN KEY("role_id") REFERENCES "roles"("id");
ALTER TABLE
    "orders" ADD CONSTRAINT "orders_user_id_foreign" FOREIGN KEY("user_id") REFERENCES "users"("id");
ALTER TABLE
    "author_books" ADD CONSTRAINT "author_books_book_id_foreign" FOREIGN KEY("book_id") REFERENCES "books"("id");
ALTER TABLE
    "order_items" ADD CONSTRAINT "order_items_book_id_foreign" FOREIGN KEY("book_id") REFERENCES "books"("id");
ALTER TABLE
    "users" ADD CONSTRAINT "users_id_foreign" FOREIGN KEY("id") REFERENCES "user_roles"("user_id");
ALTER TABLE
    "reviews" ADD CONSTRAINT "reviews_book_id_foreign" FOREIGN KEY("book_id") REFERENCES "books"("id");
ALTER TABLE
    "order_items" ADD CONSTRAINT "order_items_order_id_foreign" FOREIGN KEY("order_id") REFERENCES "orders"("id");