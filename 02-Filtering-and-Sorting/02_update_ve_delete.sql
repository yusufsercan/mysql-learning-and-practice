
-- ============================================================
-- KONU: UPDATE ve DELETE Komutları
-- KAYNAK: Murat Yücedağ - SQL Ders 11 ve 12
-- ORTAM: MySQL 8.x / MySQL Workbench
-- ============================================================


-- 1. VERİTABANINI SEÇME

CREATE DATABASE IF NOT EXISTS `kitaplık`;
USE `kitaplık`;


-- 2. UYGULAMA TABLOSUNU OLUŞTURMA

-- UYARI:
-- Yalnızca bu ders için oluşturduğumuz
-- KitapDMLPratik tablosu sıfırlanır.
-- Önceden kullandığımız Kitap tablosuna dokunulmaz.
-- Dosyanın tamamını tekrar çalıştırırsan
-- KitapDMLPratik içindeki eski kayıtlar silinir.

DROP TABLE IF EXISTS KitapDMLPratik;

CREATE TABLE KitapDMLPratik (
    KitapNo INT PRIMARY KEY,
    KitapAd VARCHAR(50) NOT NULL,
    KitapYazar VARCHAR(50),
    KitapSayfa SMALLINT,
    KitapFiyat INT,
    KitapTarih DATETIME,
    KitapYayinEvi VARCHAR(50)
);

-- PRIMARY KEY:
-- KitapNo değerinin benzersiz olmasını sağlar.
-- NULL değer kabul etmez.
-- Ayrıca anahtar üzerinden yapılan WHERE sorguları,
-- Safe Updates açıkken de kullanılabilir.

-- Not:
-- KitapYayinEvi sütununda Türkçe karakter
-- kullanmadık. Böylece i / ı gibi karakter
-- farklılıklarından kaynaklanan hataları önledik.


-- 3. ÖRNEK VERİLERİ EKLEME

INSERT INTO KitapDMLPratik
    (KitapNo, KitapAd, KitapYazar, KitapSayfa,
     KitapFiyat, KitapTarih, KitapYayinEvi)
VALUES
    (1, 'x', 'Oliver', 202, 15,
     '1995-02-05', 'Menekşe'),

    (2, 'y', 'Thodus', 593, 100,
     '2000-10-01', 'Şelale'),

    (3, 'z', 'Kopernik', 1000, 500,
     '2005-11-10', 'Uludağ'),

    (4, 'Atlas', 'Ali', 350, 80,
     '2015-03-20', 'Yıldız'),

    (5, 'Masal', 'Ayşe', 250, 60,
     '2020-08-15', 'Güneş');

-- Başlangıç verilerini görüntüle:
SELECT * FROM KitapDMLPratik;


-- ============================================================
-- VİDEO 11: UPDATE KOMUTU
-- ============================================================


-- 4. UPDATE İLE TEK SÜTUN GÜNCELLEME

-- KitapNo değeri 1 olan kitabın fiyatını 22 yap.

UPDATE KitapDMLPratik
SET KitapFiyat = 22
WHERE KitapNo = 1;

-- UPDATE: Hangi tablonun değiştirileceğini belirtir.
-- SET: Değiştirilecek sütunu ve yeni değeri belirtir.
-- WHERE: Hangi kaydın değiştirileceğini belirler.

-- Güncellenen kaydı kontrol et:
SELECT *
FROM KitapDMLPratik
WHERE KitapNo = 1;


-- 5. BİRDEN FAZLA SÜTUN GÜNCELLEME

-- KitapNo değeri 2 olan kitabın
-- yazarını ve fiyatını değiştir.

UPDATE KitapDMLPratik
SET KitapYazar = 'Dostoyevski',
    KitapFiyat = 150
WHERE KitapNo = 2;

-- Birden fazla sütun SET ile güncellenebilir.
-- Sütun atamaları virgülle ayrılır.

SELECT *
FROM KitapDMLPratik
WHERE KitapNo = 2;


-- 6. MEVCUT DEĞER ÜZERİNDEN GÜNCELLEME

-- KitapNo değeri 3 olan kitabın
-- fiyatını 20 TL artır.

UPDATE KitapDMLPratik
SET KitapFiyat = KitapFiyat + 20
WHERE KitapNo = 3;

-- Eski fiyat: 500
-- Yeni fiyat: 520
--
-- KitapFiyat = KitapFiyat + 20
-- mevcut değeri okuyarak 20 ekler.
--
-- KitapFiyat = 20
-- yazsaydık fiyat doğrudan 20 olurdu.

SELECT *
FROM KitapDMLPratik
WHERE KitapNo = 3;


-- 7. BİRDEN FAZLA KAYDI GÜNCELLEME

-- KitapNo değeri 4 veya 5 olan
-- kitapların fiyatını 50 yap.

UPDATE KitapDMLPratik
SET KitapFiyat = 50
WHERE KitapNo IN (4, 5);

-- IN(4, 5):
-- KitapNo değeri 4 veya 5 olan kayıtları seçer.
-- Bu sorgu iki kaydı hedefler.

SELECT *
FROM KitapDMLPratik
WHERE KitapNo IN (4, 5);


-- 8. WHERE OLMADAN UPDATE

-- UYARI:
-- Aşağıdaki kod bilerek yorum satırında bırakıldı.

-- UPDATE KitapDMLPratik
-- SET KitapFiyat = 100;

-- WHERE bulunmadığı için bütün kayıtların
-- fiyatını 100 yapmaya çalışır.
--
-- Safe Updates açıkken Error 1175 oluşabilir.
-- Bu örneği çalıştırmana gerek yok.


-- 9. UPDATE SONRASI GENEL KONTROL

SELECT * FROM KitapDMLPratik;


-- ============================================================
-- VİDEO 12: DELETE KOMUTU
-- ============================================================


-- 10. DELETE İLE TEK KAYIT SİLME

-- Önce silinecek kaydı görüntüle:

SELECT *
FROM KitapDMLPratik
WHERE KitapNo = 5;

-- KitapNo değeri 5 olan kaydı sil:

DELETE FROM KitapDMLPratik
WHERE KitapNo = 5;

-- DELETE FROM:
-- Tablodaki kayıtları silmek için kullanılır.
--
-- WHERE:
-- Hangi kayıtların silineceğini belirtir.

-- Silme işlemini kontrol et:
SELECT *
FROM KitapDMLPratik
WHERE KitapNo = 5;

-- Sonuç boş dönmelidir.


-- 11. BİRDEN FAZLA KAYIT SİLME

-- KitapNo değeri 2 veya 4 olan
-- kayıtları silmeden önce görüntüle:

SELECT *
FROM KitapDMLPratik
WHERE KitapNo IN (2, 4);

-- Seçili kayıtları sil:

DELETE FROM KitapDMLPratik
WHERE KitapNo IN (2, 4);

-- Bu işlem iki kaydı hedefler.
-- Birden fazla kaydı WHERE koşuluyla silebiliriz.

SELECT * FROM KitapDMLPratik;


-- 12. WHERE OLMADAN DELETE

-- UYARI:
-- Bu sorgu bütün kayıtları silmeye çalışır.
-- Güvenlik nedeniyle yorum satırına alındı.

-- DELETE FROM KitapDMLPratik;

-- WHERE bulunmazsa tüm satırlar hedeflenir.
-- Ancak tablonun yapısı korunur.
--
-- Safe Updates açıkken Error 1175 oluşabilir.


-- 13. DELETE SONRASI TABLO KONTROLÜ

SELECT * FROM KitapDMLPratik;

DESCRIBE KitapDMLPratik;

-- SELECT:
-- Tabloda kalan kayıtları gösterir.
--
-- DESCRIBE:
-- Tablo yapısını gösterir.
--
-- DELETE satırları siler ama
-- sütunları veya tabloyu ortadan kaldırmaz.


-- ============================================================
-- KONU TEKRARI / VİZE NOTLARI
-- ============================================================

/*
============================================================
1. UPDATE KOMUTU NEDİR?
============================================================

UPDATE, tabloda önceden bulunan kayıtların
değerlerini değiştirmek için kullanılır.

DML (Data Manipulation Language)
komutlarından biridir.

GENEL SÖZDİZİMİ:

UPDATE TabloAdi
SET SutunAdi = YeniDeger
WHERE Kosul;

ÖRNEK:

UPDATE KitapDMLPratik
SET KitapFiyat = 100
WHERE KitapNo = 1;

ÇALIŞMA MANTIĞI:

1. UPDATE ile tablo belirlenir.
2. SET ile değiştirilecek değer belirlenir.
3. WHERE ile hedef kayıtlar filtrelenir.
4. Koşulu sağlayan kayıtlar güncellenir.


============================================================
2. SET ANAHTAR KELİMESİ
============================================================

SET, güncellenecek sütunlara yeni
değerler atamak için kullanılır.

TEK SÜTUN:

SET KitapFiyat = 50

BİRDEN FAZLA SÜTUN:

SET KitapYazar = 'Ali',
    KitapFiyat = 100

ÖNEMLİ:

Birden fazla sütunu güncellerken
atamaların arasına virgül konur.


============================================================
3. WHERE İLE UPDATE
============================================================

WHERE, hangi kayıtların değiştirileceğini
belirler.

ÖRNEK:

UPDATE KitapDMLPratik
SET KitapFiyat = 200
WHERE KitapNo = 3;

Yalnızca KitapNo = 3 koşulunu
sağlayan kayıt güncellenir.

WHERE bulunmazsa tüm kayıtlar
güncellenmeye çalışılır.

DİKKAT:

WHERE kullanmak tek başına yalnızca
bir satırın değişeceğini garanti etmez.

Eğer koşul birden fazla satırla
eşleşiyorsa birden fazla satır güncellenir.

PRIMARY KEY üzerinden eşitlik
koşulu kullanmak tek bir kaydı
hedeflemek için güvenilir bir yöntemdir.


============================================================
4. MEVCUT DEĞERLE İŞLEM YAPMA
============================================================

UPDATE yalnızca sabit değer atamaz.

Mevcut değerleri kullanarak
aritmetik işlem de yapabiliriz.

ÖRNEK:

UPDATE KitapDMLPratik
SET KitapFiyat = KitapFiyat + 10
WHERE KitapNo = 1;

Eski fiyat 22 ise yeni fiyat 32 olur.

FİYAT AZALTMA:

SET KitapFiyat = KitapFiyat - 10

FİYAT ARTIRMA:

SET KitapFiyat = KitapFiyat + 10

Bu işlemler kayıtların mevcut
değerleri üzerinden hesaplanır.


============================================================
5. DELETE KOMUTU NEDİR?
============================================================

DELETE, tablodaki mevcut
kayıtları silmek için kullanılır.

DML komutudur.

GENEL SÖZDİZİMİ:

DELETE FROM TabloAdi
WHERE Kosul;

ÖRNEK:

DELETE FROM KitapDMLPratik
WHERE KitapNo = 2;

KitapNo değeri 2 olan kayıt silinir.

DELETE:
- Kayıtları siler.
- Tablo yapısını korur.
- WHERE ile belirli kayıtları silebilir.

NOT:
Silme işlemi yapılmadan önce
SELECT ile hedef kayıtların kontrol
edilmesi iyi bir alışkanlıktır.


============================================================
6. WHERE OLMADAN UPDATE VE DELETE
============================================================

UPDATE TabloAdi
SET SutunAdi = Deger;

WHERE olmadığı için bütün kayıtlar
güncellenmeye çalışılır.

DELETE FROM TabloAdi;

WHERE olmadığı için bütün kayıtlar
silinmeye çalışılır.

Her iki sorgu da SQL açısından geçerlidir.

Ancak Safe Updates açıkken
MySQL bunları engelleyebilir.

SINAVDA:

WHERE olmadan UPDATE:
-> Tüm satırların belirtilen değerleri
   güncellenir.

WHERE olmadan DELETE:
-> Tüm satırlar silinir.

Veri bütünlüğü kısıtları ve
güvenlik ayarları işlemi engelleyebilir.


============================================================
7. MYSQL ERROR 1175 / SAFE UPDATES
============================================================

MySQL Workbench'te karşılaştığımız hata:

Error Code: 1175

You are using safe update mode.

SEBEP:

SQL_SAFE_UPDATES açık olduğunda
güvenli kabul edilmeyen UPDATE ve
DELETE sorguları engellenebilir.

Örneğin:

UPDATE KitapDMLPratik
SET KitapFiyat = 100;

Bu sorguda WHERE bulunmaz.

GÜVENLİ YÖNTEM:

UPDATE KitapDMLPratik
SET KitapFiyat = 100
WHERE KitapNo = 1;

KitapNo PRIMARY KEY olduğu için
anahtar sütun üzerinden filtreleme yapılır.

DİKKAT:

WHERE ifadesinin bulunması her zaman
Safe Updates kontrolünü geçmeye yetmez.

Anahtar veya indeks kullanımı gibi
koşullar önemlidir.

ÖĞRENME NOTU:

Güvenlik ayarını kapatmak yerine
doğru WHERE koşulu ve PRIMARY KEY
kullanmayı tercih etmeliyiz.

Bu çalışma için SQL_SAFE_UPDATES
ayarını kapatmaya gerek yoktur.


============================================================
8. DELETE, TRUNCATE VE DROP FARKLARI
============================================================

DELETE FROM Tablo;
- Tablodaki kayıtları siler.
- WHERE kullanılabilir.
- Tablo yapısı korunur.
- Uygun transaction içinde geri alınabilir.
- AUTO_INCREMENT sayacını normalde sıfırlamaz.

TRUNCATE TABLE Tablo;
- Bütün kayıtları siler.
- WHERE kullanılamaz.
- Tablo yapısı korunur.
- MySQL'de DDL işlemidir.
- AUTO_INCREMENT sayacını sıfırlar.
- Normal ROLLBACK ile geri alınamaz.

DROP TABLE Tablo;
- Tabloyu ve içindeki kayıtları siler.
- Tablo yapısı da ortadan kalkar.
- MySQL'de DDL komutudur.

KISA HATIRLATMA:

DELETE   -> Kayıt silme
TRUNCATE -> Tüm satırları temizleme
DROP     -> Tabloyu ortadan kaldırma


============================================================
9. UPDATE VE DELETE İŞLEMLERİNDE ROLLBACK
============================================================

UPDATE ve DELETE DML komutlarıdır.

InnoDB gibi transaction destekleyen
tablolar üzerinde uygun bir transaction
içinde kullanılırlarsa ROLLBACK ile
geri alınabilirler.

ÖNEMLİ:

MySQL Workbench'te autocommit açıkken
işlemler otomatik olarak kalıcılaşabilir.

Bu durumda daha sonra ROLLBACK
yazmak eski verileri geri getirmez.

Transaction ve ROLLBACK konusu
ileride ayrıca çalışılacaktır.


============================================================
10. SQL ÇALIŞMA SIRASI
============================================================

Bir kayıt güncellenecekse:

1. SELECT ile kaydı bul.
2. WHERE koşulunu kontrol et.
3. UPDATE komutunu çalıştır.
4. SELECT ile sonucu doğrula.

Bir kayıt silinecekse:

1. SELECT ile silinecek kaydı bul.
2. WHERE koşulunu kontrol et.
3. DELETE komutunu çalıştır.
4. SELECT ile silindiğini doğrula.

Bu yöntem yanlış kayıtların
değiştirilmesini önlemeye yardımcı olur.


============================================================
11. SIK YAPILAN HATALAR
============================================================

1. UPDATE sorgusunda SET yazmayı unutmak.

2. WHERE kullanmadan bütün kayıtları
   yanlışlıkla güncellemek.

3. DELETE sorgusunda WHERE kullanmadan
   bütün kayıtları silmek.

4. WHERE koşulunun yalnızca bir
   satırla eşleşeceğini varsaymak.

5. Sütun adını yanlış yazmak.

6. Metinsel değerleri tek tırnak
   içerisinde yazmamak.

7. Error 1175 hatasını SQL sözdizimi
   hatasıyla karıştırmak.

8. UPDATE ve DELETE komutlarının
   otomatik olarak geri alınabileceğini sanmak.

9. PRIMARY KEY olmadan tek bir kaydı
   güvenilir şekilde hedeflediğini varsaymak.


============================================================
12. VİZE İÇİN KISA HATIRLATMA
============================================================

UPDATE:
Var olan kayıtları değiştirir.

SET:
Değiştirilecek sütunları ve
yeni değerlerini belirtir.

DELETE FROM:
Kayıtları siler.

WHERE:
Hedef satırları belirler.

PRIMARY KEY:
Kayıtları benzersiz tanımlar.

UPDATE + WHERE:
Koşula uyan kayıtları günceller.

DELETE + WHERE:
Koşula uyan kayıtları siler.

UPDATE (WHERE yok):
Bütün kayıtları güncellemeye çalışır.

DELETE (WHERE yok):
Bütün kayıtları silmeye çalışır.

Error 1175:
Safe Updates kontrolü sorguyu engeller.

EN ÖNEMLİ KURAL:

UPDATE ve DELETE yazarken
önce hangi kayıtların etkileneceğini
SELECT sorgusuyla kontrol et.

============================================================
*/
