-- ============================================================
-- KONU: JOIN PRATIK VERI SETI
-- AMAC: WHERE ile birlestirme, INNER JOIN, LEFT JOIN, RIGHT JOIN
-- ORTAM: MySQL 8.x / MySQL Workbench
-- ============================================================

-- 1. VERITABANINI OLUSTUR
CREATE DATABASE IF NOT EXISTS kitaplik_join_pratik
CHARACTER SET utf8mb4
COLLATE utf8mb4_turkish_ci;

USE kitaplik_join_pratik;

-- 2. TABLOLARI SIFIRLA
DROP TABLE IF EXISTS Kitap3;
DROP TABLE IF EXISTS Kitap2;
DROP TABLE IF EXISTS Kitap;

-- ============================================================
-- 3. ANA TABLO: KITAP
-- ============================================================

CREATE TABLE Kitap (
    KitapNo INT PRIMARY KEY,
    KitapAd VARCHAR(100) NOT NULL,
    KitapYazar VARCHAR(100),
    KitapSayfa SMALLINT,
    KitapFiyat DECIMAL(10,2),
    KitapTarih DATE,
    KitapYayinEvi VARCHAR(50),
    Vergi INT
);

INSERT INTO Kitap
    (KitapNo, KitapAd, KitapYazar, KitapSayfa, KitapFiyat, KitapTarih, KitapYayinEvi, Vergi)
VALUES
    (1,  'Pato',                         'Gogol',             180,  5.00,  '2015-01-08', 'Yildiz',     3),
    (2,  'Son Ada',                      'Zulfu Livaneli',    180, 12.25,  '2015-02-08', 'Yildiz',     4),
    (3,  'Siyah Lale',                   'Alexandre Dumas',   130,  7.35,  '2015-05-05', 'Jupiter',    2),
    (4,  'Beyaz Zambaklar Ulkesinde',    'Grigory Petrov',    180,  5.00,  '2015-04-08', 'Ay',         3),
    (5,  'Eylul',                        'Mehmet Rauf',       130, 10.00,  '2015-04-14', 'Gunes',      2),
    (6,  'Beyaz Geceler',                'Dostoyevski',       130,  5.00,  '2015-09-11', 'Mavi Bulut', 1),
    (7,  'Kucuk Aga',                    'Tarik Bugra',       130,  6.00,  '2015-08-08', 'Ay',         1),
    (8,  'Insan Ne Ile Yasar',           'Tolstoy',           110,  6.85,  '2015-12-09', 'Venus',      4),
    (9,  'Sefiller',                     'Victor Hugo',       850, 25.00,  '2015-12-08', 'Mavi Bulut', 7),
    (10, 'Calikusu',                     'Resat Nuri Guntekin',420, 14.00, '2015-06-11', 'Merkur',     2),
    (11, 'Vadideki Zambak',              'Honore de Balzac',  320, 13.05,  '2015-10-17', 'Venus',      2),
    (12, 'Safahat',                      'Mehmet Akif Ersoy', 640, 11.00,  '2016-08-08', 'Mavi Bulut', 5);

-- ============================================================
-- 4. IKINCI TABLO: KITAP2
-- ============================================================

CREATE TABLE Kitap2 (
    KitapAdi VARCHAR(100) PRIMARY KEY,
    KitapTur VARCHAR(50),
    KitapOzet VARCHAR(100),
    KitapRenk VARCHAR(30)
);

INSERT INTO Kitap2
    (KitapAdi, KitapTur, KitapOzet, KitapRenk)
VALUES
    ('Calikusu',                      'roman',   'deneme',   'mavi'),
    ('Beyaz Geceler',                 'hikaye',  'abc def',  'mavi'),
    ('Insan Ne Ile Yasar',            'roman',   'aaaaa',    'yesil'),
    ('Siyah Lale',                    'roman',   'bbbb',     'turuncu'),
    ('Son Ada',                       'tiyatro', 'ddddd',    'sari'),
    ('Kucuk Aga',                     'roman',   'fffff',    'mavi'),
    ('Vadideki Zambak',               'roman',   'dfdfvg',   'mavi'),
    ('Safahat',                       'siir',    'ffvvvv',   'yesil'),
    ('Beyaz Zambaklar Ulkesinde',     'roman',   'ggggg',    'beyaz'),
    ('Eylul',                         'roman',   'hhhhh',    'kirmizi'),
    ('Pato',                          'hikaye',  'iiiii',    'siyah');

-- ============================================================
-- 5. UCUNCU TABLO: KITAP3
-- ============================================================

CREATE TABLE Kitap3 (
    KitapRengi VARCHAR(30) PRIMARY KEY,
    KitapBaski INT
);

INSERT INTO Kitap3
    (KitapRengi, KitapBaski)
VALUES
    ('yesil',    3),
    ('turuncu',  4),
    ('beyaz',    8),
    ('kirmizi',  2),
    ('sari',     5),
    ('siyah',    6);

-- ============================================================
-- 6. KONTROL SORGULARI
-- ============================================================

SELECT * FROM Kitap;
SELECT * FROM Kitap2;
SELECT * FROM Kitap3;

-- ============================================================
-- 7. JOIN CALISMALARI ICIN HAZIR ORNEKLER
-- ============================================================

-- A) WHERE ile iki tablo birlestirme
SELECT
    Kitap.KitapNo,
    Kitap.KitapAd,
    Kitap.KitapYazar,
    Kitap2.KitapTur,
    Kitap2.KitapRenk
FROM Kitap, Kitap2
WHERE Kitap.KitapAd = Kitap2.KitapAdi;

-- B) INNER JOIN ile ayni sorgu
SELECT
    K.KitapNo,
    K.KitapAd,
    K.KitapYazar,
    K2.KitapTur,
    K2.KitapRenk
FROM Kitap AS K
INNER JOIN Kitap2 AS K2
    ON K.KitapAd = K2.KitapAdi;

-- C) 3 tabloyu WHERE ile birlestirme
SELECT
    K.KitapAd,
    K.KitapYazar,
    K2.KitapTur,
    K2.KitapRenk,
    K3.KitapBaski
FROM Kitap AS K, Kitap2 AS K2, Kitap3 AS K3
WHERE K.KitapAd = K2.KitapAdi
  AND K2.KitapRenk = K3.KitapRengi;

-- D) 3 tabloyu INNER JOIN ile birlestirme
SELECT
    K.KitapAd,
    K.KitapYazar,
    K2.KitapTur,
    K2.KitapRenk,
    K3.KitapBaski
FROM Kitap AS K
INNER JOIN Kitap2 AS K2
    ON K.KitapAd = K2.KitapAdi
INNER JOIN Kitap3 AS K3
    ON K2.KitapRenk = K3.KitapRengi;

-- E) LEFT JOIN ornegi
SELECT
    K.KitapAd,
    K2.KitapTur,
    K2.KitapRenk
FROM Kitap AS K
LEFT JOIN Kitap2 AS K2
    ON K.KitapAd = K2.KitapAdi;

-- F) RIGHT JOIN mantigini gostermek icin
SELECT
    K.KitapAd,
    K2.KitapTur,
    K2.KitapRenk
FROM Kitap AS K
RIGHT JOIN Kitap2 AS K2
    ON K.KitapAd = K2.KitapAdi;
