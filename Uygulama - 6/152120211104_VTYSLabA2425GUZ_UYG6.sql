-- 1) Her bir manager'in; staff_id, first_name, last_name, staff sayýsýný listele
SELECT S1.manager_id, S1.staff_id, S1.first_name, S1.last_name
FROM sales.staffs AS S1, sales.staffs AS S2


SELECT S1.staff_id, S1.first_name, S1.last_name, S1.manager_id
FROM sales.staffs AS S1


--2) Bir maðazada stokta bulunan ve miktarý 26'dan fazla olan tüm ürünlerin isimlerini listele ANY
SELECT product_name
FROM production.products
WHERE product_id = ANY 
	(SELECT product_id
	FROM sales.stores AS SS
	INNER JOIN production.stocks AS PS ON PS.store_id = SS.store_id
	WHERE PS.quantity > 26);


--3) Bir maðazada stokta bulunan ve miktarý 26 olan tüm ürünlerin isimlerini listele ALL
SELECT product_name
FROM production.products
WHERE product_id = ALL 
	(SELECT product_id
	FROM sales.stores AS SS
	INNER JOIN production.stocks AS PS ON PS.store_id = SS.store_id
	WHERE PS.quantity = 26);



--4) Stokta miktarý 30 olan ve fiyatý > 3000 olan en az bir ürününün bulunduðu maðaza isimlerini listele EXIST
SELECT store_name
FROM sales.stores
INNER JOIN production.stocks AS PS ON PS.store_id = sales.stores.store_id
WHERE EXISTS (SELECT product_id FROM production.products WHERE production.products.product_id = PS.product_id AND production.products.list_price > 3000 AND PS.quantity > 30) 

--5) Santa Cruz Bikes'dan aliþveriþ yapan her bir þehirdeki müþteri sayýsýný hesapla. Müþteri sayýsý 10'dan fazla olan þehirleri, müþetri sayýsýna göre azalan sýrayla sýrala
SELECT COUNT(SC.customer_id) AS 'Müþteri Sayýsý', SS.city
FROM sales.customers AS SC
INNER JOIN sales.orders AS SO ON SO.customer_id = SC.customer_id
INNER JOIN sales.stores AS SS ON SS.store_id = SO.store_id AND SS.store_name = 'Santa Cruz Bikes'
GROUP BY SS.city
HAVING COUNT(SC.customer_id) > 10
ORDER BY COUNT(SC.customer_id)


--6) Baldwin Bikes stores'dan orders vermeyen customer'lerin first_name ve last_name bilgileri
SELECT first_name, last_name FROM sales.customers 
EXCEPT
SELECT SO.customer_id FROM sales.orders AS SO



SELECT customer_id FROM sales.orders
EXCEPT 
SELECT store_id FROM sales.stores 
WHERE sales.stores.store_name = 'Baldwin Bikes'
