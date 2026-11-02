
-- ============================================================
-- KONU: DDL, DML ve Temel SELECT Islemleri
-- KAYNAK: Murat Yucedag SQL Dersleri
-- ORTAM: MySQL 8.x / MySQL Workbench
-- ============================================================

-- 1. VERITABANI OLUSTURMA VE SECME

CREATE DATABASE IF NOT EXISTS lab_db;
USE lab_db;

-- CREATE DATABASE: Veritabani olusturur.
-- IF NOT EXISTS: Veritabani varsa hata verilmesini onler.
-- USE: Sonraki islemlerin yapilacagi veritabanini secer.


-- 2. DDL: TABLO OLUSTURMA

-- UYARI: Asagidaki DROP TABLE mevcut tabloyu ve
-- icindeki tum kayitlari siler. Sadece test ortaminda
-- ve ornekleri sifirdan denemek icin kullanilmalidir.

DROP TABLE IF EXISTS PersonelBilgi;

CREATE TABLE PersonelBilgi (
    PersonelNumara VARCHAR(5) PRIMARY KEY,
    PersonelAd VARCHAR(20) NOT NULL,
    PersonelSoyad VARCHAR(30) NOT NULL,
    PersonelSehir VARCHAR(15) NOT NULL
);

-- PRIMARY KEY: Benzersiz ve NULL olamayan anahtar.
-- NOT NULL: Sutuna NULL degeri girilmesini engeller.
-- VARCHAR(n): En fazla n karakterlik degisken metin.
-- Son sutundan sonra virgul konulmaz.

DESCRIBE PersonelBilgi;


-- 3. DML: TEK SATIR VERI EKLEME

INSERT INTO PersonelBilgi
    (PersonelNumara, PersonelAd, PersonelSoyad, PersonelSehir)
VALUES
    ('1', 'Baran', 'Yucedag', 'Bursa');


-- 4. DML: BIRDEN FAZLA SATIR EKLEME

INSERT INTO PersonelBilgi
    (PersonelNumara, PersonelAd, PersonelSoyad, PersonelSehir)
VALUES
    ('2', 'Baran', 'Kara', 'Istanbul'),
    ('12', 'Oktay', 'Ak', 'Trabzon');

-- Ayni PRIMARY KEY tekrar eklenirse
-- Error 1062: Duplicate entry hatasi olusur.

-- HATA DENEMESI (istege bagli):
-- INSERT INTO PersonelBilgi
-- VALUES ('1', 'Ali', 'Yilmaz', 'Ankara');


-- 5. DQL: SELECT ILE VERI SORGULAMA

SELECT * FROM PersonelBilgi;

-- SELECT: Verileri sorgular.
-- * : Tum sutunlari secer.
-- FROM: Verilerin alinacagi tabloyu belirtir.

SELECT PersonelAd, PersonelSoyad
FROM PersonelBilgi;

-- Yalnizca istenilen iki sutunu listeler.


-- 6. TRUNCATE TABLE (ISTEGE BAGLI TEST)

-- UYARI: Bu komut tablodaki TUM satirlari siler.
-- Asagidaki komutlar bilerek yorum satirina alindi.
-- Denemek istediginde yalnizca gerekli satirlari calistir.

-- TRUNCATE TABLE PersonelBilgi;

-- TRUNCATE sonrasi tablo bosalir:
-- SELECT * FROM PersonelBilgi;

-- Ancak tablo yapisi korunur:
-- DESCRIBE PersonelBilgi;


/*
============================================================
KONU TEKRARI: DDL, DML, DQL VE TABLO ISLEMLERI
============================================================

1. DDL (DATA DEFINITION LANGUAGE)
   Veritabani nesnelerinin yapisini tanimlar veya degistirir.

   CREATE DATABASE : Veritabani olusturur.
   CREATE TABLE    : Yeni tablo olusturur.
   ALTER TABLE     : Tablo yapisini degistirir.
   DROP TABLE      : Tabloyu yapisiyla birlikte siler.
   TRUNCATE TABLE  : Tabloyu bosaltir, semasini korur.

2. DML (DATA MANIPULATION LANGUAGE)
   Veriler uzerinde degisiklik yapar.

   INSERT : Yeni kayit ekler.
   UPDATE : Mevcut kayitlari gunceller.
   DELETE : Kayitlari siler.

   NOT: UPDATE ve DELETE sonraki derslerde
   ayrintili olarak calisilacaktir.

3. DQL (DATA QUERY LANGUAGE)
   SELECT, verileri sorgulamak icin kullanilir.
   SELECT genellikle DQL olarak siniflandirilir;
   bazi kaynaklarda DML kapsaminda da ele alinir.

4. PRIMARY KEY VE NOT NULL

   PRIMARY KEY:
   - Her satiri benzersiz tanimlar.
   - Tekrar eden deger kabul etmez.
   - NULL kabul etmez.
   - Bir tabloda bir PRIMARY KEY kisiti bulunur.
   - Bu anahtar birden fazla sutundan olusabilir.

   NOT NULL:
   - NULL deger girilmesini engeller.
   - Tek basina benzersizlik saglamaz.
   - NULL ile bos metin ('') ayni sey degildir.

5. INSERT INTO

   Genel kullanim:

   INSERT INTO Tablo (Sutun1, Sutun2)
   VALUES (Deger1, Deger2);

   Birden fazla kayit:

   INSERT INTO Tablo (Sutun1, Sutun2)
   VALUES
       (Deger1, Deger2),
       (Deger3, Deger4);

   Sutun sirasi ile deger sirasi eslesmelidir.

6. SELECT

   SELECT * FROM Tablo;

   Tum sutunlari getirir.

   SELECT Sutun1, Sutun2 FROM Tablo;

   Yalnizca belirtilen sutunlari getirir.

   SELECT verileri degistirmez.

7. DROP, DELETE VE TRUNCATE FARKLARI

   DROP TABLE:
   - Tabloyu ve kayitlarini siler.
   - Tablo yapisi da ortadan kalkar.

   DELETE FROM:
   - Kayitlari siler, tablo yapisi kalir.
   - WHERE ile belirli satirlar secilebilir.
   - Uygun transaction icinde geri alinabilir.

   TRUNCATE TABLE:
   - Tabloyu tamamen bosaltir.
   - WHERE kullanilamaz.
   - MySQL'de DDL komutudur.
   - Implicit COMMIT gerceklestirir.
   - Normal ROLLBACK ile geri alinamaz.
   - AUTO_INCREMENT sayacini sifirlar.
   - ON DELETE tetikleyicilerini calistirmaz.
   - Baska tablonun FOREIGN KEY ile referans
     verdigi InnoDB tablolarinda engellenebilir.

   DELETE genellikle satir bazli silme yaparken,
   TRUNCATE tabloyu bosaltmak icin farkli ve
   genellikle daha hizli bir mekanizma kullanir.
   Performans her durumda ayni degildir.

8. SIK KARSILASILAN HATALAR

   Error 1064:
   - SQL sozdizimi hatasi.
   - Fazladan virgul, eksik parantez vb.

   Error 1062:
   - PRIMARY KEY veya UNIQUE deger tekrari.

   Error 1046:
   - Aktif veritabani secilmemesi.

   Error 1050:
   - Olusturulmaya calisilan tablonun zaten var olmasi.

9. SINAVDA HATIRLA

   CREATE TABLE -> Tablo olusturur.
   DROP TABLE   -> Tabloyu tamamen siler.
   TRUNCATE     -> Tum satirlari temizler.
   INSERT INTO  -> Veri ekler.
   SELECT       -> Veri sorgular.
   DESCRIBE     -> Sutun yapisini gosterir.

   DDL genellikle tablo yapisiyla,
   DML ise kayitlar uzerindeki degisikliklerle ilgilidir.

============================================================
*/

















































