
-- ============================================================
-- KONU: ALTER TABLE ve Tablo Yapisi Degisiklikleri
-- KAYNAK: Murat Yucedag SQL Dersleri 5-6
-- ORTAM: MySQL 8.x / MySQL Workbench
-- ============================================================

CREATE DATABASE IF NOT EXISTS lab_db;
USE lab_db;


-- 1. ORNEK TABLO OLUSTURMA

-- UYARI: Bu komut mevcut Ogrenci tablosunu siler.
-- Sadece test veritabani icin kullanilmalidir.

DROP TABLE IF EXISTS Ogrenci;

CREATE TABLE Ogrenci (
    OgrNumara VARCHAR(8) PRIMARY KEY,
    OgrAd VARCHAR(15) NOT NULL,
    OgrSoyad VARCHAR(20) NOT NULL,
    OgrTC CHAR(11) NOT NULL,
    OgrBilgi TEXT
);

INSERT INTO Ogrenci
    (OgrNumara, OgrAd, OgrSoyad, OgrTC, OgrBilgi)
VALUES
    ('101', 'Yusuf', 'Isci', '12345678901',
     'Yazilim Muhendisligi Ogrencisi');

SELECT * FROM Ogrenci;
DESCRIBE Ogrenci;


-- 2. TEK SUTUN EKLEME (ADD COLUMN)

ALTER TABLE Ogrenci
ADD COLUMN notlar TINYINT UNSIGNED;

-- 0 ile 255 arasinda tam sayi saklayabilir.
-- Bu aralik ogrenci notunu 0-100 ile sinirlamaz.

ALTER TABLE Ogrenci
ADD COLUMN veli VARCHAR(30);

-- VARCHAR(30): En fazla 30 karakter.

DESCRIBE Ogrenci;


-- 3. BIRDEN FAZLA SUTUN EKLEME

ALTER TABLE Ogrenci ADD (
    BaslamaTarih DATETIME,
    OgrMahalle VARCHAR(40)
);

-- MySQL'de ADD (...) sozdizimi gecerlidir.
-- Alternatif kullanim:
--
-- ALTER TABLE Ogrenci
--     ADD COLUMN BaslamaTarih DATETIME,
--     ADD COLUMN OgrMahalle VARCHAR(40);

DESCRIBE Ogrenci;


-- 4. TEK SUTUN SILME

ALTER TABLE Ogrenci
DROP COLUMN BaslamaTarih;

-- Sutun ve icindeki veriler tablodan kaldirilir.


-- 5. BIRDEN FAZLA SUTUN SILME

ALTER TABLE Ogrenci
    DROP COLUMN OgrMahalle,
    DROP COLUMN veli;


-- 6. SON TABLO YAPISINI KONTROL ETME

DESCRIBE Ogrenci;

-- Tablonun tam olusturma tanimini gosterir.
SHOW CREATE TABLE Ogrenci;

-- Mevcut kayitlari listeler.
SELECT * FROM Ogrenci;


/*
============================================================
KONU TEKRARI: ALTER TABLE
============================================================

1. ALTER TABLE NEDIR?

   Mevcut bir tablonun yapisini degistirmek
   icin kullanilan DDL komutudur.

   Tabloyu yeniden olusturmadan sutun ekleme,
   silme ve bazi sutun ozelliklerini
   degistirme islemleri yapilabilir.

2. ADD COLUMN

   Genel kullanim:

   ALTER TABLE Tablo
   ADD COLUMN YeniSutun VARCHAR(20);

   Birden fazla sutun:

   ALTER TABLE Tablo ADD (
       Sutun1 INT,
       Sutun2 VARCHAR(30)
   );

   Alternatif:

   ALTER TABLE Tablo
       ADD COLUMN Sutun1 INT,
       ADD COLUMN Sutun2 VARCHAR(30);

3. DROP COLUMN

   Genel kullanim:

   ALTER TABLE Tablo
   DROP COLUMN SutunAdi;

   Birden fazla sutun:

   ALTER TABLE Tablo
       DROP COLUMN Sutun1,
       DROP COLUMN Sutun2;

   Dikkat:
   Silinen sutundaki veriler kaybolur.
   Index ve constraint bagimliliklari
   islemin yapilmasini etkileyebilir.

4. DESCRIBE

   DESCRIBE Tablo;

   Sutunlarin veri tipini, NULL durumunu,
   anahtar bilgisini ve varsayilan degerini
   ozet olarak gosterir.

   DESC Tablo;
   ayni amacla kullanilabilir.

5. SHOW CREATE TABLE

   SHOW CREATE TABLE Tablo;

   Tablonun olusturma SQL tanimini gosterir.
   Constraint ve index ayrintilarini
   incelemek icin kullanilabilir.

6. DDL VE TRANSACTION

   ALTER TABLE MySQL'de genellikle
   implicit COMMIT olusturur.

   Yapilan degisiklikler normal bir
   ROLLBACK ile geri alinamaz.

   Bu nedenle yapisal degisikliklerden once
   veri kaybi riski kontrol edilmelidir.

7. PRIMARY KEY / UNIQUE / FOREIGN KEY

   Bu kisitlarla iliskili sutunlarda
   yapisal degisiklikler ek kontroller
   gerektirebilir.

   Sutun silinmesi indexleri etkileyebilir.
   Her durumda once constraint yapisi
   incelenmelidir.

8. SINAVDA HATIRLA

   CREATE TABLE  -> Yeni tablo olusturur.
   ALTER TABLE   -> Mevcut tabloyu degistirir.
   ADD COLUMN    -> Sutun ekler.
   DROP COLUMN   -> Sutun siler.
   DESCRIBE      -> Tablo yapisini ozetler.
   SHOW CREATE   -> Tablo tanimini gosterir.

   SELECT * FROM Tablo;
   -> Kayitlari listeler.

   DESCRIBE Tablo;
   -> Sutun ozelliklerini listeler.

============================================================
*/

