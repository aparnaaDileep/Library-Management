CREATE DATABASE Library;
USE Library;
CREATE TABLE Branch(Branch_no INT PRIMARY KEY ,
Manager_Id VARCHAR(10) ,
Branch_address VARCHAR(80),  
Contact_no varchar(11) );

CREATE TABLE Employee(Emp_Id INT PRIMARY KEY  ,
Emp_name  VARCHAR(25),
Position  VARCHAR(20),
Salary INT,
Branch_no INT,
FOREIGN KEY(Branch_no) REFERENCES Branch(Branch_no) );

CREATE TABLE Books (ISBN INT PRIMARY KEY ,
Book_title  VARCHAR(70),
Category  VARCHAR(25),
Rental_Price  INT,
Status_Of_Book VARCHAR(1) , 
Author  VARCHAR(20),
Publisher VARCHAR(20));

CREATE TABLE Customer (Customer_Id INT PRIMARY KEY,  
Customer_name  VARCHAR(25),
Customer_address  VARCHAR(70),
Reg_date DATE);

CREATE TABLE Issue_Status(Issue_Id INT PRIMARY KEY  ,
Issued_cust_id INT, 
FOREIGN KEY (Issued_cust_id) references Customer( Customer_Id),
Issued_book_name VARCHAR(70),
Issue_date DATE,
Isbn_book INT ,FOREIGN KEY (Isbn_book) REFERENCES Books(ISBN));

CREATE TABLE Return_status(Return_Id INT PRIMARY KEY,  
Return_cust  VARCHAR(20),
Return_book_name  VARCHAR(70),
Return_date  DATE,
Isbn_book2 INT,FOREIGN KEY (Isbn_book2) REFERENCES Books(ISBN));

INSERT INTO Branch (Branch_no, Manager_Id ,Branch_address ,Contact_no ) VALUES (21,211,"Cochin",9745263251),
(87,876,"Thrissur",7462589314),
(54,542,"Kozhikode",874512687),
(32,325,"Trivandrum",7455862214),
(46,469,"Kottayam",9124758369);
SELECT * FROM bOOKS;
INSERT INTO Employee(Emp_Id ,Emp_name, Position , Salary,Branch_no) values 
(101,"Arjun","Library clerk",501233,21),
(104,"Shradha","Library Assistant",45100,21),
(103,"Karthik","Library technician",64122,21),
(110,"Deepak","Library clerk",49871,46),
(325,"Silpa","Librarian",50122,32),
(501,"Zalima","Library technician",48122,21),
(745,"Sreya","Library clerk",60213,21),
(211,"Abhishek","Librarian",45123,21),
(469,"Karthika","Librarian",51000,46),
(542,"Sreyas","Librarian",32444,54),
(876,"Anagha"," Librarian",47000,87);

INSERT INTO Books(ISBN,Book_title,Category,Rental_Price,Status_Of_Book,Author,Publisher) VALUES
(98445561,"A Good Girl's guide to murder","Thriller",10,"Y","Holly Jackson","Electric Monkey"),
(97744123,"Good Blood Bad Blood","Thriller",12,"N","Holly Jackson","Electric Monkey"),
(97455212,"As Good as Dead","Thriller",11,"Y","Holly Jackson","Electric Monkey"),
(92236145,"Cheat Sheet","Rom-Com",20,"Y","Sarah Adams","Headline Eternal"),
(97411253,"The Mother I Never Knew","Drama",26,"Y","Sudha Murthy","Penguin");

INSERT INTO Customer(Customer_Id,Customer_name ,Customer_address,Reg_date) VALUES
(532,"Rahul","East Road,Thrissur","2019-08-30"),
(766,"Sneha","West fort,Thrissur","2021-07-20"),
(578,"Kamal","Muvattupuzha,Cochin","2023-01-05"),
(801,"Lekha","Malampuram,Kozhikode","2020-06-09"),
(784,"Soniya","Gandhi nagar,Trivandrum","2024-09-01");

SELECT * FROM CUSTOMER;

INSERT INTO Issue_Status(Issue_Id, Issued_cust_id, Issued_book_name, Issue_date , Isbn_book ) values
(8725,766,"Cheat Sheet","2024-08-30",92236145),
(3210,784,"A Good Girl's guide to murder","2024-09-18",98445561),
(8745,532,"As Good as Dead","2022-02-25",97455212),
(2110,578,"The Mother I Never Knew","2023-06-09",97411253);
SELECT * FROM Issue_Status;

INSERT INTO return_status(Return_Id,Return_cust,Return_book_name,Return_date,Isbn_book2) VALUES
(1254,"Sneha","Cheat Sheet","2024-09-15",92236145),
(5744,"Rahul","As Good as Dead","2022-05-21",97455212);
SELECT * FROM return_status;

-- 1. Retrieve the book title, category, and rental price of all available books. 
SELECT Book_title,Category,Rental_Price FROM Books WHERE Status_Of_Book='Y'; 

-- 2. List the employee names and their respective salaries in descending order of salary. 
SELECT Emp_name,Salary FROM employee ORDER BY SALARY DESC;

-- 3. Retrieve the book titles and the corresponding customers who have issued those books
SELECT books.book_title,customer.Customer_name FROM Books right JOIN  Issue_Status on Books.ISBN=Issue_Status.ISBN_Book left join 
Customer on customer.customer_id=Issue_Status.Issued_cust_id;

-- 4. Display the total count of books in each category. 
SELECT Category,COUNT(Category) AS Total_count FROM Books GROUP BY CATEGORY;

-- 5. Retrieve the employee names and their positions for the employees whose salaries are above Rs.50,000. 
SELECT Emp_name,Position FROM employee WHERE SALARY>50000;

-- 6. List the customer names who registered before 2022-01-01 and have not issued any books yet. 
SELECT customer.customer_name from Customer left join Issue_status on customer.customer_id=Issue_status.Issued_cust_id where
Reg_date<'2022-01-01' AND Issue_status.Issued_cust_id is null ;

-- 7.Display the branch numbers and the total count of employees in each branch
SELECT Branch.Branch_no,COUNT(Employee.emp_id)  as Count_of_Employees,branch.branch_address FROM BRANCH RIGHT JOIN 
employee ON branch.branch_no=employee.branch_no
group by branch_no;

-- 8.Display the names of customers who have issued books in the month of June 2023.
SELECT CUSTOMER.customer_name  From customer right join issue_status on customer.customer_id=issue_status.Issued_cust_id
where issue_date >'2023-06-01' and issue_date < '2023-06-30'; 

-- 9. Retrieve book_title from book table containing history. 
SELECT Book_title FROM Books where Book_title LIKE '%history%';

-- 10.Retrieve the branch numbers along with the count of employees for branches having more than 5 employees
select count(Emp_Id) as Count_of_Employee ,branch_no from employee group by Branch_no having count(Emp_Id)>5;

-- 11. Retrieve the names of employees who manage branches and their respective branch addresses.
SELECT Emp_name,branch.Branch_address FROM employee right join branch on branch.Manager_Id=employee.Emp_Id;

-- 12.  Display the names of customers who have issued books with a rental price higher than Rs. 25.
SELECT Customer_name from customer right join issue_status on customer.Customer_Id=issue_status.Issued_cust_id left join 
books on books.ISBN=issue_status.Isbn_book where books.Rental_Price>25;
