
-- Create a table for Trello-like cards
CREATE TABLE cards
(
    id SERIAL,
    board_id INT NOT NULL,
    data JSONB
);

-- Create a table for servers
CREATE TABLE servers
(
    id SERIAL PRIMARY KEY,
    server_info JSONB NOT NULL
);


-- Populate the cards table
INSERT INTO cards
VALUES
(1, 1, '{"name": "Paint house", "tags": ["Improvements", "Office"], "finished": true}'),
(2, 1, '{"name": "Wash dishes", "tags": ["Clean", "Kitchen"], "finished": false}'),
(3, 1, '{"name": "Cook lunch", "tags": ["Cook", "Kitchen", "Tacos"], "ingredients": ["Tortillas", "Guacamole"], "finished": false}'),
(4, 1, '{"name": "Vacuum", "tags": ["Clean", "Bedroom", "Office"], "finished": false}'),
(5, 1, '{"name": "Hang paintings", "tags": ["Improvements", "Office"], "finished": false}');

-- Select only the "name" values from the JSON data
SELECT data ->> 'name' AS name FROM cards;

-- Select only tasks that have been completed
SELECT * FROM cards WHERE data ->> 'finished' = 'true';

-- Create table for textbooks
CREATE TABLE textbooks
(
    id SERIAL PRIMARY KEY,
    book_info JSONB
);

-- Populate textbooks table
INSERT INTO textbooks(book_info)
VALUES
('{
    "title": "Python Crash Course, 2nd Edition: A Hands-On, Project-Based Introduction to Programming",
    "ISBN": 1593279280,
    "condition": "new",
    "price": 22.99,
    "hardcover": false,
    "authors": ["Eric Matthes"]
}'),
('{
    "title": "Applied Cryptography: Protocols, Algorithms and Source Code in C 20th Anniversary Edition",
    "ISBN": 1119096723,
    "condition": "new",
    "price": 55.00,
    "hardcover": true,
    "authors": ["Bruce Schneier"]
}'),
('{
    "title": "Gravitation",
    "ISBN": 9780691177793,
    "condition": "used",
    "price": 45.40,
    "hardcover": true,
    "authors": ["Charles W. Misner", "Kip S. Thorne", "John A. Wheeler"]
}'),
('{
    "title": "Programming C# 8.0: Build Cloud, Web, and Desktop Applications",
    "ISBN": 1492056812,
    "condition": "new",
    "price": 54.82,
    "hardcover": false,
    "authors": ["Ian Griffiths"]
}'),
('{
    "title": "Mastering PostgreSQL 11: Expert techniques to build scalable, reliable, and fault-tolerant database applications, 2nd Edition",
    "ISBN": 1789537819,
    "condition": "used",
    "price": 39.99,
    "hardcover": false,
    "authors": ["Hans-Jürgen Schönig"]
}');

-- Select only titles
SELECT book_info ->> 'title' AS title
FROM textbooks;

-- Select books that cost less than $50.00
SELECT book_info ->> 'title' AS title, book_info ->> 'price' AS price
FROM textbooks
WHERE cast
(
    book_info ->> 'price' AS DECIMAL
) < 50.00;

-- Select only hardcover books
SELECT book_info ->> 'title' AS title, book_info ->> 'hardcover' AS is_hardcover
FROM textbooks
WHERE cast
(
    book_info ->> 'hardcover' AS BOOLEAN
) = true;