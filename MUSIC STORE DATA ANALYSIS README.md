🎵 Music Store Data Analysis (SQL Project)
📘 Overview

This project analyzes a music store database using SQL.
It explores business questions such as:

Who are the best customers?

Which countries and cities bring in the most revenue?

What genres and artists are most popular?

Which customers spend the most money per country?

The queries range from beginner to advanced, using concepts like:

Aggregations (SUM, COUNT, AVG)

Joins

Subqueries

Common Table Expressions (CTEs)

Window functions (ROW_NUMBER())



🗂️ Dataset

The project is based on the Chinook Music Store Database, which contains tables such as:

employee

customer

invoice and invoice_line

track, album, artist

genre

Each table stores information about customers, their purchases, artists, albums, and sales data.


🧮 Query Sections
🟢 Beginner Level (Questions 1–5)

Basic aggregation and filtering:

Find the senior-most employee.

Find countries with the most invoices.

Get the top 3 highest invoice totals.

Find which city generates the most revenue.

Identify the customer who spent the most.

🟡 Intermediate Level (Questions 6–8)

Moderate analytical queries:
6. Find tracks longer than the average song length.
7. (Repeated structure)
8. Determine how much each customer spent on the top artists.

🔴 Advanced Level (Questions 9–10)

Complex analytical tasks using CTEs and window functions:
9. Identify the most popular music genre per country.
10. Find the top-spending customer(s) per country — includes two methods:

Using CTEs with MAX()

Using ROW_NUMBER() for ranking

🧰 SQL Concepts Used

JOIN (inner joins across multiple tables)

GROUP BY and ORDER BY

WHERE and HAVING

LIMIT

CTE (WITH clause)

ROW_NUMBER() and ranking

Subqueries

Aggregate functions (SUM, COUNT, MAX, AVG)
