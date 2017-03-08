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

SELECT I.InvoiceId, I.Total
FROM Invoice I
WHERE I.InvoiceDate >= '2009-1-1' AND I.InvoiceDate <= '2011-12-31' -- STILL WORKING ON THIS

-- Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for Invoice ID 37.

SELECT COUNT(IL.InvoiceID) AS "Num Lines"
FROM InvoiceLine IL
WHERE IL.InvoiceId = '37'

-- Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for each Invoice. HINT: GROUP BY


-- Provide a query that includes the track name with each invoice line item.


-- Provide a query that includes the purchased track name AND artist name with each invoice line item.


-- Provide a query that shows the # of invoices per country. HINT: GROUP BY


-- Provide a query that shows the total number of tracks in each playlist. The Playlist name should be include on the resultant table.


-- Provide a query that shows all the Tracks, but displays no IDs. The resultant table should include the Album name, Media type and Genre.


-- Provide a query that shows all Invoices but includes the # of invoice line items.


-- Provide a query that shows total sales made by each sales agent.


-- Which sales agent made the most in sales in 2009?


-- Which sales agent made the most in sales in 2010?


-- Which sales agent made the most in sales over all?


-- Provide a query that shows the # of customers assigned to each sales agent.


-- Provide a query that shows the total sales per country. Which country's customers spent the most?


-- Provide a query that shows the most purchased track of 2013.


-- Provide a query that shows the top 5 most purchased tracks over all.


-- Provide a query that shows the top 3 best selling artists.


-- Provide a query that shows the most purchased Media Type.
