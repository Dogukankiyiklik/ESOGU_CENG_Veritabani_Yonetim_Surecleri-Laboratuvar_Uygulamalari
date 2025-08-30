/******************************* 1. SORU *******************************/

	/* Farklý maðazalardan sipariþ veren müþterileri karþýlaþtýr, ilk maðazadan sipariþ veren
	fakat ikinci maðazadan vermeyen müþterileri listele (Maðaza id) */

/******************************* 1. CEVAP *******************************/

/*
	CREATE PROCEDURE GetCustomer @birincimagazaID INT, @ikincimagazaID INT
	AS
	BEGIN
		SELECT SC.first_name, SC.last_name
		FROM sales.customers AS SC
		INNER JOIN sales.orders AS SO ON SO.customer_id = SC.customer_id
		INNER JOIN sales.stores AS SS ON SS.store_id = SO.store_id
		WHERE SO.store_id = @birincimagazaID
		EXCEPT
		SELECT SC.first_name, SC.last_name
		FROM sales.customers AS SC
		INNER JOIN sales.orders AS SO ON SO.customer_id = SC.customer_id
		INNER JOIN sales.stores AS SS ON SS.store_id = SO.store_id
		WHERE SO.store_id = @ikincimagazaID
	END;

	EXEC GetCustomer @birincimagazaID = 1, @ikincimagazaID = 2
*/



/******************************* 2. SORU *******************************/

	/*oluþturulan saklý yodamý güncelle ve müþteri adý 
	X olan kiþinin en yüksek sipariþi getirmesini saðla*/

/******************************* 2. CEVAP *******************************/

/*
	ALTER PROCEDURE GetCustomer @firstName VARCHAR(255)
	AS
	BEGIN
		SELECT SC.first_name, MAX(SOI.list_price * SOI. quantity) AS 'En Yüksek Ürün Tutarý'
		FROM sales.customers AS SC
		INNER JOIN sales.orders AS SO ON SO.customer_id = SC.customer_id
		INNER JOIN sales.order_items AS SOI ON SOI.order_id = SO.order_id
		WHERE SC.first_name = @firstName 
		GROUP BY SC.first_name
	END;

	EXEC GetCustomer @firstName = 'Mercy'
*/



/******************************* 3. SORU *******************************/

	/* Belirli bir müþ. ait tüm sipariþlerin maðazalara göre 
	toplam deðeribni hesaplayan yordam. müþteri kimliðini alsýn	 */

/******************************* 3. CEVAP *******************************/

/*
	CREATE PROCEDURE GetOrders @musteriID INT
	AS
	BEGIN
		SELECT SO.store_id, SUM(SOI.list_price * SOI.quantity) AS 'Toplam Tutar'
		FROM sales.order_items AS SOI
		INNER JOIN sales.orders AS SO ON SO.order_id = SOI.order_id
		INNER JOIN sales.customers AS SC ON SC.customer_id = SO.customer_id
		WHERE SC.customer_id = @musteriID
		GROUP BY SO.store_id, SC.customer_id
	END;

	EXEC GetOrders @musteriID = 10
*/



/******************************* 4. Soru *******************************/

	/*	Her kategori için satýlan ürün adedi 100'ü geçen geçen kategorileri göster.
	kategor id, kategori adý ve ürün adýný listelesin. HAVING kullan */

/******************************* 4. CEVAP *******************************/

/*
	CREATE PROCEDURE GetCategory
	AS
	BEGIN
		SELECT COUNT(SOI.quantity) AS 'Miktar', PC.category_id, PC.category_name
		FROM production.categories AS PC
		INNER JOIN production.products AS PP ON PP.product_id = PC.category_id
		INNER JOIN sales.order_items AS SOI ON SOI.product_id = PP.product_id
		Group BY PC.category_id, PC.category_name
		HAVING COUNT(SOI.quantity) > 100
	END;

	EXEC GetCategory
*/



/******************************* 5. Soru *******************************/

	/* Fiyatý belirli bir deeðrden yüksek olan ürünleri göster. En az bir maðazada 
	stok miktarý 10'dan fazla olan ürünleri listele	*/

/******************************* 5. CEVAP *******************************/


	CREATE PROCEDURE GetProducts @Price DECIMAL(10,2), @stockQuantity INT 
	AS
	BEGIN
		SELECT PS.product_id, PS.quantity, SOI.list_price
		FROM production.stocks AS PS
		INNER JOIN sales.orders AS SO ON SO.store_id = PS.store_id
		INNER JOIN sales.order_items AS SOI ON SOI.order_id = SO.order_id
		WHERE PS.quantity > @stockQuantity AND SOI.list_price > @Price
	END;

	EXEC GetProducts @Price = 500, @stockQuantity = 10




/******************************* 6. Soru *******************************/

	/* en son yordamý sil	*/

/******************************* 6. CEVAP *******************************/

/*
	DROP PROCEDURE GetProducts
*/