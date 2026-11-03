
-- ============================================================
-- KONU: WHERE, AND, OR, IN ve LIKE Operatorleri
-- KAYNAK: Murat Yucedag - SQL Ders 8 ve 9
-- ORTAM: MySQL 8.x / MySQL Workbench
-- ============================================================

-- 1. VERITABANINI SECME

CREATE DATABASE IF NOT EXISTS `kitaplık`;
USE `kitaplık`;

-- NOT:
-- Asagidaki tablo olusturma ve INSERT islemleri
-- baslangic icin bir kez calistirilmalidir.
-- Var olan tabloyu silmiyoruz.
-- Sonraki tekrarlarinda yalnizca SELECT
-- sorgularini calistirabilirsin.


-- 2. ORNEK KITAP TABLOSUNU OLUSTURMA

CREATE TABLE IF NOT EXISTS Kitap (
    KitapNo INT,
    KitapAd VARCHAR(50),
    KitapYazar VARCHAR(50),
    KitapSayfa SMALLINT,
    KitapFiyat INT,
    KitapTarih DATETIME,
    `KitapYayınEvi` VARCHAR(50)
);

-- CREATE TABLE IF NOT EXISTS:
-- Tablo yoksa olusturur, varsa yeniden olusturmaz.
-- Mevcut tablonun sutunlarini degistirmez.
--
-- NOT: Orijinal dersteki tablo yapisi korunmustur.
-- KitapNo henuz PRIMARY KEY degildir.
-- Gercek bir kitap tablosunda benzersiz bir
-- PRIMARY KEY kullanmak daha dogru olur.

DESCRIBE Kitap;


-- 3. ORNEK VERILERI EKLEME

-- Yalnizca bir kez calistir.
-- Tekrar calistirilirsa ayni kayitlar
-- yeniden eklenebilir.

INSERT INTO Kitap
    (KitapAd, KitapYazar, KitapSayfa,
     KitapFiyat, KitapTarih, `KitapYayınEvi`)
VALUES
    ('x', 'oliver', 202, 15, '1995-02-05', 'menekşe'),
    ('y', 'thodus', 593, 100, '2000-10-01', 'şarlale'),
    ('z', 'kopernik', 1000, 500, '2005-11-10', 'uludağ'),
    ('Atlas', 'Ali', 350, 80, '2015-03-20', 'Yıldız'),
    ('Masal', 'Ayşe', 250, 60, '2020-08-15', NULL);

-- Son iki kayit LIKE ve NULL denemeleri icin eklendi.
-- KitapTarih DATETIME oldugundan saat belirtilmezse
-- MySQL gecerlilik durumunda 00:00:00 kullanir.
-- NULL: Bilinmeyen veya bulunmayan degeri temsil eder.

SELECT * FROM Kitap;


-- ============================================================
-- VIDEO 8: WHERE ILE KOSULLU SORGULAMA
-- ============================================================

-- 4. WHERE: METINSEL ESITLIK KONTROLU

SELECT *
FROM Kitap
WHERE KitapAd = 'z';

-- KitapAdi z olan kayitlari getirir.
-- = operatoru esitlik kontrolu yapar.


-- 5. WHERE: SAYISAL KARSILASTIRMA

SELECT *
FROM Kitap
WHERE KitapSayfa > 600;

-- Sayfa sayisi 600'den fazla olanlari getirir.
-- 600 dahil degildir.
-- Bu ornekte z kitabini bulur.


-- 6. DIGER KARSILASTIRMA OPERATORLERI

-- Fiyati 100'e esit veya daha dusuk kitaplar:
SELECT *
FROM Kitap
WHERE KitapFiyat <= 100;

-- Sayfa sayisi 250'den az olmayan kitaplar:
SELECT *
FROM Kitap
WHERE KitapSayfa >= 250;

-- Adi x olmayan kitaplar:
SELECT *
FROM Kitap
WHERE KitapAd <> 'x';

-- <> SQL'de esit degil anlamina gelir.
-- MySQL != operatorunu de destekler.


-- ============================================================
-- VIDEO 9: AND, OR, IN VE DIGER KOSULLAR
-- ============================================================

-- 7. AND: BIRDEN FAZLA KOSUL

SELECT *
FROM Kitap
WHERE KitapSayfa > 300
  AND KitapFiyat < 100;

-- Iki kosulun da TRUE olmasi gerekir.
-- Bu ornekte Atlas kitabi gelir.


-- 8. OR: ALTERNATIF KOSULLAR

SELECT *
FROM Kitap
WHERE KitapAd = 'x'
   OR KitapAd = 'z';

-- Kosullardan en az biri TRUE ise
-- kayit sonuc listesine dahil edilir.


-- 9. IN: BIRDEN FAZLA DEGERI KONTROL ETME

SELECT *
FROM Kitap
WHERE KitapAd IN ('x', 'y', 'z');

-- IN, listedeki degerlerden biriyle
-- eslesen kayitlari getirir.
--
-- Yukaridaki sorgu, su mantiga esdegerdir:
--
-- WHERE KitapAd = 'x'
--    OR KitapAd = 'y'
--    OR KitapAd = 'z';


-- 10. NOT IN: LISTEDE OLMAYANLAR

SELECT *
FROM Kitap
WHERE KitapAd NOT IN ('x', 'y');

-- Adi x veya y olmayan kitaplari getirir.


-- 11. LIKE: METIN ICINDE DESEN ARAMA

SELECT *
FROM Kitap
WHERE KitapAd LIKE '%a%';

-- Kitap adinin herhangi bir yerinde
-- a harfi bulunan kayitlari arar.
-- Atlas ve Masal bu desene uyabilir.
-- Buyuk/kucuk harf eslesmesi collation'a baglidir.


-- 12. LIKE: BASLANGICA GORE ARAMA

SELECT *
FROM Kitap
WHERE KitapAd LIKE 'A%';

-- A harfiyle baslayan kitap adlarini arar.


-- 13. LIKE: BELIRLI KARAKTER KONUMU

SELECT *
FROM Kitap
WHERE KitapAd LIKE '_a%';

-- _: Tam olarak bir karakteri temsil eder.
-- %: Sifir veya daha fazla karakteri temsil eder.
-- Ikinci karakteri a olan kitaplari arar.


-- 14. BETWEEN: ARALIK SORGULAMA

SELECT *
FROM Kitap
WHERE KitapSayfa BETWEEN 200 AND 400;

-- 200 ve 400 DAHIL olmak uzere
-- bu araliktaki sayfa sayilarini arar.


-- 15. IS NULL: BOS / BILINMEYEN DEGERLER

SELECT *
FROM Kitap
WHERE `KitapYayınEvi` IS NULL;

-- Yayin evi bilgisi NULL olan kayitlari getirir.
-- NULL kontrolu icin = NULL kullanilmaz.


-- 16. AND VE OR BIRLIKTE KULLANIMI

SELECT *
FROM Kitap
WHERE (KitapAd = 'x' OR KitapAd = 'y')
  AND KitapFiyat < 100;

-- Once parantez icindeki OR kosulu degerlendirilir.
-- Daha sonra fiyat kosulu kontrol edilir.
-- Burada yalnizca x kitabi eslesir.


-- ============================================================
-- KONU TEKRARI / VIZE NOTLARI
-- ============================================================

/*
============================================================
1. SELECT, FROM VE WHERE
============================================================

SELECT:
- Hangi sutunlarin listelenecegini belirler.
- SELECT * tum sutunlari secer.

FROM:
- Verilerin alinacagi tabloyu belirtir.

WHERE:
- Satirlari belirli bir kosula gore filtreler.
- Yalnizca kosulu TRUE olan satirlar gelir.
- SELECT tek basina verileri degistirmez.

ORNEK:

SELECT KitapAd, KitapFiyat
FROM Kitap
WHERE KitapFiyat > 50;

Bu sorgu:
1. Kitap tablosunu kullanir.
2. Fiyati 50'den buyuk kayitlari secer.
3. Yalnizca ad ve fiyat sutunlarini gosterir.


============================================================
2. KARSILASTIRMA OPERATORLERI
============================================================

=     -> Esittir
<>    -> Esit degildir
!=    -> Esit degildir (MySQL'de)
>     -> Buyuktur
<     -> Kucuktur
>=    -> Buyuk veya esittir
<=    -> Kucuk veya esittir

ORNEK:

WHERE KitapFiyat > 100;

Fiyati 100'den buyuk kitaplari getirir.

WHERE KitapFiyat >= 100;

Fiyati 100 olanlar da dahil edilir.


============================================================
3. AND OPERATORU
============================================================

Birden fazla kosulun ayni anda
saglanmasini ister.

TRUE AND TRUE  -> TRUE
TRUE AND FALSE -> FALSE
FALSE AND TRUE -> FALSE
FALSE AND FALSE-> FALSE

ORNEK:

WHERE KitapSayfa > 300
  AND KitapFiyat < 100;

Hem sayfa hem fiyat kosulu saglanmalidir.


============================================================
4. OR OPERATORU
============================================================

Kosullardan en az birinin TRUE
olmasi yeterlidir.

TRUE OR TRUE   -> TRUE
TRUE OR FALSE  -> TRUE
FALSE OR TRUE  -> TRUE
FALSE OR FALSE -> FALSE

ORNEK:

WHERE KitapAd = 'x'
   OR KitapAd = 'z';

x veya z adindaki kitaplar gelir.


============================================================
5. IN VE NOT IN
============================================================

IN:
Bir degerin listedeki degerlerden
biri olup olmadigini kontrol eder.

WHERE KitapAd IN ('x', 'y', 'z');

NOT IN:
Listede bulunmayan degerleri filtreler.

WHERE KitapAd NOT IN ('x', 'y');

ONEMLI:
IN genellikle birden fazla OR kosulunun
daha kisa ve okunabilir yazimidir.

NOT IN kullanirken NULL degerlere
dikkat edilmelidir. Listede NULL bulunmasi
beklenmedik sonuclar dogurabilir.


============================================================
6. LIKE OPERATORU
============================================================

Metinsel verilerde desen aramak
icin kullanilir.

% -> Sifir veya daha fazla karakter
_ -> Tam olarak bir karakter

ORNEKLER:

LIKE 'a%'   -> a ile baslayanlar
LIKE '%a'   -> a ile bitenler
LIKE '%a%'  -> Icinde a bulunanlar
LIKE '_a%'  -> Ikinci karakteri a olanlar
LIKE 'a_'   -> a ile baslayan iki karakterliler

ONEMLI:
LIKE deseninde joker karakter olarak
% ve _ kullanilir.

LIKE sorgularinda buyuk/kucuk harf
duyarliligi veritabaninin/sutunun
collation ayarina gore degisir.

YANLIS:
WHERE KitapAd '%a%';

DOGRU:
WHERE KitapAd LIKE '%a%';


============================================================
7. BETWEEN OPERATORU
============================================================

Belirli bir araliktaki degerleri secer.

WHERE KitapSayfa BETWEEN 200 AND 400;

200 ve 400 sinir degerleri DAHILDIR.

Asagidaki kosula esdegerdir:

WHERE KitapSayfa >= 200
  AND KitapSayfa <= 400;

BETWEEN sayisal ve tarihsel
degerlerde de kullanilabilir.


============================================================
8. IS NULL VE IS NOT NULL
============================================================

NULL, bilinmeyen veya olmayan
bir degeri temsil eder.

NULL, 0 veya bos metin ('') degildir.

YANLIS:
WHERE KitapYazar = NULL;

DOGRU:
WHERE KitapYazar IS NULL;

NULL olmayanlari listelemek icin:

WHERE KitapYazar IS NOT NULL;

ONEMLI:
SQL'de TRUE ve FALSE disinda
UNKNOWN mantiksal sonucu da bulunur.
WHERE yalnizca TRUE olanlari getirir.


============================================================
9. AND VE OR ONCELIGI
============================================================

AND, OR operatorunden daha onceliklidir.

ORNEK:

WHERE KitapAd = 'x'
   OR KitapAd = 'y'
  AND KitapFiyat < 100;

Bu ifade mantiksal olarak:

WHERE KitapAd = 'x'
   OR (KitapAd = 'y' AND KitapFiyat < 100);

seklinde yorumlanir.

Iki kitap adi icin de fiyat kosulu
uygulamak istiyorsan:

WHERE (KitapAd = 'x' OR KitapAd = 'y')
  AND KitapFiyat < 100;

SINAVDA:
Birden fazla AND ve OR varsa,
parantezleri kontrol et.


============================================================
10. MSSQL VE MYSQL FARKLARI
============================================================

Hocanin videosu SQL Server uzerinedir.

SQL Server:
SMALLDATETIME kullanabilir.

MySQL:
SMALLDATETIME veri tipi bulunmaz.
DATETIME veya DATE kullanilir.

MySQL tarih ornegi:
'2005-11-10'

Saatli tarih ornegi:
'2005-11-10 14:30:00'

STR_TO_DATE:
Farkli tarih bicimlerindeki metinleri
tarihe donusturmek icin kullanilabilir.

ORNEK:
SELECT STR_TO_DATE('10-11-2005', '%d-%m-%Y');


============================================================
11. SIK YAPILAN HATALAR
============================================================

1. LIKE anahtar kelimesini unutmak.
2. Metinsel degerlerde tirnak kullanmamak.
3. Tarihleri gun-ay-yil sirasinda yazmak.
4. Mevcut olmayan sutun adi kullanmak.
5. AND ve OR onceligini karistirmak.
6. NULL degerini = ile karsilastirmak.
7. INSERT komutunu tekrar calistirarak
   ayni kayitlari birden fazla eklemek.
8. CREATE TABLE kodunu degistirince
   mevcut tablonun da degistigini sanmak.

MySQL hata kodlarindan ornekler:

1064 -> SQL sozdizimi hatasi
1054 -> Bilinmeyen sutun
1292 -> Gecersiz tarih veya veri degeri


============================================================
12. VIZE ICIN KISA HATIRLATMA
============================================================

SELECT  -> Verileri sorgular.
FROM    -> Tabloyu belirtir.
WHERE   -> Satirlari filtreler.
AND     -> Tum kosullar saglanmali.
OR      -> En az bir kosul saglanmali.
IN      -> Belirtilen listede arama yapar.
NOT IN  -> Listede olmayanlari secer.
LIKE    -> Metinsel desen arar.
BETWEEN -> Iki sinir dahil aralik sorgular.
IS NULL -> NULL degerleri bulur.

EN ONEMLI AYRIM:

AND = iki kosul birlikte gerekli.
OR  = kosullardan biri yeterli.
IN  = birden fazla deger arasinda arama.
LIKE = metnin belirli bir desene uymasi.

============================================================
*/
