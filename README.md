# Digital Library Audit (SQL)

A simple **PostgreSQL** database script for a digital library system. It creates the main tables (**Books**, **Students**, **IssuedBooks**), inserts sample data, and includes useful audit queries.

---

## Features

- Creates tables for:
  - `Books`
  - `Students`
  - `IssuedBooks`
- Inserts sample records for quick testing
- Provides queries for:
  - **Overdue books**
  - **Category popularity**
  - **Data cleanup**

---

## Database Schema

### `Books`
- `Book_Id` (Primary Key)
- `Author_name`
- `Book_name`
- `category`
- `Total_copies`
- `Available_copies`

### `Students`
- `student_id` (Primary Key)
- `student_name`
- `email_id` (Unique)
- `joined_date`

### `IssuedBooks`
- `issued_id` (Primary Key)
- `book_id` (References `Books`)
- `student_id` (References `Students`)
- `issueDate`
- `returnDate`

---

## Setup & Run

### Prerequisites
- PostgreSQL installed
- A PostgreSQL database created (example: `digital_library`)

### Run
1. Clone the repo:
   ```bash
   git clone https://github.com/riyabaranwal/Digital-Library.git
   cd Digital-Library
   ```

2. Execute the SQL file:
   ```bash
   psql -d <your_database_name> -f digital_library_audit.sql
   ```

Example:
```bash
psql -d digital_library -f digital_library_audit.sql
```

---

## Included Queries

### 1) Overdue Books
Finds students who have not returned books and the book is overdue (more than 14 days).

### 2) Popularity Index
Shows which book categories are borrowed the most.

### 3) Data Cleanup
Deletes students who have not issued any book in the last 3 years.

---

## Conclusion

This project demonstrates a basic digital library database in PostgreSQL with sample data and practical audit queries. It can be used to understand how books are issued/returned and how to generate simple reports like overdue lists and category-wise borrowing trends.

---

## Project Files

- `digital_library_audit.sql` — tables + sample data + queries