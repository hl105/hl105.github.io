---

title: "DATABASES!!"
excerpt: "bye-bye flat files"
date: 2024-08-20
lastmod: 2024-08-20 16:17:22 -0400
last_modified_at: 2024-08-20 16:17:22 -0400
categories: project
tags: database sql sqlite sqlalchemy orm
classes:
toc: true
toc_label:
toc_sticky: true
header:
    image:
    teaser:
    overlay_image: ./assets/images/banners/default.png
sitemap:
    changefreq: daily
    priority: 1.0
author:
---

This post is a summary of the web pages listed in the Sources section. All credits to them!


# Data Management


<figure>
                      <img src="https://res.cloudinary.com/df2rp6zoo/image/upload/v1724186350/hqg9d2xckwt0cwhvcdnt.jpg" alt="">
                      <figcaption></figcaption>
                  </figure>


## Database normalization: 

- the process of breaking data apart to reduce redundancy and increasing integrity
- very important topic in database engineering
- when a database structure is extended with new types of data, having it normalized beforehand keeps changes to the existing structure to a minimum

## Relational databases

- provides a way to store structured data in tables and establish relationships between those blogs
- use SQL (Structured Query Language) to interact with the data

# SQLite

- does not require a separate database server to function
- works with a single file to maintain all databse functionality

**SQLite DataTypes**:

- **NULL: –** The value is a NULL value.
- **INTEGER**: – To store the numeric value. The integer stored in 1, 2, 3, 4, 6, or 8 bytes depending on the magnitude of the number.
- **REAL**: – The value is a floating-point value, for example, 3.14 value of PI
- **TEXT**: – The value is a text string, TEXT value stored using the UTF-8, UTF-16BE or UTF-16LE encoding.
- **BLOB**: – The value is a blob of data, i.e., binary data. It is used to store images and files.

**`connection.commit()`**: Always needed after `DELETE`, `INSERT`, or `UPDATE` to save changes


Why `?`


**SQL Injection:**  type of security vulnerability that occurs when an attacker can manipulate the SQL queries that an application sends to a database


example:


```python
cursor.execute(f"DELETE FROM finance_db WHERE id = {user_input};")

"""
If attacker provides user_input = "1 OR 1=1",
SQL Query becomes DELETE FROM finance_db WHERE id = 1 OR 1=1;
which deletes ALL ROWS!!!
"""
```


so we use **parameterized queries** instead: 

- user inputs are passed separately from the SQL command
- SQL interpreter treats user inputs as data, not as part of the SQL command

safe example:


```python
cursor.execute("DELETE FROM finance_db WHERE id = ?;", (user_input,))

"""
This time if attacker provides same user input, 
SQL engine treats user_input as a literal value, and the ? placeholder
ensures that the input cannot alter the structure of the SQL command
"""
```


### Primary Key & Autoincrement


**Primary key**: simliar to the key in a python dictionary. Often automatically generated as an incrementing integer value for every record by the database engine.  


`name TEXT PRIMARY KEY`: This sets the `name` column as the primary key for the table. The `name` must be unique for each statement.


## Errors


**OperationalError**: database is locked:

- typically occurs in SQLite when a database operation is attempted while the database is in use by another process or connection
- SQLite allows only one write operation at a time, so if another connection has the database locked, your current operation can't proceed until the lock is released.

# SQLAlchemy 


**open-source SQL toolkit and Object-Relational Mapping (ORM) system for Python**


## why?

- simplifies the connection between Python and SQL databases by automatically converting Python class calls into SQL statements
- It’s possible to map the results returned by SQL queries to objects, but doing so works against the grain of how the database works → using SQLalchemy, you can think in terms of objects and still retain the powerful features of a database engine.

## Model

- def: a Python class defining the data mapping between the Python objects returned as a result of a database query and the underlying database tables.
- inherits from`Base` class providing the interface operations between instances of the model and the database table.
- SQLAlchemy `Table` class creates a unique instance of an ORM mapped table within the database.

```python
from sqlalchemy import Column, Integer, String, ForeignKey, Table
from sqlalchemy.orm import relationship, backref
from sqlalchemy.ext.declarative import declarative_base

# Base: where all models inherit from and how they get SQLAlchemy ORM functionality.
Base = declarative_base()

# author_publisher association table model.
# creates author <-> publisher table `many-to-many` relationship
author_publisher = Table(
    "author_publisher",
    Base.metadata,
    Column("author_id", Integer, ForeignKey("author.author_id")),
    Column("publisher_id", Integer, ForeignKey("publisher.publisher_id")),
)

# book_publisher association table model.
book_publisher = Table(
    "book_publisher",
    Base.metadata,
    Column("book_id", Integer, ForeignKey("book.book_id")),
    Column("publisher_id", Integer, ForeignKey("publisher.publisher_id")),
)

# define the Author class model to the author database table.
class Author(Base):
    __tablename__ = "author"
    author_id = Column(Integer, primary_key=True)
    first_name = Column(String)
    last_name = Column(String)
    books = relationship("Book", backref=backref("author"))
    publishers = relationship(
        "Publisher", secondary=author_publisher, back_populates="authors"
    )

# define the Book class model to the book database table.
class Book(Base):
    __tablename__ = "book"
    book_id = Column(Integer, primary_key=True)
    author_id = Column(Integer, ForeignKey("author.author_id"))
    title = Column(String)
    publishers = relationship(
        "Publisher", secondary=book_publisher, back_populates="books"
    )

# define the Publisher class model to the publisher database table.
class Publisher(Base):
    __tablename__ = "publisher"
    publisher_id = Column(Integer, primary_key=True)
    name = Column(String)
    authors = relationship(
        "Author", secondary=author_publisher, back_populates="publishers"
    )
    books = relationship(
        "Book", secondary=book_publisher, back_populates="publishers"
    )
 
```


```python
class User(Base):
    __tablename__ = "user"
    user_id = Column(Integer, primary_key=True)
    username = Column(String)
    email = Column(String)
    
    # One-to-one relationship with UserProfile
    profile = relationship("UserProfile", back_populates="user", uselist=False)

class UserProfile(Base):
    __tablename__ = "user_profile"
    profile_id = Column(Integer, primary_key=True)
    user_id = Column(Integer, ForeignKey("user.user_id"), unique=True)
    bio = Column(String)
    profile_picture = Column(String)
    
    # One-to-one relationship with User
    user = relationship("User", back_populates="profile")
```


## Func


`func` :

- SQLAlchemy construct to call SQL functions in a database-agnostic way.
- acts as a proxy for various SQL functions
- i.e. you can use standard SQL functions like `MIN`, `MAX`, `COUNT`, `SUM`, `AVG`, and many others directly within your SQLAlchemy queries, without writing raw SQL.

```python
count = db.query(func.count(Transaction.id)).scalar()
# use .scalar() when you know query is going to return singular value
```


## Explanation


### **`ForeignKey`** **Creates a Connection**


This defines the existence of the relationship between tables.


### **`relationship()`** **Establishes a Collection**


If it’s a collection (e.g. Author has multiple books) we use a plural form (e.g books). When this function is called, SQLAlchemy finds the relationship in the class definition: `ForeignKey` . 

- If the relationship is through a secondary table (where the `ForeignKey`s are defined), you pass it into the param `secondary` .
- `cascade="all,  "`  will apply all possible cascade behavior, which is:
	- **delete:** When the parent object is deleted, all related child objects are deleted as well.
	- **save-update:** Changes to the parent object are automatically saved to related child objects.
	- **merge:** When the parent object is merged into the session, related child objects are merged as well.
	- **expunge:** If the parent object is removed from the session (without being deleted), related child objects are removed from the session as well.
	- **refresh-expire:** If the parent object is refreshed from the database, related child objects are also refreshed.
	- + (not in all): **delete-orphan:** A more specific behavior where child objects that are no longer associated with a parent are automatically deleted.
- By default, SQLAlchemy does not apply any cascading behaviors unless explicitly specified.

## Methods


### .join()


scenario: you want to filter `GPTLabel` based on the `Transaction` description. 


```python
existing_gpt_label = db.query(GPTLabel).join(Transaction).filter(Transaction.description == description).first()
```


`.join()` : combine rows from the `GPTLabel` table with rows from the `Transaction` table based on a related column (typically a foreign key relationship).


### .joinedload()


scenario: You want to retrieve not only a user’s transaction, but also their associated `GPTLabel`  and `Statement` :


this solves the `N+1` selects problem in ORM:


```python

# without joinedload(), you would have to do: 
transactions = db.query(Transaction).filter(Transaction.user_id == some_user_id).all()
for transaction in transactions:
    print(transaction.gpt_label.category)
    print(transaction.statement.st_name) 
# so you are essentially making 1 initial query + N*2 queries (N= # of transactions)
```


`joinedload` helps by **pre-loading** the related `GPTLabel` and `Statement` objects in the same query as the transactions, so SQLAlchemy doesn’t have to execute additional queries when you access those related objects.


```python
transactions = db.query(Transaction).options(
    joinedload(Transaction.gpt_label), 
    joinedload(Transaction.statement)
).filter(Transaction.user_id == some_user_id).all() 
# which is only 1 query now!
```


`.all()` : 

- **Single Column**:
	- `.all()` returns a list of single-element tuples.

	```python
	dates = db.query(Transaction.date).order_by(Transaction.date.asc()).all()
	# returns: [(2024-01-01,), (2024-02-15,), (2024-03-22,)]
	```

- **Multiple Columns**:
	- `.all()` returns a list of tuples, where each tuple contains the values of the queried columns.

	```python
	results = db.query(Transaction.date, Transaction.amount).all()
	# returns: [(2024-01-01, 100.0), (2024-02-15, 200.0), (2024-03-22, 150.0)]
	```

- **Full Entity**:
	- `.all()` returns a list of entity instances.

	```python
	transactions = db.query(Transaction).all()
	# returns: [<Transaction instance>, <Transaction instance>, <Transaction instance>]
	```


# Order of Execution


### Order of Execution:


T database typically processes a SQL query n a specific logical order, regardless of the order in which the components appear in the query:

1. **FROM**: The database identifies the tables involved in the query.
2. **JOIN**: If there are any joins, they are processed next.
3. **WHERE**: The database filters rows based on conditions.
4. **GROUP BY**: The database groups the filtered rows.
5. **AGGREGATE FUNCTIONS**: Functions like `MIN`, `MAX`, `SUM`, etc., are applied to each group.
6. **HAVING**: Further filtering based on the results of aggregation.
7. **SELECT**: The database selects the columns and performs any final calculations or transformations.
8. **ORDER BY**: The results are ordered according to the specified criteria.
9. **LIMIT/OFFSET**: The database limits the number of rows returned, if specified.

e.g.


```python
start_dates = db.query(func.min(Transaction.date)).group_by(Transaction.statement_id).all()
```


following the order of execution:

- **Grouping**: The database first groups the rows by `statement_id`.
- **Aggregation**: Within each group, it then applies the `MIN` function to the `date` column.
- **Selection**: Finally, it selects and returns the result.

# CRUD operations

- stands for Create, Read, Update, and Delete
- it’s a structured framework for storing data in your application with **persistence**
	- **persistence**: characteristic of state of a system that outlives (persists more than) the process that created it. This is achieved in practice by storing the state as data in computer data storage

| CRUD Operation | SQL Command |
| -------------- | ----------- |
| Create         | INSERT      |
| Read           | SELECT      |
| Update         | UPDATE      |
| Delete         | DELETE      |

- using SQLAlchemy, you don’t have to perform CRUD operations with pure SQL

```python
Pfrom crud_sql_alchemy import Session, Bird, init_db
from sqlalchemy import select
init_db()
session = Session()

# CREATE
new_bird = Bird(name="Test Bird")
session.add(new_bird) # how you add new database entries
session.commit()

# READ 
query = select(Bird).where(Bird.name == "Test Bird")
bird = session.execute(query).scalar_one()
bird
# <Bird(id=3, name='Test Bird')>

# UPDATE
bird.name = "Example Bird"
session.commit()
session.execute(select(Bird)).scalars().all()
# [<Bird(id=1, name='Hummingbird')>, <Bird(id=3, name='Example Bird')>]

# DELETE
session.delete(bird) # As long as you stay in the session, you can just do this
session.commit()
session.close() # clean up session and close
```


### Q&A section

- **Engine vs Connection vs Session?**
	- Engine:
		- lowest level object used by SQLAlchemy.
		- you can use it to **execute raw SQL**

		```python
		  result = engine.execute('SELECT * FROM tablename;')
		  # what engine.execute() is doing under the hood:
		  conn = engine.connect(close_with_result=True)
		  result = conn.execute('SELECT * FROM tablename;')
		```

	- Connection:
		- the thing that actually does the work of exzecuting a SQL query
		- you can use it **when you’re executing raw SQL code and need control**
		- i.e. do this when you want greater control over attributes of the connections. In normal use, changes are auto-commited

		```python
		 connection = engine.connect()
		  trans = connection.begin()
		  try:
		      connection.execute(text("INSERT INTO films VALUES ('Comedy', '82 minutes');"))
		      connection.execute(text("INSERT INTO datalog VALUES ('added a comedy');"))
		      trans.commit()
		  except Exception:
		      trans.rollback()
		      raise
		# you can undo both changes if one failed
		```

	- Session:
		- used for the ORM aspect of SQLAlchemy, which is why they’re importing like this: `from sqlalchemy.orm import sessionmaker` .
		- Use connections and transactions under the hood to run automatically-generated SQL statements
			- `.execute()` is a convenience function that passes through to whatever the session is bound to (engine/connection)
		- use this if you are using the ORM functionality

		```python
		# setup in `config.py`
		SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
		
		# use case
		db = SessionLocal()
		
		try:
		    new_user = User(name="Johanna")
		    db.add(new_user)
		    
		    new_profile = Profile(user_id=new_user.id, bio="CS Student")
		    db.add(new_profile)
		    
		    # Commit both operations as part of the same transaction
		    db.commit()
		except:
		    # Rollback if any operation fails
		    db.rollback()
		    raise
		finally:
		    db.close()
		   
		"""
		either you fail everything or succeed everything together
		you have more control over transactions: allowing you to 
		group operations, ensure consistency, and handle errors more gracefully
		"""
		```


# Sources


[https://pynative.com/python-sqlite/#:~:text=Use the cursor() method of a connection class to,SQLite command%2Fqueries from Python.&text=The execute() methods run the SQL query and return the result.&text=Use cursor.,() to read query result](https://pynative.com/python-sqlite/#:~:text=Use%20the%20cursor()%20method%20of%20a%20connection%20class%20to,SQLite%20command%2Fqueries%20from%20Python.&text=The%20execute()%20methods%20run%20the%20SQL%20query%20and%20return%20the%20result.&text=Use%20cursor.,()%20to%20read%20query%20result).


[https://realpython.com/python-sqlite-sqlalchemy/](https://realpython.com/python-sqlite-sqlalchemy/)


[https://stackoverflow.com/questions/34322471/sqlalchemy-engine-connection-and-session-difference](https://stackoverflow.com/questions/34322471/sqlalchemy-engine-connection-and-session-difference)


[https://realpython.com/crud-operations/#:~:text=effective data management.-,In Short%3A CRUD Stands for Create%2C Read%2C Update%2C,new entries to your database](https://realpython.com/crud-operations/#:~:text=effective%20data%20management.-,In%20Short%3A%20CRUD%20Stands%20for%20Create%2C%20Read%2C%20Update%2C,new%20entries%20to%20your%20database).
