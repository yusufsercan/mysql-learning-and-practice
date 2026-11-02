
-- ============================================================
-- KONU: SQL Veri Tipleri ve MySQL Karsiliklari
-- KAYNAK: Murat Yucedag SQL Dersleri 2-3
-- ORTAM: MySQL 8.x / MySQL Workbench
-- ============================================================

CREATE DATABASE IF NOT EXISTS lab_db;
USE lab_db;

-- 1. TEMEL VERI TIPLERI

-- UYARI: Eski test tablosu varsa silinir.
DROP TABLE IF EXISTS VeriTipleriDeneme;

CREATE TABLE VeriTipleriDeneme (
    Sayi BIGINT,
    IkiliDeger BINARY(50),
    MedeniDurum BOOLEAN,
    TCNo CHAR(11),
    Tarih DATE,
    Tarih2 DATETIME,
    Tarih22 DATETIME(6),
    Tarih3 TIMESTAMP,
    Toplam DECIMAL(18, 0),
    Toplam2 FLOAT NOT NULL
);

-- BIGINT       : 8 byte, buyuk tam sayilar.
-- BINARY(50)   : Sabit 50 byte ikili veri.
-- BOOLEAN      : MySQL'de TINYINT(1) es anlamlisi.
-- CHAR(11)     : Sabit uzunluklu karakter alani.
-- DATE         : YYYY-MM-DD.
-- DATETIME     : Tarih ve saat; saat dilimi donusumu yapmaz.
-- DATETIME(6)  : Mikrosaniye hassasiyeti.
-- TIMESTAMP    : Saat dilimi donusumune tabi zaman degeri.
-- DECIMAL(18,0): 18 basamakli kesin sayi, 0 ondalik.
-- FLOAT        : Yaklasik ondalikli sayi.
-- NOT NULL     : NULL deger girilmesini engeller.

DESCRIBE VeriTipleriDeneme;


-- 2. VERI TIPLERINI UYGULAMALI DENEME

INSERT INTO VeriTipleriDeneme
    (Sayi, MedeniDurum, TCNo, Tarih, Tarih2,
     Toplam, Toplam2)
VALUES
    (100000, TRUE, '00000000000', '2026-11-02',
     '2026-11-02 14:00:00', 1250, 12.5);

-- TCNo degeri gercek kimlik numarasi degil,
-- yalnizca CHAR(11) tipini denemek icindir.

SELECT * FROM VeriTipleriDeneme;


-- 3. ILERI SEVIYE VERI TIPLERI

DROP TABLE IF EXISTS VeriTipleriIleri;

CREATE TABLE VeriTipleriIleri (
    GeometrikDeger GEOMETRY,
    ResimYolu VARCHAR(255),
    Sayi INT NOT NULL,
    ParaBirimi DECIMAL(19, 4),
    Para2 DECIMAL(10, 2),
    Adiniz CHAR(10),
    Islem NUMERIC(18, 0),
    Bilgiler LONGTEXT,
    Sayilar FLOAT,
    TarihSaat DATETIME,
    KucukSayi SMALLINT,
    KucukSayilar TINYINT,
    SecenekKodu TINYINT UNSIGNED,
    Saat TIME,
    GuidDegeri CHAR(36),
    Metin VARCHAR(50)
);

-- GEOMETRY       : Nokta, cizgi, poligon gibi
--                  mekansal geometrileri saklayabilir.
-- VARCHAR(255)   : En fazla 255 karakterlik metin.
-- INT            : 4 byte tam sayi.
-- DECIMAL(19,4)  : 19 basamak, 4 ondalik basamak.
-- DECIMAL(10,2)  : Para gibi kesin ondalik degerler.
-- CHAR(10)       : Sabit uzunluklu karakter alani.
-- NUMERIC(18,0)  : DECIMAL ile esdeger.
-- LONGTEXT       : Cok buyuk metin verileri.
-- FLOAT          : Yaklasik sayisal deger.
-- DATETIME       : Tarih ve saat.
-- SMALLINT       : 2 byte tam sayi.
-- TINYINT        : 1 byte, -128 ile 127 arasi.
-- TINYINT UNSIGNED: 1 byte, 0 ile 255 arasi.
-- TIME           : Saat veya sure bilgisi.
-- CHAR(36)       : Metin biciminde UUID saklayabilir.
-- VARCHAR(50)    : En fazla 50 karakterlik metin.

DESCRIBE VeriTipleriIleri;


/*
============================================================
KONU TEKRARI: MYSQL VERI TIPLERI
============================================================

1. TAM SAYI TIPLERI

   TINYINT  : 1 byte
   SMALLINT : 2 byte
   MEDIUMINT: 3 byte
   INT      : 4 byte
   BIGINT   : 8 byte

   SIGNED (varsayilan):
   Negatif ve pozitif sayilar saklanabilir.

   UNSIGNED:
   Negatif sayilar saklanamaz.
   Pozitif deger araligi genisler.

   Ornek:
   TINYINT          -> -128 ile 127
   TINYINT UNSIGNED -> 0 ile 255

2. KESIN VE YAKLASIK SAYILAR

   DECIMAL(p,s):
   p = Toplam basamak sayisi.
   s = Ondalik basamak sayisi.

   Ornek:
   DECIMAL(10,2)
   -> Toplam 10 basamak
   -> Virgülden sonra 2 basamak
   -> Tam kisim en fazla 8 basamak

   DECIMAL kesin ondalik degerler icin uygundur.
   FLOAT ise yaklasik sayi saklar.

   Para hesaplamalarinda genellikle
   DECIMAL tercih edilir.

3. CHAR VE VARCHAR

   CHAR(n):
   - Sabit uzunluklu karakter alani.
   - Kisa degerler saklanirken boslukla doldurulur.
   - Okunurken sondaki bosluklar genellikle kaldirilir.

   VARCHAR(n):
   - Degisken uzunluklu metin alani.
   - En fazla n karakter alir.
   - Saklama boyutu gercek metne gore degisir.

   VARCHAR(20), her zaman 20 byte demek degildir.
   UTF-8 karakterleri birden fazla byte kullanabilir.

4. BOOLEAN

   MySQL'de BOOLEAN, TINYINT(1) es anlamlisidir.

   0      -> FALSE olarak degerlendirilir.
   0 disi -> TRUE olarak degerlendirilir.

   BOOLEAN, tek basina sadece 0 ve 1 girilmesini
   zorunlu kilmaz.

5. TARIH VE ZAMAN TIPLERI

   DATE:
   Yalnizca tarih saklar.

   TIME:
   Saat veya sure verisi saklar.

   DATETIME:
   Tarih ve saat saklar.
   Otomatik UTC donusumu yapmaz.

   TIMESTAMP:
   MySQL degeri UTC temelli saklar;
   oturum saat dilimine gore donusturur.

   DATETIME(6):
   6 haneli kesirli saniye hassasiyeti saglar.

6. DIGER TIPLER

   BINARY(n):
   Sabit n byte ikili veri saklar.
   Kisa degerleri sifir byte ile doldurur.

   LONGTEXT:
   Cok buyuk metin alanidir.
   Teorik siniri yaklasik 4 GB'dir.
   Gercek sinirlar sistem kosullarina baglidir.

   GEOMETRY:
   Mekansal veri tipidir.
   POINT, LINESTRING, POLYGON gibi
   geometri turlerini temsil edebilir.

   UUID:
   MySQL'de UUID metin olarak CHAR(36)
   alaninda saklanabilir.
   CHAR(36) kullanmak tek basina
   benzersizlik garantisi vermez.

7. MSSQL - MYSQL FARKLARI

   MSSQL              MYSQL

   bit                BOOLEAN veya BIT(1)
   money              DECIMAL(19,4)
   smallmoney         DECIMAL(10,2)
   nvarchar(MAX)      LONGTEXT (alternatif)
   smalldatetime      DATETIME
   uniqueidentifier   CHAR(36) veya BINARY(16)
   image              BLOB ailesi veya dosya yolu

   Not: Bunlar birebir davranissal esdegerlik
   degil, kullanim amacina gore secilen
   MySQL alternatifleridir.

8. SINAVDA HATIRLA

   INT      -> Tam sayi
   VARCHAR  -> Degisken uzunluklu metin
   CHAR     -> Sabit uzunluklu metin
   DATE     -> Tarih
   DATETIME -> Tarih ve saat
   DECIMAL  -> Kesin ondalik sayi
   FLOAT    -> Yaklasik sayi
   BOOLEAN  -> Mantiksal deger icin kullanilir

   Veri tipi secimi; veri dogrulugu,
   depolama ve performansi etkiler.

============================================================
*/
