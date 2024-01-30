--Task 1 & 2)
/*
Normalise the data shown in the table so that it has multiple tables 
(Film, Director, Star and Writer) with an appropriate Primary Key for each 
and suitable Foreign Key relationships set up so that the data can still be linked together as needed.

Save your database schema and the data that will be generated by it into a suitable file in 
the repository as a planning document. This could be a physical ERD diagram of the tables.
*/

+------------------+          +------------------+
|      Film        |          |     Directors     |
+------------------+          +------------------+
| FilmID (PK)     |<--------- | DirectorID (PK)  |
| Title           |           | DirectorName     |
| Year            |           | DirectorCountry  |
| Genre           |           +------------------+
| Score           |
| DirectorID (FK) |<---------+
| StarID (FK)     |
| WriterID (FK)   |
+------------------+

+------------------+
|      Star      |
+------------------+
| StarID (PK)     |
| StarName        |
| StarDOB         |
+------------------+

+------------------+
|     Writer     |
+------------------+
| WriterID (PK)   |
| WriterName      |
| WriterEmail     |
+------------------+

--Task 3-5)
/*Open TablePlus and connect to your ElephantSQL database
You are going to create some tables to match the schema
Then populate the tables with the data shown*/

CREATE TABLE Film (
    FilmID SERIAL PRIMARY KEY,
    Title VARCHAR(255),
    Year INT,
    Genre VARCHAR(50),
    Score INT,
    DirectorID INTEGER REFERENCES Directors(DirectorID),
    StarID INTEGER REFERENCES Star(StarID),
    WriterID INTEGER REFERENCES Writer(WriterID)
);

CREATE TABLE Directors (
    DirectorID SERIAL PRIMARY KEY,
    DirectorName VARCHAR(255),
    DirectorCountry VARCHAR(100)
);


CREATE TABLE Star (
    StarID SERIAL PRIMARY KEY,
    StarName VARCHAR(255),
    StarDOB DATE
);

CREATE TABLE Writer (
    WriterID SERIAL PRIMARY KEY,
    WriterName VARCHAR(255),
    WriterEmail VARCHAR(255)
);



-- Insert data into Director table
INSERT INTO Directors (DirectorName, DirectorCountry)
VALUES
('Stanley Kubrick', 'USA'),
('George Lucas', 'USA'),
('Robert Mulligan', 'USA'),
('James Cameron', 'Canada'),
('David Lean', 'UK'),
('Anthony Mann', 'USA'),
('Theodoros Angelopoulos', 'Greece'),
('Paul Verhoeven', 'Netherlands'),
('Krzysztof Kieslowski', 'Poland'),
('Jean-Paul Rappeneau', 'France');

-- Insert data into Star table
INSERT INTO Star (StarName, StarDOB)
VALUES
('Keir Dullea', '1936-05-30'),
('Mark Hamill', '1951-09-25'),
('Gregory Peck', '1916-04-05'),
('Leonardo DiCaprio', '1974-11-11'),
('Julie Christie', '1940-04-14'),
('Charlton Heston', '1923-10-04'),
('Manos Katrakis', '1908-08-14'),
('Rutger Hauer', '1944-01-23'),
('Juliette Binoche', '1964-03-09'),
('Gerard Depardieu', '1948-12-27');

-- Insert data into Writer table
INSERT INTO Writer (WriterName, WriterEmail)
VALUES
('Arthur C Clarke', 'arthur@clarke.com'),
('George Lucas', 'george@email.com'),
('Harper Lee', 'harper@lee.com'),
('James Cameron', 'james@cameron.com'),
('Boris Pasternak', 'boris@boris.com'),
('Frederick Frank', 'fred@frank.com'),
('Theodoros Angelopoulos', 'theo@angelopoulos.com'),
('Erik Hazelhoff Roelfzema', 'erik@roelfzema.com'),
('Krzysztof Kieslowsk', 'email@email.com'),
('Edmond Rostand', 'edmond@rostand.com');

-- Insert data into Film table
INSERT INTO Film (Title, Year, Genre, Score, DirectorID, StarID, WriterID)
VALUES
('2001: A Space Odyssey', 1968, 'Science Fiction', 10, 1, 1, 1),
('Star Wars: A New Hope', 1977, 'Science Fiction', 7, 2, 2, 2),
('To Kill A Mockingbird', 1962, 'Drama', 10, 3, 3, 3),
('Titanic', 1997, 'Romance', 5, 4, 4, 4),
('Dr Zhivago', 1965, 'Historical', 8, 5, 5, 5),
('El Cid', 1961, 'Historical', 6, 6, 6, 6),
('Voyage to Cythera', 1984, 'Drama', 8, 7, 7, 7),
('Soldier of Orange', 1977, 'Thriller', 8, 8, 8, 8),
('Three Colours: Blue', 1993, 'Drama', 8, 9, 9, 9),
('Cyrano de Bergerac', 1990, 'Historical', 9, 10, 10, 10);

-- Check data in Director table
SELECT * FROM Directors;

-- Check data in Star table
SELECT * FROM Star;

-- Check data in Writer table
SELECT * FROM Writer;

-- Check data in Film table
SELECT * FROM Film;

--Task 6)

--Once you have the tables and data set up then you need to create queries to return the data needed as shown below:

--i) Show the title and director name for all films
SELECT Film.Title, Directors.DirectorName
FROM Film
JOIN Directors ON Film.DirectorID = Directors.DirectorID;


--ii) Show the title, director and star name for all films
SELECT Film.Title, Directors.DirectorName, Star.StarName
FROM Film
JOIN Directors ON Film.DirectorID = Directors.DirectorID
JOIN Star ON Film.StarID = Star.StarID;

--iii) Show the title of films where the director is from the USA
SELECT Film.Title, Directors.DirectorCountry
FROM Film
JOIN Directors ON Film.DirectorID = Directors.DirectorID
WHERE Directors.DirectorCountry = 'USA';

--iv) Show only those films where the writer and the director are the same person
SELECT Film.Title, Directors.DirectorName,  Writer.WriterName
FROM Film
JOIN Directors ON Film.DirectorID = Directors.DirectorID
JOIN Writer ON Film.WriterID = Writer.WriterID
WHERE Directors.DirectorName = Writer.WriterName;

--v) Show directors and film titles for films with a score of 8 or higher
SELECT Directors.DirectorName, Film.Title, Film.Score
FROM Film
JOIN Directors ON Film.DirectorID = Directors.DirectorID
WHERE Film.Score >= 8;


--vi) Make at least 5 more queries to demonstrate your understanding of joins, and other relationships between tables.
--Extra Tasks)
--1)Show films with star names and genres:
SELECT Film.Title, Star.StarName, Film.Genre
FROM Film
JOIN Star ON Film.StarID = Star.StarID;

--2) Show films with writer names and release years:
SELECT Film.Title, Writer.WriterName, Film.Year
FROM Film
JOIN Writer ON Film.WriterID = Writer.WriterID;

--3) Show directors and star names for films released after 1980:

SELECT Directors.DirectorName, Star.StarName
FROM Film
JOIN Directors ON Film.DirectorID = Directors.DirectorID
JOIN Star ON Film.StarID = Star.StarID
WHERE Film.Year > 1980;

--4) Show writers and film titles for dramas:
SELECT Writer.WriterName, Film.Title
FROM Film
JOIN Writer ON Film.WriterID = Writer.WriterID
WHERE Film.Genre = 'Drama';

--5) Show the earliest and latest release year for each director:
SELECT Directors.DirectorName, MIN(Film.Year) AS EarliestRelease, MAX(Film.Year) AS LatestRelease
FROM Film
JOIN Directors ON Film.DirectorID = Directors.DirectorID
GROUP BY Directors.DirectorName;