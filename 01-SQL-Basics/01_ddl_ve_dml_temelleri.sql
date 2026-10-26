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
-- SENARYO DENEMESİ:
-- 1. Tabloya test için geçici bir kayıt ekleyelim:
INSERT INTO PersonelBilgi (PersonelNumara, PersonelAd, PersonelSoyad, PersonelSehir)
VALUES ('99', 'Geçici', 'Kayıt', 'Ankara');

-- 2. Kaydın eklendiğini teyit edelim:
SELECT * FROM PersonelBilgi;

-- 3. TRUNCATE komutu ile tablo verilerini sıfırlayalım:
-- Tablonun fiziksel yapısı (şeması, kısıtları, sütunları) korunur; içindeki tüm satırlar boşaltılır.
TRUNCATE TABLE PersonelBilgi;

-- 4. Doğrulama: Tablo boş dönmeli ancak DESCRIBE tablonun sağlam kaldığını göstermelidir.
SELECT * FROM PersonelBilgi;
DESCRIBE PersonelBilgi;


-- ------------------------------------------------------------------------------
-- MÜHENDİSLİK NOTU: TRUNCATE TABLE vs DELETE FROM KARŞILAŞTIRMASI
-- ------------------------------------------------------------------------------
-- 1. DDL (TRUNCATE) vs DML (DELETE):
--    - DELETE bir DML komutudur; veritabanı motoru her bir satırı tek tek tarar,
--      satır kilidi (row-level lock) koyar ve siler. Milyonlarca satırda sistemi kilitler.
--    - TRUNCATE bir DDL komutudur; satırları tek tek silmez, tablonun bağlı olduğu veri
--      sayfalarını doğrudan bellekten boşa çıkarır. 10 milyon kayıt bile saniyeler içinde sıfırlanır.
--
-- 2. LOGLAMA (TRANSACTION LOG) VE GERİ ALINABİLİRLİK (ROLLBACK):
--    - DELETE her silinen satır için işlem günlüğü (Undo/Redo log) üretir; geri döndürülebilir.
--    - TRUNCATE satır bazlı günlük tutmaz; bu sayede disk I/O yükü sıfıra yakındır ancak
--      üretim (production) ortamında kazayla çalıştırılırsa geri dönüşü yoktur.
--
-- 3. SAYACIN SIFIRLANMASI (AUTO_INCREMENT RESET):
--    - DELETE ile tüm tabloyu silseniz bile otomatik artan ID sayacı sıfırlanmaz; kaldığı
--      en son değerden (örn: 501'den) devam eder.
--    - TRUNCATE tablonun kimlik sayacını varsayılana çeker; eklenecek ilk kayıt tekrar 1'den başlar.
--
-- 4. ŞARTLI SİLME (WHERE CLAUSE):
--    - DELETE FROM Tablo WHERE id = 5; şeklinde filtrelenebilir.
--    - TRUNCATE komutunda 'WHERE' şartı KULLANILAMAZ; işlem her zaman tüm tabloyu hedefler.
--
-- 5. BÜTÜNLÜK KISITLARI (FOREIGN KEY ENGELİ):
--    - Başka bir tabloya FOREIGN KEY ile referans veren veya referans edilen tablolarda
--      veri bütünlüğünü (Referential Integrity) korumak adına MySQL doğrudan TRUNCATE izni vermez.

















































