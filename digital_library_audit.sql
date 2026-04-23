--  Digital Library Audit 
-- Table Creation
create Table Books(
Book_Id Serial Primary Key,
Author_name varchar(50) Not Null,
Book_name varchar(100) Not Null,
category varchar(50) Not Null,
Total_copies int Default 1 check (total_copies > 0),
Available_copies int 
);

create Table Students(
	student_id serial primary key,
	student_name varchar(60),
	email_id varchar(50) unique ,
	joined_date date not null default current_date
);

create table IssuedBooks(
	issued_id serial Primary Key,
	book_id int references Books(Book_Id),
	student_id int references Students(student_id),
	issueDate date not null default current_date,
	returnDate date 
	);
-- Insert data into tables
	
INSERT INTO Students (student_name, email_id, joined_date) VALUES
('Riya Kumari', 'riya@gmail.com', '2023-01-10'),
('Kaushik Verma', 'kaushik@gmail.com', '2023-02-15'),
('Priya Jain', 'priya@gmail.com', '2023-03-20'),
('Rahul Baranwal', 'rahul@gmail.com', '2023-04-05'),
('Sneha Singh', 'sneha@gmail.com', '2023-05-12'),
('Arjun Kumar', 'arjun@gmail.com', '2023-06-18'),
('Meera Goyal', 'meera@gmail.com', '2023-07-22'),
('Karan Goyal', 'karan@gmail.com', '2023-08-30'),
('Krati Gupta', 'krati@gmail.com', '2023-09-14'),
('Vikas Kumar', 'vikas@gmail.com', '2023-10-01'),
('Pooja Kumari', 'pooja@gmail.com', '2023-11-05'),
('Richa Kumari', 'richa@gmail.com', '2023-12-10'),
('Ikra Bee', 'ikra@gmail.com', '2024-01-15'),
('Palak Baranwal', 'deepak@gmail.com', '2024-02-20'),
('Kriti Tiwari', 'kriti@gmail.com', '2024-03-10');

INSERT INTO Books (Author_name, Book_name, category, Total_copies, Available_copies) VALUES
('Paulo Coelho', 'The Alchemist', 'Fiction', 5, 3),
('James Clear', 'Atomic Habits', 'Self-help', 6, 4),
('Dan Brown', 'Da Vinci Code', 'Thriller', 4, 2),
('J.K. Rowling', 'Harry Potter', 'Fantasy', 10, 7),
('Yuval Noah Harari', 'Sapiens', 'History', 5, 2),
('Chetan Bhagat', '2 States', 'Romance', 6, 3),
('Robert Kiyosaki', 'Rich Dad Poor Dad', 'Finance', 7, 5),
('Stephen Hawking', 'Brief History of Time', 'Science', 4, 2),
('APJ Abdul Kalam', 'Wings of Fire', 'Biography', 6, 3),
('George Orwell', '1984', 'Fiction', 5, 1),
('R.K. Narayan', 'Malgudi Days', 'Fiction', 4, 2),
('Dale Carnegie', 'How to Win Friends', 'Self-help', 5, 3),
('Napoleon Hill', 'Think and Grow Rich', 'Finance', 6, 4),
('H.G. Wells', 'Time Machine', 'Science Fiction', 3, 1),
('Leo Tolstoy', 'War and Peace', 'History', 2, 1);

INSERT INTO IssuedBooks (book_id, student_id, issueDate, returnDate) VALUES
(1, 1, '2024-01-01', '2024-01-10'),
(2, 2, '2024-01-05', NULL),
(3, 3, '2024-01-10', '2024-01-18'),
(4, 4, '2024-01-15', NULL),
(5, 5, '2024-02-01', '2024-02-10'),
(6, 6, '2024-02-05', NULL),
(7, 7, '2024-02-10', '2024-02-20'),
(8, 8, '2024-02-15', NULL),
(9, 9, '2024-03-01', '2024-03-08'),
(10, 10, '2024-03-05', NULL),
(11, 11, '2024-03-10', '2024-03-18'),
(12, 12, '2024-03-15', NULL),
(13, 13, '2024-03-20', '2024-03-28'),
(14, 14, '2024-03-25', NULL),
(15, 15, '2024-03-30', NULL);

-- Overdue Logic

select s.student_id , s.student_name , b.book_name , i.issueDate
from Students s
join IssuedBooks i on s.student_id = i.student_id
join Books b on b.book_id = i.book_id
where i.returnDate is null
and  CURRENT_DATE-i.issueDate > 14 ;

-- Popularity Index

select b.category , count(*) as total_borrows
from IssuedBooks i join Books b
on i.book_id = b.book_id 
group by b.category
order by total_borrows desc;

-- Data Cleanup

Delete from Students
where student_id not in (
    select distinct student_id
    from IssuedBooks
    where issueDate >= current_date - interval '3 years'
);
