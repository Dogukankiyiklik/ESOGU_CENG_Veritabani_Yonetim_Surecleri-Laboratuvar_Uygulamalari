CREATE DATABASE KutuphaneBilgiSistemi;
USE KutuphaneBilgiSistemi;

CREATE TABLE Yazarlar (
    YazarID integer PRIMARY KEY,
    Ad varchar(50) NOT NULL,
    Soyad varchar(50) NOT NULL,
    DogumTarihi date,
    Ulke varchar(50)
);

CREATE TABLE Kitaplar (
    KitapID integer PRIMARY KEY,
    KitapAdi varchar(100) NOT NULL,
    ISBN varchar(13) NOT NULL,
    YayinEvi varchar(100),
    BasimTarihi date,
    StokAdeti int,
    YazarID integer,
    CONSTRAINT yazar_kitap FOREIGN KEY (YazarID) REFERENCES Yazarlar(YazarID)
);

CREATE TABLE KutuphaneUyeleri (
    UyeID integer PRIMARY KEY,
    Ad varchar(50) NOT NULL,
    Soyad varchar(50) NOT NULL,
    Telefon varchar(15),
    Adres varchar(255),
);

CREATE TABLE OduncAlinanKitaplar (
    OduncID integer PRIMARY KEY,
    KitapID integer,
    UyeID integer,
    AlisTarihi date,
    TeslimTarihi date,
    CONSTRAINT kitap_odunc FOREIGN KEY (KitapID) REFERENCES Kitaplar(KitapID),
    CONSTRAINT odunc_uye FOREIGN KEY (UyeID) REFERENCES KutuphaneUyeleri(UyeID)
);

SELECT * FROM Yazarlar;
SELECT * FROM Kitaplar;
SELECT * FROM KutuphaneUyeleri;
SELECT * FROM OduncAlinanKitaplar;