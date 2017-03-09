-- Provide a query showing Customers (just their full names, customer ID and country) who are not in the US.

SELECT FirstName, LastName, CustomerId, Country
FROM Customer
WHERE Country != "USA"


-- Provide a query only showing the Customers from Brazil.

SELECT FirstName, LastName, CustomerId, Country
FROM Customer
WHERE Country = "Brazil"


-- Provide a query showing the Invoices of customers who are from Brazil.
-- The resultant table should show the customer's full name, Invoice ID,
-- Date of the invoice and billing country.

SELECT C.FirstName, C.LastName, I.InvoiceId, I.InvoiceDate, I.BillingCountry
FROM Customer C
JOIN Invoice I
ON I.CustomerId = C.CustomerId
WHERE Country = "Brazil"

-- or

SELECT C.FirstName, C.LastName, I.InvoiceId, I.InvoiceDate, I.BillingCountry
FROM Customer C, Invoice I
ON I.CustomerId = C.CustomerId
WHERE Country = "Brazil"


-- Provide a query showing only the Employees who are Sales Agents.

SELECT * FROM Employee
WHERE Title = "Sales Support Agent"


-- Provide a query showing a unique list of billing countries from the Invoice table.

SELECT I.BillingCountry
FROM Invoice I
GROUP BY I.BillingCountry


-- Provide a query showing the invoices of customers who are from Brazil.

  SELECT *
  FROM Invoice
  WHERE Invoice.BillingCountry = 'Brazil'

  -- for some reason I thinking the customer country could be different from the billing country
  -- or

  SELECT *
  FROM Invoice I, Customer C
  ON C.CustomerId = I.CustomerId
  WHERE C.Country = 'Brazil'

  -- or

  SELECT *
  FROM Invoice I
  LEFT JOIN Customer C
  ON C.CustomerId = I.CustomerId
  WHERE C.Country = 'Brazil'


-- Provide a query that shows the invoices associated with each sales agent. The resultant table should include the Sales Agent's full name.

SELECT I.InvoiceId, E.FirstName || ' ' || E.LastName AS 'Full Name'
FROM Employee E
LEFT JOIN Customer C
ON C.SupportRepId = E.EmployeeId
LEFT JOIN Invoice I
ON I.CustomerId = C.CustomerId
WHERE E.Title = "Sales Support Agent"
GROUP BY I.InvoiceId


-- Provide a query that shows the Invoice Total, Customer name, Country and Sale Agent name for all invoices and customers.

SELECT I.Total AS 'Total Sales',
       C.FirstName || ' ' || C.LastName AS 'Customer Name',
       C.Country AS "Customer Country",
       E.FirstName || ' ' || E.LastName AS 'Sales Agent'
FROM Employee E
LEFT JOIN Customer C
ON C.SupportRepId = E.EmployeeId
LEFT JOIN Invoice I
ON I.CustomerId = C.CustomerId
WHERE E.Title = "Sales Support Agent"


-- How many Invoices were there in 2009 and 2011? What are the respective total sales for each of those years?

  -- Doesn't work - doesn't return correct number of invoices
  -- SELECT I.InvoiceId, I.Total
  -- FROM Invoice I
  -- WHERE I.InvoiceDate >= '2009-1-1' AND I.InvoiceDate <= '2011-12-31'

-- This works

  SELECT substr( I.InvoiceDate, 1, 4 ) AS 'Year', COUNT(I.InvoiceDate) AS '# of Invoices', SUM(I.Total) AS 'Total'
  FROM Invoice I
  WHERE substr( I.InvoiceDate, 1, 4 ) = '2009'
  OR substr( I.InvoiceDate, 1, 4 ) = '2011'
  GROUP BY strftime('%Y', I.InvoiceDate)


-- Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for Invoice ID 37.

SELECT COUNT(IL.InvoiceID) AS "Num Lines"
FROM InvoiceLine IL
WHERE IL.InvoiceId = '37'

-- Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for each Invoice. HINT: GROUP BY

SELECT I.InvoiceId, COUNT(I.InvoiceId)
FROM InvoiceLine I
GROUP BY I.InvoiceId


-- Provide a query that includes the track name with each invoice line item.

SELECT I.InvoiceLineId, T.Name
FROM Track T
LEFT JOIN InvoiceLine I
ON I.TrackId = T.TrackId
WHERE I.InvoiceLineId != NULL

-- Provide a query that includes the purchased track name AND artist name with each invoice line item.

SELECT IL.InvoiceLineId, T.Name AS "Song Name", ART.Name AS "Artist Name"
FROM InvoiceLine IL
LEFT JOIN Track T
ON IL.TrackId = T.TrackId
LEFT JOIN Album ALB
ON T.AlbumId = ALB.AlbumId
LEFT JOIN Artist ART
ON ALB.ArtistId = Art.ArtistId

-- Provide a query that shows the # of invoices per country. HINT: GROUP BY

SELECT I.BillingCountry, COUNT(I.BillingCountry) AS "# Invoices"
FROM Invoice I
GROUP BY I.BillingCountry


-- Provide a query that shows the total number of tracks in each playlist. The Playlist name should be include on the resultant table.

SELECT Plist.Name, COUNT(PLTrack.PlaylistId)
FROM PlayList Plist
JOIN PlaylistTrack PLTrack
ON Plist.PlaylistId = PLTrack.PlaylistId
GROUP BY Plist.Name

-- Provide a query that shows all the Tracks, but displays no IDs. The resultant table should include the Album name, Media type and Genre.

SELECT A.Title AS "Album Name", M.Name AS "Media Type", G.Name AS "Genre"
FROM Track T
LEFT JOIN Album A
ON T.AlbumId = A.AlbumId
LEFT JOIN MediaType M
ON T.MediaTypeId = M.MediaTypeId
LEFT JOIN Genre G
ON T.GenreId = G.GenreId


-- Provide a query that shows all Invoices but includes the # of invoice line items.

SELECT I.InvoiceId, COUNT(IL.InvoiceId) AS "# Invoices"
FROM Invoice I, InvoiceLine IL
WHERE I.InvoiceId = IL.InvoiceId
GROUP BY I.InvoiceId


-- Provide a query that shows total sales made by each sales agent.

SELECT E.FirstName || " " || E.LastName AS "Employee Name", SUM(I.Total) AS "Total Sales"
FROM Employee E
JOIN Customer C
ON E.EmployeeId = C.SupportRepId
JOIN Invoice I
ON C.CustomerId = I.CustomerId
WHERE E.Title = "Sales Support Agent"
GROUP BY E.EmployeeId


-- Which sales agent made the most in sales in 2009?

SELECT E.FirstName || " " || E.LastName AS "Employee Name", SUM(I.Total) AS "2009 Employee Sales"
FROM Employee E
JOIN Customer C
ON E.EmployeeId = C.SupportRepId
JOIN Invoice I
ON C.CustomerId = I.CustomerId
WHERE E.Title = "Sales Support Agent"
AND substr(I.InvoiceDate, 1, 4) = "2009"
GROUP BY E.EmployeeId
ORDER BY SUM(I.Total) DESC
LIMIT 1

-- Which sales agent made the most in sales in 2010?

SELECT E.FirstName || " " || E.LastName AS "Employee Name", SUM(I.Total) AS "2010 Employee Sales"
FROM Employee E
JOIN Customer C
ON E.EmployeeId = C.SupportRepId
JOIN Invoice I
ON C.CustomerId = I.CustomerId
WHERE E.Title = "Sales Support Agent"
AND substr(I.InvoiceDate, 1, 4) = "2010"
GROUP BY E.EmployeeId
ORDER BY SUM(I.Total) DESC
LIMIT 1


-- Which sales agent made the most in sales over all?

SELECT E.FirstName || " " || E.LastName AS "Employee Name", SUM(I.Total) AS "Total Sales"
FROM Employee E
JOIN Customer C
ON E.EmployeeId = C.SupportRepId
JOIN Invoice I
ON C.CustomerId = I.CustomerId
WHERE E.Title = "Sales Support Agent"
GROUP BY E.EmployeeId
ORDER BY "Total Sales" DESC
LIMIT 1


-- Provide a query that shows the # of customers assigned to each sales agent.

SELECT E.FirstName || " " || E.LastName AS "Sales Agent", COUNT(C.SupportRepId) AS "# of Customers"
FROM Employee E
JOIN Customer C
ON E.EmployeeId = C.SupportRepId
WHERE E.Title = "Sales Support Agent"
GROUP BY E.EmployeeId


-- Provide a query that shows the total sales per country. Which country's customers spent the most?

SELECT C.Country, SUM(I.Total) AS "Country Total Sales"
FROM Customer C
JOIN Invoice I
ON C.CustomerId = I.CustomerId
GROUP BY C.Country

-- Provide a query that shows the most purchased track of 2013.

SELECT T.Name, substr( I.InvoiceDate, 1, 4) AS 'Year Sold', COUNT(T.TrackId) AS '# Tracks Sold'
FROM Track T
JOIN InvoiceLine IL
ON T.TrackId = IL.TrackId
JOIN Invoice I
ON IL.InvoiceId = I.InvoiceId
WHERE substr( I.InvoiceDate, 1, 4 ) = '2013'
GROUP BY T.TrackId
ORDER BY COUNT(T.TrackId) DESC
LIMIT 1


-- Provide a query that shows the top 5 most purchased tracks over all.

  -- best selling track by total sales

  SELECT T.Name, SUM(I.Total) AS "Most Sold Track"
  FROM Track T
  JOIN InvoiceLine IL
  ON T.TrackId = IL.TrackId
  JOIN Invoice I
  ON IL.InvoiceId = I.InvoiceId
  GROUP BY T.Name
  ORDER BY "Most Sold Track" DESC
  LIMIT 5

  -- best selling track by num tracks sold

  SELECT T.Name, SUM(IL.Quantity) AS "Tracks Sold", T.TrackId, IL.TrackId
  FROM Track T
  JOIN InvoiceLine IL
  ON T.TrackId = IL.TrackId
  GROUP BY T.TrackId
  ORDER BY "Tracks Sold" DESC
  LIMIT 5


-- Provide a query that shows the top 3 best selling artists.

SELECT Art.Name, SUM(I.Total) AS "Total Artist Sales"
FROM Artist Art
JOIN Album Alb
ON Art.ArtistId = Alb.ArtistId
JOIN Track T
ON Alb.AlbumID = T.AlbumId
JOIN InvoiceLine IL
ON T.TrackId = IL.TrackId
JOIN Invoice I
ON IL.InvoiceId = I.InvoiceId
GROUP BY Art.Name
ORDER BY "Total Artist Sales" DESC
LIMIT 3

-- Provide a query that shows the most purchased Media Type.

SELECT M.Name, SUM(I.Total) AS "Total"
FROM MediaType M
JOIN Track T
ON M.MediaTypeId = T.MediaTypeId
JOIN InvoiceLine IL
ON T.TrackId = IL.TrackId
JOIN Invoice I
ON IL.InvoiceId = I.InvoiceId
GROUP BY M.Name
ORDER BY "Total" DESC
LIMIT 1
