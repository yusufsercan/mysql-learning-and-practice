-- ==============================================================================
-- KONU: ALTER TABLE ile Tablo Yapısını Değiştirme (Sütun Ekleme, Silme, Güncelleme)
-- REFERANS: Murat Yücedağ SQL Dersleri (Ders 5 & 6)
-- ORTAM: MySQL Workbench / MySQL 8.0
-- ==============================================================================

USE lab_db;

-- 1. ÖRNEK TABLO OLUŞTURMA
DROP TABLE IF EXISTS Ogrenci;

CREATE TABLE Ogrenci (
    OgrNumara VARCHAR(8) PRIMARY KEY,
    OgrAd VARCHAR(15) NOT NULL,
    OgrSoyad VARCHAR(20) NOT NULL,
    OgrTC CHAR(11) NOT NULL,
    OgrBilgi TEXT
);

-- Test için örnek bir kayıt ekleyelim:
INSERT INTO Ogrenci (OgrNumara, OgrAd, OgrSoyad, OgrTC, OgrBilgi)
VALUES ('101', 'Yusuf', 'İşçi', '12345678901', 'Yazılım Mühendisliği Öğrencisi');

SELECT * FROM Ogrenci;


-- 2. ALTER TABLE - TEK BİR SÜTUN EKLEME (ADD)
-- Tabloya 'notlar' adında 1 byte'lık (0-255 arası) tam sayı alanı ekliyoruz:
ALTER TABLE Ogrenci ADD notlar TINYINT;

-- Tabloya veli adı için değişken metin alanı ekliyoruz:
ALTER TABLE Ogrenci ADD veli VARCHAR(30);


-- 3. ALTER TABLE - ÇOKLU SÜTUN EKLEME (MSSQL vs MySQL Farkı)
-- MSSQL: alter table ogr add BaslamaTarih smalldatetime, OgrMahalle varchar(40)
-- MySQL: 'smalldatetime' tipi yoktur (DATETIME kullanılır). Çoklu kolonlar parantez içine alınır.
ALTER TABLE Ogrenci ADD (
    BaslamaTarih DATETIME,
    OgrMahalle VARCHAR(40)
);


-- 4. ALTER TABLE - SÜTUN SİLME (DROP COLUMN)
-- Tablodan tek bir sütunu kalıcı olarak kaldırma:
ALTER TABLE Ogrenci DROP COLUMN BaslamaTarih;

-- Birden fazla sütunu tek sorguda silme:
ALTER TABLE Ogrenci 
    DROP COLUMN OgrMahalle,
    DROP COLUMN veli;


-- 5. MÜHENDİSLİK NOTLARI:
-- 1. DROP COLUMN komutunun geri dönüşü yoktur; o sütundaki tüm mevcut veriler silinir.
-- 2. Üzerinde FOREIGN KEY veya UNIQUE kısıtı olan sütunlar kısıt kaldırılmadan silinemez.
-- 3. Tablodaki son kalan tek sütun DROP COLUMN ile silinemez; tabloyu DROP TABLE ile silmek gerekir.

-- Tablonun son yapısını ve verilerini doğrulayalım:
-- 6. TABLO MİMARİSİNİ DOĞRULAMA (DESCRIBE / DESC)
-- NOT: 'SELECT * FROM Ogrenci' tablodaki verileri (satırları) getirirken;
-- 'DESCRIBE Ogrenci' tablonun teknik röntgenini çeker.
-- Kolon isimleri, veri tipleri, NULL izinleri, PRIMARY KEY ve varsayılan (DEFAULT) değerleri 
-- doğrulamak için mimari değişikliklerden (ALTER TABLE) sonra mutlaka çalıştırılır.
DESCRIBE Ogrenci;

-- Tablodaki mevcut verileri kontrol etme:
SELECT * FROM Ogrenci;


-- 7. MÜHENDİSLİK NOTLARI:
-- 1. DROP COLUMN komutunun geri dönüşü yoktur; o sütundaki tüm mevcut veriler silinir.
-- 2. Üzerinde FOREIGN KEY veya UNIQUE kısıtı olan sütunlar kısıt kaldırılmadan silinemez.
-- 3. Tablodaki son kalan tek sütun DROP COLUMN ile silinemez; tabloyu DROP TABLE ile silmek gerekir.
-- 4. Mimari incelemelerde DESCRIBE komutu SELECT'e kıyasla kısıtları (Constraints) doğrudan gösterdiği için tercih edilir.
