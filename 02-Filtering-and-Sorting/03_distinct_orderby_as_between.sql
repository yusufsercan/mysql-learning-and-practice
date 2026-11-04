
-- ============================================================
-- KONU: DISTINCT, ORDER BY, AS, Aritmetik İşlemler,
--       Tarih Sorguları ve BETWEEN
-- KAYNAK: Murat Yücedağ - SQL Ders 13, 14, 15, 16
-- ORTAM: MySQL 8.x / MySQL Workbench
-- ============================================================


-- ============================================================
-- 1. VERİTABANI VE TEST TABLOSU
-- ============================================================

CREATE DATABASE IF NOT EXISTS `kitaplık`;
USE `kitaplık`;

-- UYARI:
-- Sadece bu ders için oluşturulan KitapSorguPratik
-- tablosu sıfırlanır.
-- Önceki Kitap ve KitapDMLPratik tablolarına dokunulmaz.
-- Dosya tekrar baştan çalıştırıldığında bu tablodaki
-- önceki kayıtlar silinir ve örnekler yeniden eklenir.

DROP TABLE IF EXISTS KitapSorguPratik;

CREATE TABLE KitapSorguPratik (
    KitapNo INT PRIMARY KEY,
    KitapAd VARCHAR(50) NOT NULL,
    KitapYazar VARCHAR(50),
    KitapSayfa SMALLINT,
    KitapFiyat INT,
    KitapTarih DATETIME,
    KitapYayinEvi VARCHAR(50)
);


-- ============================================================
-- 2. ÖRNEK VERİLERİ EKLEME
-- ============================================================

INSERT INTO KitapSorguPratik
    (KitapNo, KitapAd, KitapYazar, KitapSayfa,
     KitapFiyat, KitapTarih, KitapYayinEvi)
VALUES
    (1, 'x', 'Oliver', 202, 15,
     '1995-02-05', 'menekşe'),

    (2, 'y', 'Thodus', 593, 100,
     '2000-10-01', 'şarlale'),

    (3, 'z', 'Kopernik', 1000, 500,
     '2005-11-10', 'uludağ'),

    (4, 'Atlas', 'Ali', 350, 80,
     '2015-03-20', 'Yıldız'),

    (5, 'Masal', 'Ayşe', 250, 60,
     '2020-08-15', NULL),

    (25, 'Kürk Mantolu Madonna', 'Sabahattin Ali',
     160, 500, '2016-04-07', 'Jupiter'),

    (26, 'Sırça Köşk', 'Sabahattin Ali',
     200, 423, '2005-11-10', 'Mars'),

    (27, 'Sırça Köşk', 'Sabahattin Ali',
     220, 425, '2012-05-11', 'Mars'),

    (28, 'Mini Kitap', 'Nermin',
     80, 12, '2005-11-10 15:30:00', 'menekşe');

-- 25 ve 26: Videoda kullandığın kitaplar.
-- 27: Aynı kitap adıyla DISTINCT denemesi.
-- 28: BETWEEN, AND/OR ve tarih-saat denemesi.
-- 5: NULL değerinin sıralamadaki davranışı.

-- Başlangıç kayıtlarını görüntüle:
SELECT * FROM KitapSorguPratik;


-- ============================================================
-- VİDEO 13: DISTINCT KOMUTU
-- ============================================================

-- 3. TEKRARLI KİTAP ADLARINI KALDIRMA

SELECT DISTINCT KitapAd
FROM KitapSorguPratik;

-- DISTINCT:
-- Seçilen sütunlardaki tekrarlı sonuçları kaldırır.
-- Sırça Köşk iki kayıtta geçse de sonuçta bir kez görünür.
-- Tablodaki gerçek kayıtlar SİLİNMEZ.


-- 4. TEKRARLI YAZARLARI KALDIRMA

SELECT DISTINCT KitapYazar
FROM KitapSorguPratik;

-- Sabahattin Ali birden fazla kitapta geçmesine
-- rağmen sonuç kümesinde bir kez listelenir.


-- 5. BİRDEN FAZLA SÜTUNDA DISTINCT

SELECT DISTINCT KitapAd, KitapYazar
FROM KitapSorguPratik;

-- DISTINCT her sütunu ayrı ayrı kontrol etmez.
-- Seçilen sütunların birleşimini değerlendirir.
-- Yalnızca aynı ad-yazar ikilisi tekrar ediyorsa
-- tekrarlı sonuç kaldırılır.


-- 6. DISTINCT VE ORDER BY BİRLİKTE

SELECT DISTINCT KitapYazar
FROM KitapSorguPratik
ORDER BY KitapYazar ASC;

-- DISTINCT tekrarları kaldırır.
-- ORDER BY sonuçları sıralar.
-- Böylece benzersiz yazarlar alfabetik sıralanır.


-- ============================================================
-- VİDEO 14: ORDER BY KULLANIMI
-- ============================================================

-- 7. SAYFA SAYISINA GÖRE ARTAN SIRALAMA

SELECT *
FROM KitapSorguPratik
ORDER BY KitapSayfa;

-- ORDER BY varsayılan olarak ASC kullanır.
-- Küçük sayfa sayısından büyüğe sıralar.


-- 8. ASC: AÇIKÇA ARTAN SIRALAMA

SELECT *
FROM KitapSorguPratik
ORDER BY KitapSayfa ASC;

-- ASC = Ascending
-- Sayılarda küçükten büyüğe;
-- metinlerde collation'a göre artan sıralama.


-- 9. DESC: AZALAN SIRALAMA

SELECT *
FROM KitapSorguPratik
ORDER BY KitapSayfa DESC;

-- DESC = Descending
-- Sayılarda büyükten küçüğe sıralar.


-- 10. FİYATA GÖRE EN PAHALIDAN EN UCUZA

SELECT KitapAd, KitapFiyat
FROM KitapSorguPratik
ORDER BY KitapFiyat DESC;


-- 11. BİRDEN FAZLA SÜTUNA GÖRE SIRALAMA

SELECT KitapAd, KitapYayinEvi, KitapFiyat
FROM KitapSorguPratik
ORDER BY KitapYayinEvi ASC, KitapFiyat ASC;

-- Önce yayınevine göre sıralama yapılır.
-- Aynı yayınevindeki kayıtlar kendi aralarında
-- fiyata göre artan şekilde sıralanır.


-- 12. FARKLI SIRALAMA YÖNLERİ

SELECT KitapAd, KitapYayinEvi, KitapFiyat
FROM KitapSorguPratik
ORDER BY KitapYayinEvi ASC, KitapFiyat DESC;

-- Önce yayınevi artan sıralanır.
-- Aynı yayınevindeki kitaplar ise
-- pahalıdan ucuza sıralanır.


-- 13. WHERE VE ORDER BY BİRLİKTE

SELECT KitapAd, KitapSayfa, KitapFiyat
FROM KitapSorguPratik
WHERE KitapSayfa > 200
ORDER BY KitapFiyat DESC;

-- Önce 200 sayfadan uzun kitaplar filtrelenir.
-- Sonuçlar fiyatına göre azalan sıralanır.


-- 14. LIMIT: SONUÇ SAYISINI SINIRLAMA

SELECT KitapAd, KitapFiyat
FROM KitapSorguPratik
ORDER BY KitapFiyat DESC, KitapNo ASC
LIMIT 3;

-- En pahalı üç kaydı listeler.
-- Fiyatlar eşitse KitapNo ile ek sıralama yapılır.
-- LIMIT MySQL'de sonuç sayısını sınırlar.


-- ============================================================
-- VİDEO 15: AS VE ARİTMETİK İŞLEMLER
-- ============================================================

-- 15. AS İLE TEK SÜTUNA TAKMA AD VERME

SELECT KitapFiyat AS `Kitap Ücreti`
FROM KitapSorguPratik;

-- AS, sonuç ekranında sütuna takma ad verir.
-- Tablodaki gerçek sütun adını değiştirmez.
-- Boşluk içeren takma adlarda ` kullanabiliriz.


-- 16. BİRDEN FAZLA SÜTUNA TAKMA AD VERME

SELECT
    KitapAd AS `Kitap İsmi`,
    KitapFiyat AS `Kitap Ücreti`
FROM KitapSorguPratik;


-- 17. ARİTMETİK TOPLAMA

SELECT
    KitapAd,
    KitapYazar,
    KitapFiyat,
    KitapFiyat + 2 AS `Yeni Fiyat`
FROM KitapSorguPratik;

-- Her kitabın fiyatının 2 fazlasını hesaplar.
-- Gerçek KitapFiyat sütunundaki veri DEĞİŞMEZ.


-- 18. ARİTMETİK BÖLME

SELECT
    KitapAd,
    KitapYazar,
    KitapFiyat,
    KitapFiyat / 2 AS `Yarı Fiyat`
FROM KitapSorguPratik;

-- Fiyatın yarısı hesaplanır.
-- Bölme sonucu kesirli olabilir.


-- 19. ÇARPMA VE ÇIKARMA

SELECT
    KitapAd,
    KitapFiyat,
    KitapFiyat * 2 AS `İki Kat Fiyat`,
    KitapFiyat - 10 AS `10 TL İndirimli Fiyat`
FROM KitapSorguPratik;

-- Aritmetik işlemler sorgunun sonucunda hesaplanır.
-- Bu sorgu UPDATE olmadığı için veri değiştirmez.


-- 20. AS, WHERE VE ORDER BY BİRLİKTE

SELECT
    KitapAd AS `Kitap İsmi`,
    KitapFiyat,
    KitapFiyat + 20 AS `Yeni Fiyat`
FROM KitapSorguPratik
WHERE KitapFiyat > 50
ORDER BY `Yeni Fiyat` DESC;

-- 50 TL'den pahalı kitapları filtreler.
-- Her kitabın fiyatının 20 fazlasını hesaplar.
-- Hesaplanan değere göre azalan sıralar.
--
-- MySQL'de SELECT takma adı ORDER BY içinde
-- kullanılabilir. Ancak WHERE içinde doğrudan
-- aynı SELECT takma adı kullanılamaz.


-- ============================================================
-- VİDEO 16: TARİH SORGULARI VE BETWEEN
-- ============================================================

-- 21. BELİRLİ TARİHTEN ÖNCEKİ KAYITLAR

SELECT *
FROM KitapSorguPratik
WHERE KitapTarih <= '2005-11-10';

-- DATETIME karşılaştırması yapılır.
-- '2005-11-10' değeri gece 00:00:00 anlamındadır.
-- Aynı günün daha sonraki saatleri dahil değildir.


-- 22. GÜNÜN TAMAMINI DAHİL EDEREK SORGULAMA

SELECT *
FROM KitapSorguPratik
WHERE KitapTarih < '2005-11-11';

-- 10 Kasım 2005 gününün tamamını kapsar.
-- 11 Kasım başlangıcından önceki kayıtları getirir.
-- Saatli kayıtları da doğru biçimde dahil eder.


-- 23. İKİ TARİH ARASINDAKİ KAYITLAR

SELECT *
FROM KitapSorguPratik
WHERE KitapTarih >= '2000-01-01'
  AND KitapTarih < '2010-01-01';

-- 2000 yılı başlangıcı dahildir.
-- 2010 yılı başlangıcı dahil değildir.


-- 24. AND İLE BİRDEN FAZLA ŞART

SELECT *
FROM KitapSorguPratik
WHERE KitapSayfa > 100
  AND KitapYayinEvi = 'menekşe';

-- İki koşulun da sağlanması gerekir.
-- Sayfa sayısı 100'den fazla olacak
-- VE yayınevi menekşe olacak.


-- 25. OR İLE BİRDEN FAZLA ŞART

SELECT *
FROM KitapSorguPratik
WHERE KitapSayfa > 100
   OR KitapYayinEvi = 'menekşe';

-- Koşullardan en az birinin sağlanması yeterlidir.
-- Mini Kitap, 80 sayfa olmasına rağmen
-- yayınevi menekşe olduğu için sonuçta yer alır.


-- 26. BETWEEN: SAYISAL ARALIK

SELECT *
FROM KitapSorguPratik
WHERE KitapFiyat BETWEEN 10 AND 20;

-- 10 ve 20 DAHİL olmak üzere aralık sorgular.
-- x (15 TL) ve Mini Kitap (12 TL) eşleşir.


-- 27. BETWEEN KULLANMADAN AYNI SORGU

SELECT *
FROM KitapSorguPratik
WHERE KitapFiyat >= 10
  AND KitapFiyat <= 20;

-- Sayısal değerler için önceki BETWEEN
-- sorgusuyla aynı koşulu ifade eder.


-- 28. NOT BETWEEN

SELECT *
FROM KitapSorguPratik
WHERE KitapFiyat NOT BETWEEN 10 AND 100;

-- 10 ile 100 aralığının dışında kalanları getirir.
-- Sınır değerleri NOT BETWEEN koşuluna dahil değildir.


-- 29. TARİH İLE BETWEEN

SELECT *
FROM KitapSorguPratik
WHERE KitapTarih BETWEEN '2000-01-01'
                     AND '2005-11-10';

-- BETWEEN iki sınırı da dahil eder.
-- Ancak DATETIME alanında üst sınır
-- '2005-11-10 00:00:00' olarak değerlendirilir.
-- Aynı günün sonraki saatleri dahil olmaz.


-- 30. TARİH ARALIĞINI GÜVENLİ KURMA

SELECT *
FROM KitapSorguPratik
WHERE KitapTarih >= '2000-01-01'
  AND KitapTarih < '2005-11-11';

-- 10 Kasım 2005 gününün tamamı dahildir.
-- DATETIME ile tam gün aralığı sorgularken
-- bu yöntem çoğu zaman daha uygundur.


-- ============================================================
-- KONU TEKRARI / VİZE NOTLARI
-- ============================================================

/*
============================================================
1. DISTINCT KOMUTU
============================================================

DISTINCT, SELECT sonucundaki tekrarlı
satırları tekilleştirmek için kullanılır.

GENEL KULLANIM:

SELECT DISTINCT Sutun
FROM Tablo;

ÖRNEK:

SELECT DISTINCT KitapYazar
FROM KitapSorguPratik;

Aynı yazarın birden fazla kitabı olsa bile
sonuçta o yazar adı bir kez görünür.

ÖNEMLİ:

DISTINCT tablodaki kayıtları SİLMEZ.
Yalnızca sorgunun döndürdüğü sonucu etkiler.

BİRDEN FAZLA SÜTUN:

SELECT DISTINCT KitapAd, KitapYazar
FROM KitapSorguPratik;

Burada kitap adı ve yazar birlikte değerlendirilir.

Örneğin:

KitapAd   KitapYazar
A         Ali
A         Ali
A         Ayşe

DISTINCT sonrası:

A         Ali
A         Ayşe

Yalnızca tamamen aynı seçili değer birleşimi
tekrar ediyorsa sonuçtan çıkarılır.

NULL değerler DISTINCT sonucunda
tekilleştirme bakımından eşit kabul edilir.

DISTINCT sonuçların sıralı geleceğini
garanti etmez. Sıralama için ORDER BY gerekir.


============================================================
2. ORDER BY KOMUTU
============================================================

ORDER BY, SELECT sonucundaki satırları
belirtilen sütunlara göre sıralar.

ASC:
Ascending = Artan sıralama

DESC:
Descending = Azalan sıralama

ÖRNEK:

ORDER BY KitapFiyat ASC;

Fiyatı küçükten büyüğe sıralar.

ORDER BY KitapFiyat DESC;

Fiyatı büyükten küçüğe sıralar.

ORDER BY KitapFiyat;

ASC varsayılan olduğu için
artan sıralama yapılır.

ÖNEMLİ:

ORDER BY kullanılmadığında SQL sorgusunun
döndürdüğü satırların sırası garanti değildir.

Metinsel sıralama karakter seti ve
collation kurallarına bağlıdır.

MySQL'de NULL değerler artan sıralamada
genellikle başta, azalan sıralamada sonda gelir.


============================================================
3. BİRDEN FAZLA SÜTUNA GÖRE SIRALAMA
============================================================

ÖRNEK:

ORDER BY KitapYayinEvi ASC, KitapFiyat DESC;

ÇALIŞMA MANTIĞI:

1. Önce yayınevine göre artan sıralama yapılır.
2. Aynı yayınevine sahip kayıtlar bulunursa
   bu kayıtlar fiyatlarına göre azalan sıralanır.

Birinci sütunda farklı değerler varsa
ikinci sütun o kayıtların sırasını belirlemez.

HER SÜTUNUN YÖNÜ AYRI BELİRLENEBİLİR.

ÖRNEK:

ORDER BY KitapAd ASC, KitapFiyat DESC;

İlk sıralama kitap adına göre artan,
eşit kitap adlarında fiyat azalandır.


============================================================
4. WHERE İLE ORDER BY FARKI
============================================================

WHERE:
Hangi satırların sonuçta yer alacağını belirler.

ORDER BY:
Sonuçtaki satırların sırasını belirler.

ÖRNEK:

SELECT *
FROM KitapSorguPratik
WHERE KitapFiyat > 100
ORDER BY KitapFiyat DESC;

MANTIĞI:

1. FROM ile tablo belirlenir.
2. WHERE ile 100 TL'den pahalılar seçilir.
3. ORDER BY ile pahalıdan ucuza sıralanır.

SQL YAZIM SIRASI:

SELECT ...
FROM ...
WHERE ...
ORDER BY ...;


============================================================
5. AS KOMUTU (ALIAS / TAKMA AD)
============================================================

AS, sorgu sonucundaki sütuna
veya tabloya geçici bir takma ad verir.

ÖRNEK:

SELECT KitapFiyat AS `Kitap Ücreti`
FROM KitapSorguPratik;

Sonuç ekranında sütun başlığı
Kitap Ücreti olarak görüntülenir.

ÖNEMLİ:

- AS gerçek sütun adını değiştirmez.
- Veritabanına kalıcı değişiklik yapmaz.
- Takma ad yalnızca sorgu kapsamında kullanılır.
- AS kelimesi sütun takma adında çoğu zaman
  isteğe bağlıdır; ancak okunabilirliği artırır.

BOŞLUKLU TAKMA AD:

AS `Yeni Fiyat`

MySQL'de backtick (`) kullanımı,
boşluklu tanımlayıcıları güvenle yazmamızı sağlar.

TEK TIRNAK FARKI:

'Metin' -> Karakter dizisi sabiti

`Sutun` -> SQL tanımlayıcısı (identifier)

MySQL, AS sonrasında tek tırnaklı sütun
takma adlarına da izin verir; ancak
tanımlayıcılar için backtick tercih edilir.


============================================================
6. ARİTMETİK OPERATÖRLER
============================================================

SQL'de sayısal sütunlarla
aritmetik işlemler yapılabilir.

+ -> Toplama
- -> Çıkarma
* -> Çarpma
/ -> Bölme
% -> Mod (kalan)

ÖRNEK:

SELECT KitapFiyat + 10 AS `Yeni Fiyat`
FROM KitapSorguPratik;

Fiyatın 10 fazlasını hesaplar.

SELECT KitapFiyat / 2 AS `Yarı Fiyat`
FROM KitapSorguPratik;

Fiyatın yarısını hesaplar.

SELECT KitapFiyat * 2 AS `İki Kat Fiyat`
FROM KitapSorguPratik;

Fiyatın iki katını hesaplar.

ÖNEMLİ AYRIM:

SELECT KitapFiyat + 10 ...

Sadece hesaplanan sonucu gösterir.
Tablodaki veriyi değiştirmez.

UPDATE KitapSorguPratik
SET KitapFiyat = KitapFiyat + 10
WHERE KitapNo = 1;

Gerçek veriyi değiştirir.

Yani SELECT ve UPDATE aynı işlem değildir.

NULL olan bir sayısal değerle yapılan
normal aritmetik işlemler de NULL sonucunu verir.


============================================================
7. TARİH SORGULARI
============================================================

MySQL'de temel tarih tipleri:

DATE:
YYYY-MM-DD biçiminde tarih tutar.

DATETIME:
YYYY-MM-DD HH:MM:SS biçiminde
tarih ve saat tutar.

TIMESTAMP:
Saat dilimi dönüşümü özelliklerine sahiptir.

ÖRNEK:

WHERE KitapTarih >= '2005-01-01';

2005 başlangıcı ve sonrasını sorgular.

WHERE KitapTarih < '2010-01-01';

2010 yılından önceki kayıtları sorgular.

ÖNEMLİ DATETIME AYRINTISI:

WHERE KitapTarih <= '2005-11-10';

Bu ifade 10 Kasım 2005 tarihinin
yalnızca 00:00:00 anına kadar olan
değerleri kapsar.

Örneğin:

2005-11-10 00:00:00 -> Dahil
2005-11-10 15:30:00 -> Dahil değil

Günün tamamını dahil etmek için:

WHERE KitapTarih < '2005-11-11';

kullanılabilir.

Bu fark DATE ve DATETIME veri tiplerini
ayırt etmek açısından sınavda önemlidir.


============================================================
8. AND VE OR OPERATÖRLERİ
============================================================

AND:
Bütün koşulların TRUE olması gerekir.

OR:
Koşullardan en az birinin TRUE olması yeterlidir.

ÖRNEK:

WHERE KitapSayfa > 100
AND KitapYayinEvi = 'menekşe';

İki koşul birlikte sağlanır.

ÖRNEK:

WHERE KitapSayfa > 100
OR KitapYayinEvi = 'menekşe';

Koşullardan herhangi biri sağlanabilir.

Bu iki sorgu genellikle farklı
sayılarda kayıt döndürür.

DİKKAT:

AND, OR operatöründen önceliklidir.

Karmaşık koşullarda parantez kullanmak
mantığı açık hâle getirir.

SQL'de NULL nedeniyle UNKNOWN
mantıksal sonucu da oluşabilir.
WHERE yalnızca TRUE olan satırları getirir.


============================================================
9. BETWEEN OPERATÖRÜ
============================================================

BETWEEN, belirtilen iki sınır arasındaki
değerleri filtreler.

GENEL KULLANIM:

WHERE Sutun BETWEEN AltSinir AND UstSinir;

ÖRNEK:

WHERE KitapFiyat BETWEEN 10 AND 20;

10 ve 20 DAHİL olmak üzere
bu aralıktaki fiyatları getirir.

EŞDEĞER YAZIM:

WHERE KitapFiyat >= 10
AND KitapFiyat <= 20;

ÖNEMLİ:

BETWEEN sınır değerlerini dahil eder.

10 < x < 20 ile
10 <= x <= 20 aynı değildir.

BETWEEN ikinci koşulu ifade eder.

NOT BETWEEN:

WHERE KitapFiyat NOT BETWEEN 10 AND 20;

Belirtilen aralığın dışındaki
değerleri filtreler.

NULL değerler ayrı değerlendirilmelidir.


============================================================
10. BETWEEN VE TARİH KULLANIMI
============================================================

BETWEEN tarih değerleriyle de kullanılabilir.

ÖRNEK:

WHERE KitapTarih BETWEEN '2020-01-01'
                     AND '2020-12-31';

KitapTarih DATETIME olduğu için
31 Aralık gününün 00:00:00 sonrasındaki
kayıtlar bu sorguya dahil olmaz.

GÜNÜN TAMAMINI KAPSAYAN YÖNTEM:

WHERE KitapTarih >= '2020-01-01'
AND KitapTarih < '2021-01-01';

Başlangıç dahil, bitiş hariç tutulur.

DATETIME üzerinde tam gün veya yıl
aralıklarıyla çalışırken bu yöntem
genellikle daha güvenilir ve açıktır.


============================================================
11. LIMIT KOMUTU
============================================================

LIMIT, MySQL'de döndürülen
satır sayısını sınırlandırır.

ÖRNEK:

SELECT *
FROM KitapSorguPratik
ORDER BY KitapFiyat DESC
LIMIT 3;

En pahalı üç kitabı getirir.

SIRALAMA İLE İLİŞKİSİ:

LIMIT 3 yazmak tek başına
en pahalı üç kitabı getirmez.

Önce ORDER BY KitapFiyat DESC
yazarak sıralama belirtilmelidir.

SQL Server'daki TOP komutu ile
benzer kullanım amacına sahiptir;
ancak sözdizimleri farklıdır.


============================================================
12. MSSQL VE MYSQL FARKLARI
============================================================

Kullandığımız videolar SQL Server
üzerinden anlatılmaktadır.

SQL SERVER:

SELECT TOP 3 *
FROM Kitap;

MYSQL:

SELECT *
FROM Kitap
LIMIT 3;

SQL Server SMALLDATETIME
veri tipini destekler.

MySQL'de SMALLDATETIME yoktur.
Gerektiğinde DATETIME kullanılır.

İki veritabanındaki tarih ve saat
fonksiyonları da farklı olabilir.

DISTINCT, ORDER BY, AS ve BETWEEN
ise her iki sistemde de temel olarak
aynı SQL mantığını ifade eder.


============================================================
13. SIK YAPILAN HATALAR
============================================================

1. DISTINCT'in tabloda kayıt sildiğini sanmak.

2. DISTINCT'in her sütunu bağımsız
   şekilde tekilleştirdiğini düşünmek.

3. ORDER BY kullanılmadığında satırların
   her zaman aynı sırayla geleceğini sanmak.

4. ASC ve DESC yönlerini karıştırmak.

5. Birden fazla ORDER BY sütununda
   ikinci sıralamanın ne zaman uygulandığını
   yanlış anlamak.

6. AS komutunun gerçek sütun adını
   kalıcı olarak değiştirdiğini sanmak.

7. SELECT içindeki aritmetik işlemlerin
   veritabanındaki fiyatları değiştirdiğini sanmak.

8. DATETIME sorgularında saat kısmını unutmak.

9. BETWEEN sınırlarının dahil
   olduğunu unutmak.

10. SQL Server ve MySQL tarih tiplerini
    birebir aynı sanmak.

11. Türkçe ve İngilizce sütun adlarını
    karıştırmak.

12. SQL açıklamaları için // kullanmak.
    MySQL'de -- yorum veya
    /* ... */ açıklama bloğu kullanılır.

13. SQL komutlarının arasına
    noktalı virgül (;) koymayı unutmak.


============================================================
14. VİZE İÇİN KISA HATIRLATMA
============================================================

DISTINCT:
Tekrarlı sonuçları kaldırır.

ORDER BY:
Sonuçları sıralar.

ASC:
Artan sıralama (varsayılan).

DESC:
Azalan sıralama.

AS:
Sütuna veya tabloya geçici takma ad verir.

WHERE:
Satırları koşula göre filtreler.

AND:
Bütün koşulların sağlanmasını ister.

OR:
En az bir koşulun sağlanması yeterlidir.

BETWEEN:
Alt ve üst sınır dahil aralık sorgular.

NOT BETWEEN:
Belirtilen aralığın dışını sorgular.

LIMIT:
Döndürülen sonuç sayısını sınırlar.

ARİTMETİK SELECT:
Hesaplama yapar, kaydı değiştirmez.

UPDATE:
Kayıtların değerlerini değiştirir.

EN ÖNEMLİ SINAV AYRIMLARI:

DISTINCT -> Tekrarlı sonuçları kaldırır.
ORDER BY -> Sonuçları sıralar.
WHERE    -> Satırları filtreler.
AS       -> Sonuç başlığını değiştirir.
BETWEEN  -> Sınırlar dahil aralık kontrolü yapar.

============================================================
*/
