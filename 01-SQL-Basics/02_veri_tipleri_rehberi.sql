-- =============================================================================
-- KONU: SQL Veri Tipleri ve MySQL Karşılıkları
-- REFERANS: Murat Yücedağ Ders 2 ve 3 (Veri Tipleri 1 - 2)
-- =============================================================================

USE lab_db;

-- 1. TEMEL VERİ TİPLERİ DENEMESİ
DROP TABLE IF EXISTS VeriTipleriDeneme;

CREATE TABLE VeriTipleriDeneme (
    Sayi BIGINT,                -- 8 byte büyük tam sayı (Trilyonluk değerler için).
    ikiliDeger BINARY(50),      -- Sabit 50 byte ikili (raw binary/hash) veri tutar.
    MedeniDurum BOOLEAN,        -- MSSQL'deki 'bit' karşılığı; Mantıksal 1 veya 0 (True/False).
    TCNo CHAR(11),              -- Sabit uzunluklu metin; her zaman 11 karakter yer ayırır.
    Tarih DATE,                 -- Sadece tarih bilgisi tutar (YYYY-MM-DD).
    Tarih2 DATETIME,            -- Tarih ve saat birlikte (YYYY-MM-DD HH:MM:SS).
    Tarih22 DATETIME(6),        -- Mikrosaniye hassasiyetli log zamanı.
    Tarih3 TIMESTAMP,           -- Saat dilimine (UTC) duyarlı zaman damgası.
    Toplam DECIMAL(18, 0),      -- Küsüratsız ama çok büyük kesin sayı alanı.
    Toplam2 FLOAT NOT NULL      -- Kayan noktalı sayı; NOT NULL olduğu için boş bırakılamaz.
);


-- 2. İLERİ SEVİYE VERİ TİPLERİ VE MÜHENDİSLİK DÖNÜŞÜMLERİ
DROP TABLE IF EXISTS VeriTipleriIleri;

CREATE TABLE VeriTipleriIleri (
    GeometrikDeger GEOMETRY,    -- Harita koordinatları, enlem-boylam (GIS) saklar.
    ResimYolu VARCHAR(255),     -- MSSQL 'image' yerine; DB'ye resim değil dosya yolu yazılır.
    Sayi INT NOT NULL,          -- 4 byte standart tam sayı (-2 milyar / +2 milyar).
    ParaBirimi DECIMAL(19, 4),  -- MSSQL 'money' yerine; yüksek hacimli finansal değerler.
    Para2 DECIMAL(10, 2),       -- MSSQL 'smallmoney' yerine; kuruşlu standart bakiye (örn: 1250.50 TL).
    Adiniz CHAR(10),            -- MSSQL 'nchar(10)' karşılığı; sabit 10 karakter.
    Islem NUMERIC(18, 0),       -- DECIMAL ile eşdeğerdir; 18 basamağa kadar tam sayı tutar.
    Bilgiler LONGTEXT,          -- MSSQL 'nvarchar(MAX)' yerine; 4 GB'a kadar devasa metin saklar.
    Sayilar FLOAT,              -- MSSQL 'real' karşılığı; 4 byte ondalıklı sayı.
    TarihSaat DATETIME,         -- MSSQL 'smalldatetime' yerine; standart tarih ve saat.
    KucukSayi SMALLINT,         -- 2 byte tam sayı (-32.768 ile +32.767 arası).
    KucukSayilar TINYINT,       -- 1 byte tam sayı (0-255 arası; durum/bayrak kodları için).
    Saat TIME,                  -- Tarihsiz sadece saat tutar (HH:MM:SS).
    GuidDegeri CHAR(36),        -- MSSQL 'uniqueidentifier' karşılığı; 36 karakterlik benzersiz UUID.
    Metin VARCHAR(50)           -- En fazla 50 karakter alabilen değişken metin alanı.
);
