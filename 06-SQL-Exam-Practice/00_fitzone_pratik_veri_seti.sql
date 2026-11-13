- ============================================================================
-- 00 | FITZONE: VYS SINAVINA YONELIK ORNEK VERI SETI
-- MySQL 8.x / MySQL Workbench
-- ============================================================================
-- AMAÇ: JOIN, GROUP BY, HAVING, WHERE ve sonuç tablosu tahmini için herkesin
-- aynı kayıtlar üzerinden çalışmasını sağlamak. Bu dosyada önce tablo
-- oluşturma kurallarını, sonra eklenen verilerin anlamını öğreniyoruz.
--
-- DİKKAT: Aşağıdaki DROP TABLE komutları yalnızca vys_vize_gun4 adlı pratik
-- veritabanındaki Uye, Egitmen, Ders ve Kayit tablolarını sıfırlar.
-- Daha önce bu tabloların içine eklediğin çalışma verileri varsa silinir.
-- Kendi proje veya okul veritabanlarında bu dosyayı çalıştırma.
-- ============================================================================

CREATE DATABASE IF NOT EXISTS vys_vize_gun4
    CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE vys_vize_gun4;

-- SORU 1: Veri tabanında hangi varlıklar bulunmalı, tabloları nasıl bağlarız?
-- YAKLAŞIM: Üye ve Ders arasında N:M ilişki vardır; bu nedenle Kayit adlı ara
-- tablo kullanılır. Her Ders tam olarak bir Egitmen'e bağlı olduğundan
-- egitmenNo yabancı anahtarı Ders tablosunda bulunur.
-- ÖNEMLİ NOT: PK bir satırı benzersiz tanımlar; FK başka bir tablonun
-- anahtarına referans verir. Aynı sütun hem bileşik PK parçası hem FK olabilir.

-- Çocuk tablolardan başlamak FK bağımlılıklarına bağlı DROP hatalarını önler.
DROP TABLE IF EXISTS Kayit;
DROP TABLE IF EXISTS Ders;
DROP TABLE IF EXISTS Egitmen;
DROP TABLE IF EXISTS Uye;

CREATE TABLE Uye (
    uyeNo INT PRIMARY KEY,
    ad VARCHAR(60) NOT NULL,
    sehir VARCHAR(40) NOT NULL
);

CREATE TABLE Egitmen (
    egitmenNo VARCHAR(3) PRIMARY KEY,
    ad VARCHAR(50) NOT NULL
);

CREATE TABLE Ders (
    dersNo VARCHAR(3) PRIMARY KEY,
    ad VARCHAR(50) NOT NULL,
    ucret INT NOT NULL,
    egitmenNo VARCHAR(3) NOT NULL,
    CONSTRAINT fk_ders_egitmen FOREIGN KEY (egitmenNo)
        REFERENCES Egitmen(egitmenNo)
);

CREATE TABLE Kayit (
    uyeNo INT NOT NULL,
    dersNo VARCHAR(3) NOT NULL,
    tarih DATE NOT NULL,
    PRIMARY KEY (uyeNo, dersNo),
    CONSTRAINT fk_kayit_uye FOREIGN KEY (uyeNo) REFERENCES Uye(uyeNo),
    CONSTRAINT fk_kayit_ders FOREIGN KEY (dersNo) REFERENCES Ders(dersNo)
);

-- NOT: (uyeNo, dersNo) bileşik PK seçimi, bir üyenin aynı derse yalnızca
-- bir kez kayıt olabildiğini varsayar. Farklı dönemlerde aynı derse yeniden
-- kayıt olacaksa kayıt kimliği veya dönem bilgisini de modellemek gerekebilir.

-- SORU 2: Sorgu sonuçlarımızı nasıl tahmin edeceğiz?
-- YAKLAŞIM: Önce veri setindeki satırları tanı. Duru Ak'ın hiç ders kaydı yok;
-- Ali Kaya ve Can Öz ikişer derse kayıtlı. Pilates'e Ali ve Can kayıtlı.

INSERT INTO Uye (uyeNo, ad, sehir) VALUES
(1, 'Ali Kaya', 'Trabzon'),
(2, 'Buse Can', 'Rize'),
(3, 'Can Öz', 'Trabzon'),
(4, 'Duru Ak', 'Giresun');

INSERT INTO Egitmen (egitmenNo, ad) VALUES
('E1', 'Mert'),
('E2', 'Nil');

INSERT INTO Ders (dersNo, ad, ucret, egitmenNo) VALUES
('D1', 'Pilates', 300, 'E1'),
('D2', 'Yoga', 250, 'E2'),
('D3', 'Crossfit', 400, 'E1'),
('D4', 'Yüzme', 150, 'E2');

INSERT INTO Kayit (uyeNo, dersNo, tarih) VALUES
(1, 'D1', '2026-09-01'),
(1, 'D3', '2026-09-05'),
(2, 'D2', '2026-09-02'),
(3, 'D1', '2026-09-03'),
(3, 'D4', '2026-09-03');

-- SORU 3: Kurulumun doğru olup olmadığını nasıl denetleriz?
-- ÇÖZÜM: Önce tüm satırları incele, sonra COUNT ile beklenen kayıt sayılarını
-- doğrula. Bu kontrol, JOIN sonuçlarında kendi hatan ile veri hatasını ayırır.
SELECT * FROM Uye ORDER BY uyeNo;
SELECT * FROM Egitmen ORDER BY egitmenNo;
SELECT * FROM Ders ORDER BY dersNo;
SELECT * FROM Kayit ORDER BY uyeNo, dersNo;

SELECT 'Uye' AS Tablo, COUNT(*) AS KayitSayisi FROM Uye
UNION ALL SELECT 'Egitmen', COUNT(*) FROM Egitmen
UNION ALL SELECT 'Ders', COUNT(*) FROM Ders
UNION ALL SELECT 'Kayit', COUNT(*) FROM Kayit;

-- Beklenen tablo: Uye=4, Egitmen=2, Ders=4, Kayit=5.
-- UNION ALL, yukarıdaki dört özet satırını birleştirir; tekrarları kaldırmaz.

-- SORU 4: Gerçek ilişkiyi gözümüzle görmek için nasıl bir kontrol yazabiliriz?
-- ÇÖZÜM: Önce Uye ile Kayit eşleştir, sonra Kayit ile Ders'i eşleştir.
SELECT u.ad AS UyeAdi, k.dersNo AS DersNo, d.ad AS DersAdi
FROM Uye AS u
INNER JOIN Kayit AS k ON u.uyeNo = k.uyeNo
INNER JOIN Ders AS d ON k.dersNo = d.dersNo
ORDER BY u.uyeNo ASC, d.dersNo ASC;

-- Beklenen 5 satır: Ali/Pilates, Ali/Crossfit, Buse/Yoga,
-- Can/Pilates, Can/Yüzme. Duru yoktur; çünkü INNER JOIN eşleşme ister.
-- ÖNEMLİ NOT: AS u tablo takma adıdır, u.ad ise bu tablonun ad sütunudur.
-- ON u.uyeNo = k.uyeNo üye numarasını, ON k.dersNo = d.dersNo ders numarasını
-- eşleştirir. uyeNo ile dersNo'yu birbirine eşitlemek doğru JOIN mantığı değildir.

-- Sonraki dosya: 01_join_groupby_having_pratik.sql
