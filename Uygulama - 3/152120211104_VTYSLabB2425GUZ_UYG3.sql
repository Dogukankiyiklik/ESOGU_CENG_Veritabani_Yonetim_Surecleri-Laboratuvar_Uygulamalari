-- Soru 1: Ürünler tablosundan kategori kimliði (category_id) 3 olan tüm ürünlerin adýný ve liste fiyatýný listelemek için bir SQL SELECT sorgusu yazýnýz.
SELECT product_name, list_price
FROM production.products
WHERE category_id = 3;


-- --Soru 2: Müþteriler tablosundaki tüm benzersiz þehirleri, eyaleti 'California' olan müþterileri listeyiniz.
SELECT city
FROM sales.customers
WHERE state = 'California';


---Soru 3: Müþteriler arasýnda California (CA) eyaletinde oturan ama ‘Los Angeles’ ve ‘Campbell’þehirlerinde oturmayan tüm müþterilerin ‘adý, soyadý, telefon numarasý, þehri ve eyaletini listeleyiniz.
SELECT first_name, last_name, phone, city, state
FROM sales.customers
WHERE state = 'California' AND city NOT IN ('Los Angeles', 'Campbell');


----Soru 4: Müþteriler tablosuna yeni bir müþteri ekleyin. Müþterinin adý 'John Doe', e-posta adresi 'john.doe@email.com' ancak telefon numarasý ve adres bilgilerini tabloya ekleyiniz.
INSERT INTO sales.customers (first_name, last_name, email, phone, street, city, state, zip_code)
VALUES ('John', 'Doe', 'john.doe@email.com', NULL, NULL, NULL, NULL, NULL);


--Soru 5 a) Müþteriler tablosuna eklenen müþteri adý 'John Doe' olan kiþinin telefon numarasýný '559- 329-7915’ olarak güncelleyiniz.
UPDATE sales.customers
SET phone = '559-329-7915'
WHERE first_name = 'John' AND last_name = 'Doe';


--Soru 5 b) Müþteri numarasý 1446 olan müþterinin bazý bilgileri eksik ya da yanlýþ girilmiþ, bu müþteri kaydýnýz siliniz ve John Doe isimli kiþinin bilgilerini SELECT sorgusu ile çekiniz.
DELETE FROM sales.customers
WHERE customer_id = 1446;

SELECT * 
FROM sales.customers
WHERE first_name = 'John' AND last_name = 'Doe';