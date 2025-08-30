USE BikeStores

-- 1) Min ve max �r�n fiyatlar�
SELECT Min(list_price) AS 'Minimum'
FROM production.products

SELECT Max(list_price) AS 'Maximum'
FROM production.products


-- 2) �r�nlerin toplam say�s�, toplam fiyat�, ortalama fiyatlar�
SELECT COUNT(*) AS '�r�n Say�s�'
FROM production.products

SELECT SUM(list_price) AS 'Toplam Fiyat'
FROM production.products

SELECT AVG(list_price) AS 'Ortalama Fiyat'
FROM production.products


-- 3)Santa Cruz Bikes ma�azas�ndan sipari� veren 5 m��terinin Ad� ve Soyad�
SELECT TOP 5 first_name, last_name
FROM sales.customers AS SC, sales.orders AS SO, sales.stores AS SS
WHERE SC.customer_id = SO.customer_id AND SS.store_name = 'Santa Cruz Bikes'


-- 4) Ad�n� ikinci harfi = 'S', Soyad�n�n son harfi = 'A' olan m��terilerin ad� ve soyad�
SELECT first_name, last_name
FROM sales.customers
WHERE first_name LIKE '_s%' AND last_name LIKE '%a'


-- 5) 2015 ve 2017 y�llar� aras�nda sipari� veren m��terilerin ad ve soyad�
-- 1. Y�ntem
SELECT DISTINCT first_name, last_name
FROM sales.customers AS SC, sales.orders AS SO, sales.order_items AS SOI, production.products AS PP
WHERE SC.customer_id = SO.customer_id AND SO.order_id = SOI. order_id AND SOI.product_id = PP.product_id AND PP.model_year BETWEEN 2015 AND 2017 

-- 2. Y�ntem
SELECT DISTINCT first_name, last_name
FROM sales.customers JOIN sales.orders ON sales.customers.customer_id = sales.orders.customer_id 
JOIN sales.order_items ON sales.orders.order_id = sales.order_items.order_id 
JOIN production.products ON production.products.product_id = sales.order_items.product_id
WHERE production.products.model_year BETWEEN 2015 AND 2017


-- 6) Santa Cruz Bikes', 'Baldwin Bikes sipari� veren m��teriler
-- 1. Y�ntem
SELECT TOP 10 first_name, last_name
FROM sales.customers AS SC, sales.orders AS SO, sales.stores AS SS
WHERE SS.store_name IN ('Santa Cruz Bikes', 'Baldwin Bikes') AND SS.store_id = SO.store_id AND SO.customer_id = SC.customer_id

-- 2. Y�ntem
SELECT TOP 10 first_name, last_name
FROM sales.customers JOIN sales.orders ON sales.customers.customer_id = sales.orders.customer_id 
JOIN sales.stores ON sales.stores.store_id = sales.orders.store_id
WHERE sales.stores.store_name IN ('Santa Cruz Bikes', 'Baldwin Bikes')