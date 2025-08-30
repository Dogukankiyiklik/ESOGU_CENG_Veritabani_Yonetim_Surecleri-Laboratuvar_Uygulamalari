-- Soru 1: Müþteri silindiðinde, bu müþteriye ait tüm sipariþlerin silinmesini saðla.
CREATE TRIGGER Soru1_152120211104
ON sales.customers
AFTER DELETE
AS
BEGIN
	DECLARE @customerID INT

	SELECT @customerID = deleted.customer_id
	FROM deleted

	delete
	from sales.orders
	where sales.orders.customer_id = @customerID
END;


delete 
from sales.customers
where customer_id = 259


-- Soru 2: Bir sipariþ eklenirken, ilgili ürünün stok miktarýný azalt
CREATE TRIGGER Soru2_152120211104
ON sales.orders
AFTER INSERT
AS
BEGIN
	DECLARE @orderID INT
	DECLARE @storeID INT

	SELECT @orderID = inserted.order_id
	FROM inserted

	SELECT @storeID = SS.store_id
	from sales.stores AS SS
	INNER JOIN sales.orders AS SO ON SO.store_id  = SS.store_id
	where SO.order_id = @orderID 

	UPDATE production.stocks
	SET production.stocks.quantity = production.stocks.quantity - 1
	where @storeID = production.stocks.store_id

END;


insert sales.orders(customer_id,order_status, order_date, required_date, store_id,staff_id)
	VALUES(1212, 1, GETDATE(), GETDATE(), 2, 6 )


-- Soru 3: Ürün silindiðinde, bu ürüne ait stok bilgilerinide sil
CREATE TRIGGER Soru3_152120211104
ON sales.orders
AFTER DELETE
AS
BEGIN
	DECLARE @orderID INT
	DECLARE @storeID INT

	SELECT @orderID = deleted.order_id
	FROM deleted

	SELECT @storeID = SS.store_id
	from sales.stores AS SS
	INNER JOIN sales.orders AS SO ON SO.store_id = SS.store_id

	delete
	from production.stocks
	where production.stocks.store_id = @storeID
END;


delete 
from sales.orders
where customer_id = 2


-- Soru 4: Yeni bir ürün eklendiðinde, tüm maðazalarda stok kaydý oluþtur
CREATE TRIGGER Soru4_152120211104
ON production.products
AFTER INSERT
AS 
BEGIN
	DECLARE @productID INT

	SELECT @productID = inserted.product_id
	from inserted

	INSERT INTO production.stocks(store_id, product_id)
	VALUES(1, @productID)

	INSERT INTO production.stocks(store_id, product_id)
	VALUES(2, @productID)

	INSERT INTO production.stocks(store_id, product_id)
	VALUES(3, @productID)
END;


insert into production.products(product_name, brand_id, category_id, model_year, list_price)
	VALUES('deneme', 1, 1, 2024, 500)


-- Soru 5: Kategoriyi silince, silinen kategoriye ait tüm ürünlerin kategori bilgilerini NULL olarak güncelle
CREATE TRIGGER Soru5_152120211104
ON production.categories
AFTER DELETE
AS 
BEGIN
	DECLARE @categoryID INT

	SELECT @categoryID = deleted.category_id
	from deleted

	UPDATE production.products
	SET production.products.category_id = NULL 
	where @categoryID = production.products.category_id
END;

delete
from production.categories
where production.categories.category_id = 1