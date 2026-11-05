--- 05-11-2026 16:32:33 SQLite
SELECT Libraries.Name AS Библиотека,
  ROUND(AVG(Readers.Age), 0) AS Средний_возраст,
  SUM(CASE WHEN Readers.Gender = 'М' THEN 1 ELSE 0 END) AS Мужчин,
  SUM(CASE WHEN Readers.Gender = 'Ж' THEN 1 ELSE 0 END) AS Женщин,
  COUNT(DISTINCT Readers.ID) AS Читателей
FROM Loans 
JOIN Readers ON Readers.ID = Loans.Reader_ID
JOIN Books ON Books.ID = Loans.Book_ID
JOIN Libraries ON Libraries.ID = Books.Library_ID
GROUP BY Libraries.ID, Libraries.Name
ORDER BY Читателей DESC;


