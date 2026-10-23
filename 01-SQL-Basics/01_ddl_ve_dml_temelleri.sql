-- =============================================================================
-- KONU: DDL (Tablo Oluşturma) ve DML (Veri Ekleme, Listeleme, Sıfırlama)
-- REFERANS: Murat Yücedağ SQL Dersleri (MSSQL'den MySQL Standartlarına Çeviri)
-- ORTAM: MySQL Workbench / MySQL 8.0
-- =============================================================================

-- 1. VERİTABANI OLUŞTURMA VE SEÇME
-- Eğer yoksa veritabanını oluşturur ve aktif çalışma alanı olarak seçer.
CREATE DATABASE IF NOT EXISTS lab_db;
USE lab_db;


-- 2. DDL: TABLO TANIMLAMA (PRIMARY KEY VE ZORUNLULUK KISITLARI)
-- Eğer tablo önceden varsa sıfırdan oluşturmak için eskiyi siler.
DROP TABLE IF EXISTS PersonelBilgi;

CREATE TABLE PersonelBilgi (
    PersonelNumara VARCHAR(5) PRIMARY KEY, -- Benzersiz anahtar (PK): Tekrar edemez, NULL olamaz.
    PersonelAd VARCHAR(20) NOT NULL,       -- Boş geçilemez zorunlu alan.
    PersonelSoyad VARCHAR(30) NOT NULL,    -- Boş geçilemez zorunlu alan.
    PersonelSehir VARCHAR(15) NOT NULL     -- DİKKAT: Son sütundan sonra virgül konmaz (Hata 1064 almamak için).
);


-- 3. DML: VERİ EKLEME (INSERT) İŞLEMLERİ

-- A) Tek Satır Veri Ekleme:
INSERT INTO PersonelBilgi (PersonelNumara, PersonelAd, PersonelSoyad, PersonelSehir)
VALUES ('1', 'Baran', 'Yücedağ', 'Bursa');

-- B) Çoklu (Toplu) Veri Ekleme:
-- NOT: '1' numaralı kayıt yukarıda eklendiği için tekrar '1' eklenirse 
-- "Error Code: 1062. Duplicate entry for key PRIMARY" hatası döner.
-- Bu yüzden yeni kayıtlara '2' ve '12' gibi farklı numaralar verildi.
INSERT INTO PersonelBilgi (PersonelNumara, PersonelAd, PersonelSoyad, PersonelSehir)
VALUES 
    ('2', 'Baran', 'Kara', 'İstanbul'),
    ('12', 'Oktay', 'Ak', 'Trabzon');


-- 4. DQL: VERİLERİ SORGULAMA VE LİSTELEME
-- Tablodaki tüm sütunları (*) ve tüm kayıtları ekrana getirir.
SELECT * FROM PersonelBilgi;


-- 5. TABLO BAKIMI VE SIFIRLAMA
-- TRUNCATE komutu: Tablonun şemasını silmez, içindeki tüm verileri tek hamlede temizler.
-- TRUNCATE TABLE PersonelBilgi;
