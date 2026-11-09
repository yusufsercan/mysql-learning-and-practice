
-- ============================================================
-- KONU: FULL OUTER JOIN, CROSS JOIN, INTERSECT,
--       EXCEPT, UNION ve UNION ALL
-- KAYNAK: Murat Yücedağ - SQL Ders 31, 32, 33
-- ORTAM: MySQL 8.x / MySQL Workbench
-- ============================================================

-- GEREKLİ VERİTABANI:
-- kitaplik_join_pratik
--
-- GEREKLİ TABLOLAR:
-- Kitap, Kitap2, Kitap3
--
-- NOT:
-- INTERSECT ve EXCEPT için MySQL 8.0.31+
-- gereklidir. Önce sürümünü kontrol et.

SELECT VERSION();

USE kitaplik_join_pratik;


-- ============================================================
-- 1. TABLOLARI KONTROL ETME
-- ============================================================

SELECT * FROM Kitap;
SELECT * FROM Kitap2;
SELECT * FROM Kitap3;

-- Hazırladığımız örneklerde:
-- Kitap  : 12 kayıt
-- Kitap2 : 11 kayıt
-- Kitap3 :  6 kayıt
--
-- Bu değerler yalnızca ilk veri setimiz içindir.


-- ============================================================
-- DERS 31: FULL OUTER JOIN VE CROSS JOIN
-- ============================================================

-- 2. LEFT JOIN İLE SOL TABLOYU KORUMA

SELECT
    k1.KitapAd,
    k2.KitapRenk
FROM Kitap AS k1
LEFT JOIN Kitap2 AS k2
    ON k1.KitapAd = k2.KitapAdi;

-- Sol tablo Kitap'tır.
--
-- Kitap tablosundaki bütün satırlar korunur.
-- Kitap2'de eşleşme varsa renk bilgisi alınır.
-- Eşleşme yoksa KitapRenk NULL olur.
--
-- ÖRNEK:
-- Sefiller | NULL
--
-- ÖNEMLİ:
-- Bu sorgu FULL OUTER JOIN değildir.
-- Yalnızca sol tablonun tümünü korur.


-- ============================================================
-- 3. FULL OUTER JOIN NEDİR?
-- ============================================================

-- SQL Server'da aşağıdaki kod geçerlidir:
--
-- SELECT
--     COALESCE(k1.KitapAd, k2.KitapAdi) AS KitapAdi,
--     k2.KitapRenk
-- FROM Kitap AS k1
-- FULL OUTER JOIN Kitap2 AS k2
--     ON k1.KitapAd = k2.KitapAdi;
--
-- Ancak MySQL doğrudan FULL OUTER JOIN
-- sözdizimini desteklemez.
--
-- MySQL'de bu işlemi farklı şekilde kuracağız.


-- ============================================================
-- 4. MYSQL'DE FULL OUTER JOIN KARŞILIĞI
-- ============================================================

-- YÖNTEM:
-- LEFT JOIN
-- UNION ALL
-- RIGHT JOIN + eşleşmeyen sağ kayıtlar

SELECT
    COALESCE(k1.KitapAd, k2.KitapAdi) AS KitapAdi,
    k2.KitapRenk
FROM Kitap AS k1
LEFT JOIN Kitap2 AS k2
    ON k1.KitapAd = k2.KitapAdi

UNION ALL

SELECT
    COALESCE(k1.KitapAd, k2.KitapAdi) AS KitapAdi,
    k2.KitapRenk
FROM Kitap AS k1
RIGHT JOIN Kitap2 AS k2
    ON k1.KitapAd = k2.KitapAdi
WHERE k1.KitapNo IS NULL;

-- ÇALIŞMA MANTIĞI:
--
-- 1. LEFT JOIN:
--    Soldaki bütün kayıtları ve
--    sağdaki eşleşmeleri getirir.
--
-- 2. RIGHT JOIN:
--    Sağdaki kayıtları korur.
--
-- 3. WHERE k1.KitapNo IS NULL:
--    Yalnızca sağda bulunup solda
--    eşleşmeyen kayıtları seçer.
--
-- 4. UNION ALL:
--    İki sorgu sonucunu alt alta birleştirir.
--
-- Böylece her iki taraftaki kayıtlar korunur.
-- Eşleşen kayıtları gereksiz yere iki kez
-- eklemeden FULL OUTER JOIN mantığı kurulur.
--
-- NOT:
-- KitapNo sol tablonun PRIMARY KEY alanıdır.
-- Bu nedenle gerçek bir eşleşmede NULL olamaz.


-- ============================================================
-- 5. COALESCE FONKSİYONU
-- ============================================================

SELECT
    COALESCE(NULL, 'Sefiller') AS Sonuc;

-- SONUÇ:
-- Sefiller
--
-- COALESCE:
-- Verilen ifadeler arasındaki ilk
-- NULL olmayan değeri döndürür.
--
-- JOIN ÖRNEĞİNDE:
--
-- COALESCE(k1.KitapAd, k2.KitapAdi)
--
-- Eğer soldaki kitap adı NULL ise
-- sağdaki kitap adını kullanır.
--
-- Böylece yalnızca sağ tabloda bulunan
-- bir kitabın adı da görüntülenebilir.


-- ============================================================
-- 6. FULL OUTER JOIN İÇİN EK TEST
-- ============================================================

-- Mevcut Kitap2 tablosundaki her kitap,
-- Kitap tablosunda da bulunuyor.
--
-- Bu yüzden FULL OUTER JOIN farkını
-- daha açık görmek için geçici bir
-- sorgu sonucu oluşturuyoruz.
--
-- CTE (WITH), yalnızca bu sorgu boyunca
-- kullanılabilen geçici bir sonuç tanımlar.
-- Gerçek tablolara kayıt EKLEMEZ.

WITH EkKitap2 AS (
    SELECT KitapAdi, KitapRenk
    FROM Kitap2

    UNION ALL

    SELECT 'Sadece Kitap2', 'mor'
)
SELECT
    COALESCE(k1.KitapAd, k2.KitapAdi) AS KitapAdi,
    k2.KitapRenk
FROM Kitap AS k1
LEFT JOIN EkKitap2 AS k2
    ON k1.KitapAd = k2.KitapAdi

UNION ALL

SELECT
    COALESCE(k1.KitapAd, k2.KitapAdi) AS KitapAdi,
    k2.KitapRenk
FROM Kitap AS k1
RIGHT JOIN EkKitap2 AS k2
    ON k1.KitapAd = k2.KitapAdi
WHERE k1.KitapNo IS NULL;

-- BU ÖRNEKTE:
--
-- Sefiller     -> Yalnızca Kitap tablosunda.
-- Sadece Kitap2 -> Yalnızca geçici sağ tabloda.
--
-- FULL OUTER JOIN mantığıyla her ikisi
-- de sonuçta yer alır.
--
-- Önceki veri setindeki 12 kayıt ile
-- yeni geçici kayıt birleşince 13 satır beklenir.


-- ============================================================
-- 7. CROSS JOIN: KARTEZYEN ÇARPIM
-- ============================================================

SELECT
    k1.KitapAd,
    k2.KitapAdi
FROM Kitap AS k1
CROSS JOIN Kitap2 AS k2
LIMIT 15;

-- CROSS JOIN:
-- İlk tablodaki her satırı,
-- ikinci tablodaki her satırla birleştirir.
--
-- Eşleştirme koşulu kullanmıyoruz.
--
-- Kitap  = 12 satır
-- Kitap2 = 11 satır
--
-- 12 * 11 = 132 kombinasyon oluşur.
--
-- LIMIT 15 yalnızca sonuçların
-- ilk 15 tanesini görüntüler.


-- ============================================================
-- 8. CROSS JOIN KAYIT SAYISI
-- ============================================================

SELECT COUNT(*) AS KombinasyonSayisi
FROM Kitap AS k1
CROSS JOIN Kitap2 AS k2;

-- Beklenen sonuç: 132
--
-- CROSS JOIN hata değildir.
-- Ancak istemeden eşleştirme koşulunu
-- unutursak gereksiz kombinasyonlar oluşabilir.
--
-- JOIN ile CROSS JOIN farkını bilmeliyiz.


-- ============================================================
-- DERS 32: INTERSECT VE EXCEPT
-- ============================================================

-- 9. INTERSECT: ORTAK KAYITLARI BULMA

-- MySQL 8.0.31 ve sonrası gereklidir.

SELECT KitapAd AS KitapAdi
FROM Kitap

INTERSECT

SELECT KitapAdi
FROM Kitap2
ORDER BY KitapAdi;

-- INTERSECT:
-- İki SELECT sorgusunun ortak sonuçlarını getirir.
--
-- ÖRNEK:
-- Kitap'ta  -> Son Ada
-- Kitap2'de -> Son Ada
--
-- Bu kayıt ortak olduğundan sonuçta bulunur.
--
-- Sefiller yalnızca Kitap'ta olduğundan
-- INTERSECT sonucuna girmez.
--
-- Varsayılan INTERSECT, tekrarlı
-- sonuç satırlarını kaldırır.


-- ============================================================
-- 10. EXCEPT: İLK SORGUDA OLUP İKİNCİDE OLMAYAN
-- ============================================================

SELECT KitapAd AS KitapAdi
FROM Kitap

EXCEPT

SELECT KitapAdi
FROM Kitap2
ORDER BY KitapAdi;

-- EXCEPT:
-- Birinci SELECT sonucunda bulunup
-- ikinci SELECT sonucunda bulunmayan
-- kayıtları getirir.
--
-- Kitap - Kitap2 mantığıyla çalışır.
--
-- ÖRNEK:
-- Sefiller Kitap tablosunda var.
-- Kitap2 tablosunda yok.
--
-- Bu nedenle sonuç:
-- Sefiller
--
-- EXCEPT'te sorguların sırası önemlidir!


-- ============================================================
-- 11. EXCEPT SIRASINI TERS ÇEVİRME
-- ============================================================

SELECT KitapAdi
FROM Kitap2

EXCEPT

SELECT KitapAd
FROM Kitap;

-- Artık Kitap2'de olup Kitap'ta
-- bulunmayan kayıtları arıyoruz.
--
-- Bizim mevcut veri setimizde Kitap2'deki
-- bütün kitaplar Kitap'ta da bulunduğundan
-- sonuç boş olacaktır.
--
-- ÖNEMLİ:
--
-- A EXCEPT B
-- ile
-- B EXCEPT A
--
-- aynı sonucu vermek zorunda değildir.


-- ============================================================
-- 12. ESKİ MYSQL SÜRÜMLERİNDE INTERSECT
-- ============================================================

-- INTERSECT desteklenmiyorsa
-- INNER JOIN ve DISTINCT kullanılabilir.

SELECT DISTINCT
    k1.KitapAd
FROM Kitap AS k1
INNER JOIN Kitap2 AS k2
    ON k1.KitapAd = k2.KitapAdi;

-- Bu özel örnekte iki tabloda bulunan
-- ortak kitap adlarını getirir.
--
-- DISTINCT aynı kitap adının birden fazla
-- kez görüntülenmesini önler.
--
-- Bu yöntem, ortak tek sütun değerlerini
-- bulmak için bir alternatiftir.


-- ============================================================
-- 13. ESKİ MYSQL SÜRÜMLERİNDE EXCEPT
-- ============================================================

-- Kitap'ta olup Kitap2'de olmayanları bul.

SELECT
    k1.KitapAd
FROM Kitap AS k1
LEFT JOIN Kitap2 AS k2
    ON k1.KitapAd = k2.KitapAdi
WHERE k2.KitapAdi IS NULL;

-- LEFT JOIN:
-- Kitap tablosunun tüm satırlarını korur.
--
-- IS NULL:
-- Kitap2'de eşleşmeyenleri seçer.
--
-- Bu örnek Sefiller kaydını getirir.
--
-- NOT:
-- Genel EXCEPT işleminin DISTINCT davranışını
-- taklit etmek gerekiyorsa SELECT DISTINCT
-- kullanılmalıdır.


-- ============================================================
-- DERS 33: UNION VE UNION ALL
-- ============================================================

-- 14. COUNT İLE KITAP2 KAYIT SAYISI

SELECT COUNT(KitapAdi) AS KitapSayisi
FROM Kitap2;

-- KitapAdi PRIMARY KEY olduğu için NULL değildir.
-- Dolayısıyla bütün Kitap2 kayıtları sayılır.
--
-- Beklenen sonuç: 11


-- ============================================================
-- 15. UNION: TEKRARLARI KALDIRARAK BİRLEŞTİRME
-- ============================================================

SELECT KitapAd AS KitapAdi
FROM Kitap

UNION

SELECT KitapAdi
FROM Kitap2;

-- UNION:
-- İki SELECT sorgusunun sonuçlarını
-- alt alta birleştirir.
--
-- Tekrar eden sonuç satırlarını kaldırır.
--
-- ÖRNEK:
-- Son Ada iki tabloda da vardır.
--
-- UNION sonucunda bir kez görünür.
--
-- Mevcut örnekte 12 farklı kitap adı beklenir.


-- ============================================================
-- 16. UNION ALL: BÜTÜN KAYITLARI GETİRME
-- ============================================================

SELECT KitapAd AS KitapAdi
FROM Kitap

UNION ALL

SELECT KitapAdi
FROM Kitap2;

-- UNION ALL:
-- İki SELECT sonucunu alt alta birleştirir.
--
-- Tekrarları KALDIRMAZ.
--
-- Son Ada iki tabloda da olduğundan
-- sonuçta iki kez bulunur.
--
-- 12 + 11 = 23 sonuç satırı beklenir.


-- ============================================================
-- 17. UNION ALL VE ORDER BY
-- ============================================================

SELECT KitapAd AS KitapAdi
FROM Kitap

UNION ALL

SELECT KitapAdi
FROM Kitap2

ORDER BY KitapAdi ASC;

-- ORDER BY en sona yazıldı.
--
-- Çünkü iki SELECT sonucunun
-- birleşmiş hâlini sıralamak istiyoruz.
--
-- KitapAdi sütun ismi ilk SELECT
-- sonucundan alınmıştır.
--
-- ORDER BY tüm birleşik sonuca uygulanır.


-- ============================================================
-- 18. UNION VE UNION ALL SONUÇ SAYISI
-- ============================================================

SELECT COUNT(*) AS BirlesimSatirSayisi
FROM (
    SELECT KitapAd AS KitapAdi
    FROM Kitap

    UNION ALL

    SELECT KitapAdi
    FROM Kitap2
) AS Birlesim;

-- Alt sorgu, UNION ALL sonucunu oluşturur.
-- Dıştaki COUNT(*) bu sonucun satırlarını sayar.
--
-- Beklenen sonuç: 23


-- ============================================================
-- 19. UNION FARKLI SÜTUNLARDA NASIL ÇALIŞIR?
-- ============================================================

SELECT
    'Son Ada' AS KitapAdi,
    'roman' AS KitapTur

UNION

SELECT
    'Son Ada',
    'hikaye';

-- SONUÇ:
--
-- Son Ada | roman
-- Son Ada | hikaye
--
-- İki satırın kitap adı aynı.
-- Ancak kitap türü farklı.
--
-- UNION yalnızca ilk sütunu değil,
-- seçilen TÜM sütun değerlerinin
-- birleşimini karşılaştırır.
--
-- Bu yüzden iki satır da sonuçta kalır.


-- ============================================================
-- 20. UNION ALL İLE TEKRARLI SONUÇ
-- ============================================================

SELECT 'Son Ada' AS KitapAdi

UNION ALL

SELECT 'Son Ada';

-- SONUÇ:
--
-- Son Ada
-- Son Ada
--
-- UNION ALL tekrarlı değerleri korur.
--
-- Burada UNION kullanılsaydı
-- yalnızca bir Son Ada görüntülenirdi.


-- ============================================================
-- 21. INTERSECT, EXCEPT, UNION KARŞILAŞTIRMASI
-- ============================================================

-- ORTAK KİTAPLAR:
SELECT KitapAd AS KitapAdi
FROM Kitap
INTERSECT
SELECT KitapAdi
FROM Kitap2;

-- SADECE İLK TABLODA BULUNANLAR:
SELECT KitapAd AS KitapAdi
FROM Kitap
EXCEPT
SELECT KitapAdi
FROM Kitap2;

-- HER İKİ TABLONUN BENZERSİZ KİTAPLARI:
SELECT KitapAd AS KitapAdi
FROM Kitap
UNION
SELECT KitapAdi
FROM Kitap2;

-- BÜTÜN KİTAP KAYITLARI (TEKRARLAR DAHİL):
SELECT KitapAd AS KitapAdi
FROM Kitap
UNION ALL
SELECT KitapAdi
FROM Kitap2;


-- ============================================================
-- KONU TEKRARI / VİZE NOTLARI
-- ============================================================

/*
============================================================
1. FULL OUTER JOIN NEDİR?
============================================================

FULL OUTER JOIN, iki tablodaki bütün
satırları koruyan bir birleştirme işlemidir.

Eşleşen satırları birleştirir.

Yalnızca solda bulunan satırları korur.

Yalnızca sağda bulunan satırları da korur.

Eşleşmeyen tarafın sütunlarında NULL oluşur.

SQL SERVER:

FULL OUTER JOIN doğrudan kullanılabilir.

MYSQL:

FULL OUTER JOIN doğrudan desteklenmez.

Bir alternatif:

LEFT JOIN
UNION ALL
RIGHT JOIN + sadece sağda eşleşmeyenler

Bu yöntem eşleşen satırları
gereksiz yere iki kez eklemez.


============================================================
2. LEFT, RIGHT VE FULL JOIN FARKI
============================================================

INNER JOIN:
Yalnızca eşleşen kayıtları getirir.

LEFT JOIN:
Sol tablonun tamamını ve
sağdaki eşleşmeleri getirir.

RIGHT JOIN:
Sağ tablonun tamamını ve
soldaki eşleşmeleri getirir.

FULL OUTER JOIN:
Her iki tablodaki bütün satırları korur.

ÖRNEK:

Tablo A: Ali, Ayşe
Tablo B: Ayşe, Mehmet

INNER JOIN:
Ayşe

LEFT JOIN:
Ali, Ayşe

RIGHT JOIN:
Ayşe, Mehmet

FULL OUTER JOIN:
Ali, Ayşe, Mehmet

Bunlar eşleşme mantığını gösteren
basitleştirilmiş örneklerdir.


============================================================
3. COALESCE FONKSİYONU
============================================================

COALESCE, birden fazla ifade arasından
ilk NULL olmayan değeri döndürür.

ÖRNEK:

SELECT COALESCE(NULL, 'Ali', 'Ayşe');

SONUÇ:
Ali

FULL OUTER JOIN simülasyonunda:

COALESCE(k1.KitapAd, k2.KitapAdi)

kullanıldığında, soldaki isim NULL ise
sağdaki kitap adı gösterilebilir.

COALESCE tabloya veri eklemez.
Sadece sorgunun sonuç değerini hesaplar.


============================================================
4. CROSS JOIN NEDİR?
============================================================

CROSS JOIN, tablolardaki bütün
satır kombinasyonlarını oluşturur.

GENEL SÖZDİZİMİ:

SELECT *
FROM TabloA
CROSS JOIN TabloB;

Eğer:

TabloA = 5 satır
TabloB = 4 satır

ise:

5 * 4 = 20 satır oluşur.

Bu işleme KARTEZYEN ÇARPIM denir.

ÖNEMLİ:

İlişki koşulu unutulduğunda istenmeyen
kartezyen çarpım oluşabilir.

CROSS JOIN tek başına hata değildir.
İstenildiğinde kullanılabilen bir JOIN türüdür.


============================================================
5. INTERSECT NEDİR?
============================================================

INTERSECT, iki sorgu sonucunun
ortak satırlarını getirir.

GENEL KULLANIM:

SELECT Sutun FROM TabloA
INTERSECT
SELECT Sutun FROM TabloB;

ÖRNEK:

A = Ali, Ayşe, Mehmet
B = Ayşe, Mehmet, Zeynep

A INTERSECT B:

Ayşe
Mehmet

Varsayılan INTERSECT tekrarlı
sonuç satırlarını kaldırır.

MySQL 8.0.31 ve sonrası destekler.


============================================================
6. EXCEPT NEDİR?
============================================================

EXCEPT, birinci sorgu sonucunda olup
ikinci sorgu sonucunda bulunmayan
satırları getirir.

GENEL KULLANIM:

SELECT Sutun FROM TabloA
EXCEPT
SELECT Sutun FROM TabloB;

ÖRNEK:

A = Ali, Ayşe, Mehmet
B = Ayşe, Mehmet, Zeynep

A EXCEPT B:

Ali

B EXCEPT A:

Zeynep

ÖNEMLİ:
EXCEPT işleminde sorguların sırası önemlidir.

A EXCEPT B ve B EXCEPT A
genellikle aynı sonucu vermez.

Varsayılan EXCEPT tekrarlı
sonuç satırlarını kaldırır.


============================================================
7. UNION NEDİR?
============================================================

UNION, uyumlu SELECT sonuçlarını
alt alta birleştirir.

Tekrar eden sonuç satırlarını kaldırır.

GENEL KULLANIM:

SELECT Sutun FROM TabloA
UNION
SELECT Sutun FROM TabloB;

ÖRNEK:

A = Ali, Ayşe
B = Ayşe, Mehmet

UNION SONUCU:

Ali
Ayşe
Mehmet

Ayşe iki tabloda da olmasına rağmen
sonuçta bir kez görünür.


============================================================
8. UNION ALL NEDİR?
============================================================

UNION ALL, SELECT sonuçlarını
alt alta birleştirir.

Tekrarlı satırları da korur.

ÖRNEK:

A = Ali, Ayşe
B = Ayşe, Mehmet

UNION ALL SONUCU:

Ali
Ayşe
Ayşe
Mehmet

ÖNEMLİ:

UNION:
Tekrarlı sonuçları kaldırır.

UNION ALL:
Tekrarlı sonuçları korur.

UNION ALL, tekrar kaldırma işlemi
yapmadığı için genellikle daha az
işlem maliyetine sahip olabilir.


============================================================
9. UNION, INTERSECT VE EXCEPT
============================================================

A = Birinci sorgunun sonuç kümesi.
B = İkinci sorgunun sonuç kümesi.

UNION:
A veya B içinde bulunan tüm
farklı satırları getirir.

INTERSECT:
Hem A hem B içinde bulunan
ortak satırları getirir.

EXCEPT:
A içinde bulunup B içinde
bulunmayan satırları getirir.

UNION ALL:
A ve B sonuçlarını tekrarları
koruyarak birleştirir.

KISA HATIRLATMA:

UNION      -> Birleşim
INTERSECT  -> Kesişim
EXCEPT     -> Fark
UNION ALL  -> Tekrarlı birleşim


============================================================
10. KÜME İŞLEMLERİNDE SÜTUN KURALLARI
============================================================

UNION, UNION ALL, INTERSECT ve EXCEPT
işlemlerinde SELECT sonuçlarının sütun
sayıları eşit olmalıdır.

ÖRNEK:

SELECT Ad FROM Kisiler
UNION
SELECT KitapAd FROM Kitap;

İki taraf da bir sütun döndürdüğünden
sütun sayısı açısından uygundur.

YANLIŞ:

SELECT Ad, Soyad FROM Kisiler
UNION
SELECT KitapAd FROM Kitap;

Birinci sorgu iki sütun,
ikinci sorgu bir sütun döndürmektedir.

Bu nedenle hata oluşur.

ÖNEMLİ:
Sütunların veri tiplerinin de
birlikte kullanılabilir olması gerekir.

Sütun isimlerinin aynı olması zorunlu değildir.

Sütunlar pozisyonlarına göre eşleştirilir.

Sonuç sütun isimleri genel olarak
ilk SELECT sorgusundan alınır.


============================================================
11. UNION İLE JOIN FARKI
============================================================

JOIN:
Birden fazla tablonun satırlarını
eşleştirmek ve ilişkili sütunları
yan yana görüntülemek için kullanılır.

UNION:
Uyumlu SELECT sonuçlarını
alt alta birleştirir.

ÖRNEK:

JOIN SONUCU:

KitapAd       KitapTur
Son Ada       tiyatro

UNION SONUCU:

KitapAdi
Son Ada
Sefiller

EN ÖNEMLİ AYRIM:

JOIN -> Satırları ilişkilendirerek
        sütunları yan yana getirebilir.

UNION -> Sonuç satırlarını
         alt alta ekler.


============================================================
12. ORDER BY VE KÜME İŞLEMLERİ
============================================================

Birleşik sonucu sıralamak için
ORDER BY genellikle en sona yazılır.

ÖRNEK:

SELECT KitapAd AS KitapAdi FROM Kitap
UNION ALL
SELECT KitapAdi FROM Kitap2
ORDER BY KitapAdi ASC;

ORDER BY, bütün birleşim sonucunu sıralar.

UNION tek başına sonuç sırasını
garanti etmez.

Sıralama gerekiyorsa ORDER BY kullanılır.

ÖNEMLİ:
ORDER BY ifadesinde birleşik sonucun
sütun adları veya takma adları kullanılabilir.


============================================================
13. TEKRARLI KAYITLARIN ETKİSİ
============================================================

UNION:
Aynı sonuç satırlarını tekilleştirir.

UNION ALL:
Aynı sonuç satırlarını korur.

INTERSECT:
Varsayılan olarak ortak satırları
tekilleştirir.

EXCEPT:
Varsayılan olarak fark sonuçlarını
tekilleştirir.

MySQL 8.0.31+ sürümlerinde
INTERSECT ALL ve EXCEPT ALL da bulunur.

ALL kullanımı tekrar sayılarının
sonuca yansımasını değiştirir.

SINAVDA:
Bir operatörün DISTINCT mi,
ALL mı kullandığına dikkat et.

UNION ALL için tekrarlar korunur.


============================================================
14. İŞLEM ÖNCELİĞİ
============================================================

INTERSECT, UNION ve EXCEPT
işlemlerinden daha yüksek önceliklidir.

ÖRNEK:

A UNION B INTERSECT C

mantıksal olarak:

A UNION (B INTERSECT C)

şeklinde değerlendirilir.

Karışıklığı önlemek için
parantez kullanmak iyi bir alışkanlıktır.

Bu konu özellikle birden fazla
küme işlemi içeren sorularda önemlidir.


============================================================
15. NULL DEĞERLERİ
============================================================

JOIN eşleşmelerinde:

NULL = NULL

normal eşitlik koşulu TRUE üretmez.

Bu nedenle yalnızca eşitlik kullanan
INNER JOIN, NULL anahtarları eşleştirmez.

Küme işlemlerinde ise DISTINCT
mantığıyla tekrarlı sonuçlar değerlendirilir.

UNION, INTERSECT ve EXCEPT
tekrarlı satırları ayıklarken
NULL içeren eşdeğer satırları
tekilleştirebilir.

JOIN ile küme işlemlerinin
NULL davranışları aynı değildir.


============================================================
16. MYSQL VE SQL SERVER FARKLARI
============================================================

SQL SERVER:

FULL OUTER JOIN desteklenir.
INTERSECT desteklenir.
EXCEPT desteklenir.
UNION ve UNION ALL desteklenir.

MYSQL:

FULL OUTER JOIN doğrudan desteklenmez.

LEFT JOIN + UNION ALL +
sağda eşleşmeyenleri alan RIGHT JOIN
ile aynı mantık kurulabilir.

INTERSECT ve EXCEPT:
MySQL 8.0.31 ve sonrasında desteklenir.

UNION ve UNION ALL:
MySQL tarafından desteklenir.

CROSS JOIN:
Her iki sistemde de bulunur.

SINAVDA:
Kullanılan DBMS'in sözdizimine dikkat et.


============================================================
17. SIK YAPILAN HATALAR
============================================================

1. FULL OUTER JOIN'i MySQL'de doğrudan
   çalıştırmaya çalışmak.

2. LEFT JOIN'i FULL OUTER JOIN sanmak.

3. CROSS JOIN için eşleştirme koşulu
   gerektiğini düşünmek.

4. INTERSECT ile UNION'ı karıştırmak.

5. EXCEPT sorgularının sırasını değiştirse
   bile sonucun aynı kalacağını sanmak.

6. UNION ALL'ın tekrarları sildiğini sanmak.

7. UNION işlemlerinde farklı sayıda
   sütun seçmek.

8. Birleşik sonuçların otomatik
   sıralandığını düşünmek.

9. UNION'da yalnızca ilk sütunun
   tekrar kontrolüne girdiğini sanmak.

10. INTERSECT ve EXCEPT'i eski MySQL
    sürümlerinde kullanmaya çalışmak.

11. JOIN ile UNION'ı aynı işlem sanmak.

12. FULL OUTER JOIN simülasyonunda
    iki tarafın bütün eşleşmelerini
    UNION ALL ile doğrudan ekleyip
    eşleşen kayıtları iki kez üretmek.


============================================================
18. VİZE İÇİN KISA HATIRLATMA
============================================================

INNER JOIN:
Eşleşen satırlar.

LEFT JOIN:
Soldaki bütün satırlar ve eşleşmeler.

RIGHT JOIN:
Sağdaki bütün satırlar ve eşleşmeler.

FULL OUTER JOIN:
Her iki taraftaki bütün satırlar.

CROSS JOIN:
Bütün satır kombinasyonları.

UNION:
Tekrarsız birleşim.

UNION ALL:
Tekrarlı birleşim.

INTERSECT:
Ortak sonuçlar.

EXCEPT:
Birinci sorguda olup ikincide olmayanlar.

COALESCE:
İlk NULL olmayan değeri döndürür.

EN ÖNEMLİ SINAV AYRIMLARI:

JOIN ile UNION farklı işlemlerdir.

UNION ile UNION ALL aynı değildir.

INTERSECT ile EXCEPT aynı değildir.

EXCEPT'te sorgu sırası önemlidir.

FULL OUTER JOIN MySQL'de doğrudan yoktur.

Küme işlemlerinde sütun sayıları
birbiriyle uyumlu olmalıdır.

============================================================
*/
