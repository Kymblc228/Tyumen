--- 05-11-2026 16:31:22 SQLite
SELECT Возрастная_категория, Жанр, Выдач
FROM (
    SELECT
        CASE
            WHEN Readers.Age < 18 THEN 'До 18'
            WHEN Readers.Age BETWEEN 18 AND 35 THEN '18–35'
            WHEN Readers.Age BETWEEN 36 AND 60 THEN '36–60'
            ELSE '60+'
        END AS Возрастная_категория,
        Books.Genre AS Жанр,
        COUNT(Loans.Book_ID) AS Выдач,
        RANK() OVER (
            PARTITION BY CASE
                WHEN Readers.Age < 18 THEN 'До 18'
                WHEN Readers.Age BETWEEN 18 AND 35 THEN '18–35'
                WHEN Readers.Age BETWEEN 36 AND 60 THEN '36–60'
                ELSE '60+'
            END
            ORDER BY COUNT(Loans.Book_ID) DESC
        ) AS rating
    FROM Loans 
    JOIN Readers ON Readers.ID = Loans.Reader_ID
    JOIN Books ON Books.ID = Loans.Book_ID
    GROUP BY Возрастная_категория, Books.Genre
)
WHERE rating = 1
ORDER BY Возрастная_категория;


