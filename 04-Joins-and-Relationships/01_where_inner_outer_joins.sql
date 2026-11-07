
-- ============================================================
-- KONU: WHERE ile Birleştirme, INNER JOIN, LEFT/RIGHT JOIN
-- KAYNAK: Murat Yücedağ - SQL Ders 28, 29 ve 30
-- ORTAM: MySQL 8.x / MySQL Workbench
-- ============================================================

USE kitaplik_join_pratik;

-- GEREKLİ TABLOLAR:
-- Kitap  : KitapNo, KitapAd, KitapYazar, KitapFiyat...
-- Kitap2 : KitapAdi, KitapTur, KitapRenk, KitapOzet
-- Kitap3 : KitapRengi, KitapBaski

-- Bu tablolar daha önce oluşturuldu.
-- Önce mevcut kayıtları kontrol edelim.

SELECT * FROM Kitap;
SELECT * FROM Kitap2;
SELECT * FROM Kitap3;


-- ============================================================
-- DERS 28: WHERE İLE TABLO BİRLEŞTİRME
-- ============================================================

-- 1. İKİ TABLOYU KOŞUL OLMADAN BİRLEŞTİRME

SELECT
    k2.KitapAdi,
    k2.KitapTur,
    k1.KitapYazar
FROM Kitap AS k1, Kitap2 AS k2
LIMIT 15;

-- Burada iki tablo arasında eşleştirme koşulu YOK.
--
-- Kitap tablosunun her satırı,
-- Kitap2 tablosunun her satırıyla eşleşir.
--
-- Bu işleme KARTEZYEN ÇARPIM (CARTESIAN PRODUCT)
-- veya CROSS JOIN denir.
--
-- Örneğin:
-- Kitap  -> 12 kayıt
-- Kitap2 -> 11 kayıt
--
-- 12 * 11 = 132 kombinasyon oluşur.
--
-- LIMIT 15 yalnızca ilk 15 sonucu gösterir.
-- Tablo kayıtlarını silmez veya değiştirmez.
--
-- DİKKAT:
-- İlişki koşulunu unutmak çok fazla ve
-- anlamsız sonuç üretilmesine neden olabilir.


-- 2. CROSS JOIN SONUÇ SAYISINI HESAPLAMA

SELECT COUNT(*) AS KombinasyonSayisi
FROM Kitap AS k1
CROSS JOIN Kitap2 AS k2;

-- CROSS JOIN tüm kombinasyonları üretir.
-- Eşleştirme koşulu bulunmaz.
--
-- Sonuç:
-- 12 * 11 = 132 (önceki örnek veriler değişmediyse).


-- 3. WHERE İLE İKİ TABLOYU EŞLEŞTİRME

SELECT
    k2.KitapAdi,
    k2.KitapTur,
    k1.KitapYazar
FROM Kitap AS k1, Kitap2 AS k2
WHERE k1.KitapAd = k2.KitapAdi;

-- Artık birleştirme koşulumuz var:
--
-- k1.KitapAd = k2.KitapAdi
--
-- Kitap ve Kitap2 tablolarındaki
-- kitap adı eşit olan satırlar eşleştirilir.
--
-- ÖRNEK:
--
-- Kitap:
-- KitapAd = 'Beyaz Geceler'
-- KitapYazar = 'Dostoyevski'
--
-- Kitap2:
-- KitapAdi = 'Beyaz Geceler'
-- KitapTur = 'hikaye'
--
-- SONUÇ:
-- Beyaz Geceler | hikaye | Dostoyevski
--
-- WHERE, eşleşmeyen kombinasyonları eler.


-- 4. TABLO TAKMA ADLARI (ALIAS)

SELECT
    k2.KitapAdi,
    k2.KitapRenk
FROM Kitap AS k1, Kitap2 AS k2
WHERE k1.KitapAd = k2.KitapAdi;

-- k1 = Kitap tablosunun takma adı.
-- k2 = Kitap2 tablosunun takma adı.
--
-- AS kullanmak isteğe bağlıdır:
-- FROM Kitap k1, Kitap2 k2
--
-- k1.KitapAd:
-- Kitap tablosundaki KitapAd sütunu.
--
-- k2.KitapAdi:
-- Kitap2 tablosundaki KitapAdi sütunu.
--
-- Takma adlar sorguyu daha okunabilir yapar.
-- Özellikle çok sayıda tablo varsa önemlidir.


-- 5. WHERE İLE BİRLEŞTİRME VE EK FİLTRE

SELECT
    k1.KitapAd,
    k1.KitapYazar,
    k1.KitapFiyat,
    k2.KitapTur
FROM Kitap AS k1, Kitap2 AS k2
WHERE k1.KitapAd = k2.KitapAdi
  AND k1.KitapFiyat > 10;

-- İki farklı koşul vardır:
--
-- 1. k1.KitapAd = k2.KitapAdi
--    Tablolardaki kayıtları eşleştirir.
--
-- 2. k1.KitapFiyat > 10
--    Fiyatı 10'dan fazla olanları filtreler.
--
-- AND kullanıldığı için her iki koşul
-- aynı anda sağlanmalıdır.


-- ============================================================
-- DERS 29: INNER JOIN
-- ============================================================

-- 6. TEMEL INNER JOIN

SELECT
    k1.KitapAd,
    k1.KitapYazar,
    k2.KitapTur,
    k2.KitapRenk
FROM Kitap AS k1
INNER JOIN Kitap2 AS k2
    ON k1.KitapAd = k2.KitapAdi;

-- INNER JOIN:
-- İki tablodaki eşleşen satırları birleştirir.
--
-- ON:
-- Tablolar arasındaki eşleştirme koşuludur.
--
-- Yani:
-- Kitap.KitapAd = Kitap2.KitapAdi
--
-- ÖRNEK:
-- Beyaz Geceler -> İki tabloda da var.
-- Sefiller      -> Yalnızca Kitap tablosunda var.
--
-- Dolayısıyla Beyaz Geceler sonuçta görünür.
-- Sefiller görünmez.
--
-- ÖNEMLİ:
-- INNER JOIN iki tabloda ortak olan
-- SÜTUNLARI değil, ON koşulunu sağlayan
-- SATIRLARI eşleştirir.


-- 7. WHERE İLE BİRLEŞTİRME / INNER JOIN

-- YÖNTEM 1: WHERE

SELECT
    k1.KitapAd,
    k2.KitapTur
FROM Kitap AS k1, Kitap2 AS k2
WHERE k1.KitapAd = k2.KitapAdi;


-- YÖNTEM 2: INNER JOIN

SELECT
    k1.KitapAd,
    k2.KitapTur
FROM Kitap AS k1
INNER JOIN Kitap2 AS k2
    ON k1.KitapAd = k2.KitapAdi;

-- Bu iki sorgu aynı eşleştirme
-- koşulunu kullandığından aynı satırları getirir.
--
-- INNER JOIN genellikle daha açık ve
-- okunabilir bir yazım sağlar.
--
-- İlişki koşulu ON ile belirtilir.
-- Ek satır filtreleri WHERE ile yazılabilir.


-- 8. INNER JOIN + WHERE

SELECT
    k1.KitapAd,
    k2.KitapTur,
    k1.KitapFiyat
FROM Kitap AS k1
INNER JOIN Kitap2 AS k2
    ON k1.KitapAd = k2.KitapAdi
WHERE k1.KitapFiyat > 10
ORDER BY k1.KitapFiyat DESC;

-- ON: Satırların nasıl eşleşeceğini belirler.
-- WHERE: Eşleşen sonuçları ayrıca filtreler.
-- ORDER BY: Sonuçları fiyatına göre sıralar.


-- ============================================================
-- 9. INNER JOIN + GROUP BY + SUM
-- ============================================================

SELECT
    k2.KitapTur,
    COUNT(*) AS KitapSayisi,
    SUM(k1.KitapFiyat) AS ToplamFiyat
FROM Kitap AS k1
INNER JOIN Kitap2 AS k2
    ON k1.KitapAd = k2.KitapAdi
GROUP BY k2.KitapTur
ORDER BY k2.KitapTur ASC;

-- Bu sorgu hocanın videodaki
-- GROUP BY örneğinin düzeltilmiş hâlidir.
--
-- ÇALIŞMA MANTIĞI:
--
-- 1. Kitap ve Kitap2 eşleştirilir.
-- 2. Kitapların türleri alınır.
-- 3. Aynı türdeki satırlar gruplandırılır.
-- 4. COUNT(*) her türün kitap kayıtlarını sayar.
-- 5. SUM() her türün toplam fiyatını hesaplar.
-- 6. Sonuçlar kitap türüne göre sıralanır.
--
-- ÖNEMLİ:
-- COUNT(*) burada eşleşmiş satırların sayısıdır.
-- SUM() gerçek satış geliri anlamına gelmez.


-- 10. INNER JOIN + AVG + HAVING

SELECT
    k2.KitapTur,
    COUNT(*) AS KitapSayisi,
    ROUND(AVG(k1.KitapFiyat), 2) AS OrtalamaFiyat
FROM Kitap AS k1
INNER JOIN Kitap2 AS k2
    ON k1.KitapAd = k2.KitapAdi
GROUP BY k2.KitapTur
HAVING COUNT(*) >= 2
ORDER BY OrtalamaFiyat DESC;

-- Her tür için:
-- Kitap sayısını ve ortalama fiyatı hesaplar.
--
-- HAVING COUNT(*) >= 2:
-- En az iki eşleşmiş kayıt içeren
-- tür gruplarını getirir.
--
-- JOIN, GROUP BY ve HAVING aynı sorguda
-- birlikte kullanılabilir.


-- ============================================================
-- 11. ÜÇ TABLOYU INNER JOIN İLE BİRLEŞTİRME
-- ============================================================

SELECT
    k1.KitapAd,
    k1.KitapYazar,
    k2.KitapTur,
    k2.KitapRenk,
    k3.KitapBaski
FROM Kitap AS k1
INNER JOIN Kitap2 AS k2
    ON k1.KitapAd = k2.KitapAdi
INNER JOIN Kitap3 AS k3
    ON k2.KitapRenk = k3.KitapRengi;

-- BİRİNCİ EŞLEŞTİRME:
--
-- k1.KitapAd = k2.KitapAdi
--
-- Kitap ile Kitap2'yi bağlar.
--
-- İKİNCİ EŞLEŞTİRME:
--
-- k2.KitapRenk = k3.KitapRengi
--
-- Kitap2 ile Kitap3'ü bağlar.
--
-- Kitap2, iki tablo arasında bağlantı görevi görür.
--
-- ÜÇ TABLODAKİ EŞLEŞMELER:
-- Her iki ON koşulunu da sağlamalıdır.
--
-- ÖRNEK:
--
-- Kitap    : 'Son Ada'
-- Kitap2   : 'Son Ada', renk = 'sari'
-- Kitap3   : renk = 'sari', baskı = 5
--
-- SONUÇ:
-- Son Ada | Zulfu Livaneli | tiyatro | sari | 5
--
-- NOT:
-- Kitap2'de mavi renkli kitaplar vardır,
-- fakat Kitap3'te mavi renk kaydı yoktur.
--
-- Bu nedenle mavi kitaplar
-- üçlü INNER JOIN sonucuna girmez.


-- 12. ÜÇ TABLOYU WHERE İLE BİRLEŞTİRME

SELECT
    k1.KitapAd,
    k2.KitapTur,
    k3.KitapRengi,
    k3.KitapBaski
FROM Kitap AS k1, Kitap2 AS k2, Kitap3 AS k3
WHERE k1.KitapAd = k2.KitapAdi
  AND k2.KitapRenk = k3.KitapRengi;

-- Burada iki birleştirme koşulu gereklidir.
--
-- Bunlardan birini unutursan
-- istenmeyen satır kombinasyonları oluşabilir.
--
-- Bu sorgu, bir önceki üçlü INNER JOIN
-- sorgusuyla aynı eşleşme mantığını kullanır.


-- ============================================================
-- 13. ÜÇ TABLOYU GRUPLAMA
-- ============================================================

SELECT
    k2.KitapTur,
    k3.KitapRengi,
    COUNT(*) AS KitapSayisi
FROM Kitap AS k1
INNER JOIN Kitap2 AS k2
    ON k1.KitapAd = k2.KitapAdi
INNER JOIN Kitap3 AS k3
    ON k2.KitapRenk = k3.KitapRengi
GROUP BY
    k2.KitapTur,
    k3.KitapRengi
ORDER BY
    k2.KitapTur,
    k3.KitapRengi;

-- Önce üç tablo eşleştirilir.
--
-- Daha sonra kitap türü ve renk
-- birlikte değerlendirilerek gruplama yapılır.
--
-- Örneğin:
-- roman / beyaz
-- roman / siyah
-- hikaye / siyah
--
-- Bunlar farklı gruplardır.
--
-- NOT:
-- GROUP BY KitapTur yazarken, KitapAdi gibi
-- gruptaki her satırda farklı olabilecek sütunları
-- doğrudan SELECT etmek hatalı olabilir.
--
-- MySQL'de ONLY_FULL_GROUP_BY bu tür
-- belirsiz sorguları engelleyebilir.


-- ============================================================
-- DERS 30: LEFT JOIN VE RIGHT JOIN
-- ============================================================

-- 14. INNER JOIN: KARŞILAŞTIRMA İÇİN

SELECT
    k1.KitapAd,
    k2.KitapTur,
    k2.KitapRenk
FROM Kitap AS k1
INNER JOIN Kitap2 AS k2
    ON k1.KitapAd = k2.KitapAdi;

-- Yalnızca iki tabloda eşleşen kayıtlar gelir.
-- Önceki veri setimizde 11 eşleşme vardır.


-- ============================================================
-- 15. LEFT JOIN: SOL TABLONUN TAMAMI
-- ============================================================

SELECT
    k1.KitapAd,
    k2.KitapTur,
    k2.KitapRenk
FROM Kitap AS k1
LEFT JOIN Kitap2 AS k2
    ON k1.KitapAd = k2.KitapAdi;

-- LEFT JOIN:
-- Sol tablodaki tüm satırları korur.
--
-- Burada sol tablo Kitap'tır.
--
-- Kitap2 tablosunda eşleşen kayıt varsa
-- KitapTur ve KitapRenk bilgisi de gelir.
--
-- Eşleşme yoksa sağ tablonun seçilen
-- sütunları NULL olarak görüntülenir.
--
-- ÖRNEK:
--
-- Kitap tablosunda Sefiller var.
-- Kitap2 tablosunda Sefiller yok.
--
-- LEFT JOIN sonucunda:
--
-- Sefiller | NULL | NULL
--
-- satırı da görüntülenir.


-- 16. LEFT JOIN: EŞLEŞMEYENLERİ BULMA

SELECT
    k1.KitapAd,
    k2.KitapAdi
FROM Kitap AS k1
LEFT JOIN Kitap2 AS k2
    ON k1.KitapAd = k2.KitapAdi
WHERE k2.KitapAdi IS NULL;

-- Sol tabloda olup sağ tabloda
-- eşleşmeyen kayıtları getirir.
--
-- Önceki örnek veri setinde:
-- Sefiller
--
-- Eşleşmeyen kayıtların tespitinde
-- çok kullanılan bir sorgu kalıbıdır.


-- ============================================================
-- 17. RIGHT JOIN: SAĞ TABLONUN TAMAMI
-- ============================================================

SELECT
    k1.KitapAd,
    k2.KitapAdi,
    k2.KitapTur,
    k2.KitapRenk
FROM Kitap AS k1
RIGHT JOIN Kitap2 AS k2
    ON k1.KitapAd = k2.KitapAdi;

-- RIGHT JOIN:
-- Sağdaki tablonun tüm satırlarını korur.
--
-- Burada sağ tablo Kitap2'dir.
--
-- Kitap tablosunda eşleşme bulunmazsa
-- k1.KitapAd NULL olur.
--
-- Ancak k2.KitapAdi sağ tablodan geldiği
-- için kitap adını yine görebiliriz.
--
-- ÖNEMLİ:
-- Hazırladığımız mevcut örnek veri setinde
-- Kitap2'nin bütün kayıtları Kitap'ta da vardır.
--
-- Bu nedenle bu sorguda şu anda
-- eşleşmeyen sağ tablo kaydı bulunmuyor.
-- Sonuç sayısı INNER JOIN ile aynı olabilir.


-- 18. RIGHT JOIN İLE SOLDAKİ EŞLEŞMEYEN KAYITLAR

-- Tablo sırasını değiştiriyoruz.
-- Bu sefer sağdaki tablo Kitap olacak.

SELECT
    k1.KitapAd,
    k2.KitapTur,
    k2.KitapRenk
FROM Kitap2 AS k2
RIGHT JOIN Kitap AS k1
    ON k2.KitapAdi = k1.KitapAd;

-- RIGHT JOIN sağdaki Kitap tablosunun
-- tüm satırlarını korur.
--
-- Bu nedenle Sefiller de sonuçta görünür.
--
-- Kitap2 ile eşleşmediğinden:
-- KitapTur = NULL
-- KitapRenk = NULL
--
-- Bu sorgu, yukarıdaki LEFT JOIN ile
-- aynı satırları üretir.


-- ============================================================
-- 19. LEFT JOIN VE RIGHT JOIN EŞDEĞERLİĞİ
-- ============================================================

-- LEFT JOIN:
SELECT
    k1.KitapAd,
    k2.KitapTur
FROM Kitap AS k1
LEFT JOIN Kitap2 AS k2
    ON k1.KitapAd = k2.KitapAdi
ORDER BY k1.KitapNo;

-- Aynı ilişkiyi ters tablo sırasıyla
-- RIGHT JOIN olarak yazabiliriz:

SELECT
    k1.KitapAd,
    k2.KitapTur
FROM Kitap2 AS k2
RIGHT JOIN Kitap AS k1
    ON k2.KitapAdi = k1.KitapAd
ORDER BY k1.KitapNo;

-- İKİ SORGU AYNI SONUCU VERİR.
--
-- Çünkü:
-- İlk sorgu soldaki Kitap tablosunu korur.
-- İkinci sorgu sağdaki Kitap tablosunu korur.
--
-- Korunan tablo her ikisinde de Kitap'tır.


-- ============================================================
-- 20. ÜÇ TABLO İLE LEFT JOIN
-- ============================================================

SELECT
    k1.KitapAd,
    k2.KitapTur,
    k2.KitapRenk,
    k3.KitapBaski
FROM Kitap AS k1
LEFT JOIN Kitap2 AS k2
    ON k1.KitapAd = k2.KitapAdi
LEFT JOIN Kitap3 AS k3
    ON k2.KitapRenk = k3.KitapRengi
ORDER BY k1.KitapNo;

-- Bu sorguda Kitap tablosundaki
-- bütün kayıtları koruyoruz.
--
-- DURUM 1:
-- Kitap2 ve Kitap3'te eşleşme varsa
-- bütün bilgiler gelir.
--
-- DURUM 2:
-- Kitap2'de eşleşme var ama Kitap3'te yoksa
-- KitapBaski NULL olur.
--
-- Örneğin:
-- Beyaz Geceler -> Renk mavi
-- Kitap3'te mavi renk bulunmuyor.
-- Bu nedenle KitapBaski NULL olur.
--
-- DURUM 3:
-- Kitap2'de de eşleşme yoksa
-- KitapTur, KitapRenk ve KitapBaski NULL olur.
--
-- Örneğin:
-- Sefiller -> Kitap2 eşleşmesi yok.


-- ============================================================
-- 21. LEFT JOIN: ON VE WHERE FARKI
-- ============================================================

-- A) Sağ tablodaki türü ON içinde filtreleme:

SELECT
    k1.KitapAd,
    k2.KitapTur
FROM Kitap AS k1
LEFT JOIN Kitap2 AS k2
    ON k1.KitapAd = k2.KitapAdi
   AND k2.KitapTur = 'roman';

-- LEFT JOIN olduğu için Kitap'ın tüm satırları kalır.
-- Türü roman olmayanlarda veya eşleşme yoksa
-- KitapTur NULL görüntülenebilir.


-- B) Türü WHERE içinde filtreleme:

SELECT
    k1.KitapAd,
    k2.KitapTur
FROM Kitap AS k1
LEFT JOIN Kitap2 AS k2
    ON k1.KitapAd = k2.KitapAdi
WHERE k2.KitapTur = 'roman';

-- Burada WHERE, JOIN sonucundan sonra filtreler.
-- NULL KitapTur değerleri koşulu sağlamaz.
--
-- Böylece eşleşmeyen sol tablo satırları elenir.
--
-- SINAVDA ÖNEMLİ:
-- LEFT JOIN içinde ON ile WHERE her zaman
-- aynı sonucu vermez.


-- ============================================================
-- 22. JOIN SONUÇ SAYILARINI KARŞILAŞTIRMA
-- ============================================================

SELECT COUNT(*) AS KitapSayisi
FROM Kitap;

SELECT COUNT(*) AS Kitap2Sayisi
FROM Kitap2;

SELECT COUNT(*) AS Kitap3Sayisi
FROM Kitap3;

SELECT COUNT(*) AS IcBirlesimSayisi
FROM Kitap AS k1
INNER JOIN Kitap2 AS k2
    ON k1.KitapAd = k2.KitapAdi;

SELECT COUNT(*) AS SolBirlesimSayisi
FROM Kitap AS k1
LEFT JOIN Kitap2 AS k2
    ON k1.KitapAd = k2.KitapAdi;

SELECT COUNT(*) AS UcluIcBirlesimSayisi
FROM Kitap AS k1
INNER JOIN Kitap2 AS k2
    ON k1.KitapAd = k2.KitapAdi
INNER JOIN Kitap3 AS k3
    ON k2.KitapRenk = k3.KitapRengi;

-- ÖRNEK VERİ SETİNDE BEKLENEN:
--
-- Kitap              : 12
-- Kitap2             : 11
-- Kitap3             : 6
--
-- CROSS JOIN         : 132
-- İki tablo INNER    : 11
-- Kitap LEFT Kitap2  : 12
-- Üç tablo INNER     : 7
--
-- Bu sayılar mevcut örnek veriler içindir.
-- Tablolardaki kayıtlar değişirse sonuçlar değişir.
--
-- Ayrıca farklı tabloların eşleşen anahtarlarında
-- tekrarlar varsa JOIN satır sayısını artırabilir.


-- ============================================================
-- KONU TEKRARI / VİZE NOTLARI
-- ============================================================

/*
============================================================
1. JOIN NEDİR?
============================================================

JOIN, iki veya daha fazla tablodaki
verileri tek sorguda birleştirmek için kullanılır.

İLİŞKİSEL VERİTABANI MANTIĞI:

Veriler her zaman tek tabloda saklanmaz.

Örneğin:

Kitap:
KitapAd, KitapYazar, KitapFiyat

Kitap2:
KitapAdi, KitapTur, KitapRenk

Kitap3:
KitapRengi, KitapBaski

Bu tabloları JOIN ile ilişkilendirerek
tek sonuç tablosunda gösterebiliriz.

JOIN gerçek tabloları fiziksel olarak
tek tabloya dönüştürmez.

SELECT sorgusu birleşik bir sonuç üretir.


============================================================
2. JOIN TÜRLERİ
============================================================

INNER JOIN:
- Yalnızca eşleşen satırları getirir.

LEFT JOIN:
- Sol tablonun tüm satırlarını korur.
- Sağdan eşleşen bilgileri ekler.
- Eşleşme yoksa sağ taraf NULL olur.

RIGHT JOIN:
- Sağ tablonun tüm satırlarını korur.
- Soldan eşleşen bilgileri ekler.
- Eşleşme yoksa sol taraf NULL olur.

CROSS JOIN:
- Satırların tüm kombinasyonlarını üretir.

FULL OUTER JOIN:
- İki tarafın da eşleşmeyen satırlarını korur.
- MySQL'de doğrudan FULL OUTER JOIN
  sözdizimi desteklenmez.
- Bir sonraki derste alternatifini çalışacağız.


============================================================
3. INNER JOIN MANTIĞI
============================================================

GENEL SÖZDİZİMİ:

SELECT a.Sutun, b.Sutun
FROM TabloA AS a
INNER JOIN TabloB AS b
    ON a.OrtakAlan = b.OrtakAlan;

ON:
İki tablonun satırlarının hangi koşula
göre eşleşeceğini belirtir.

ÖRNEK:

SELECT k1.KitapAd, k2.KitapTur
FROM Kitap k1
INNER JOIN Kitap2 k2
    ON k1.KitapAd = k2.KitapAdi;

İki tabloda kitap adı eşleşirse
ilgili satırlar birleştirilir.

EŞLEŞMEYEN SATIRLAR:
INNER JOIN sonucuna alınmaz.

ÖNEMLİ:
INNER JOIN yalnızca aynı isimli
sütunları birleştirmez.

Sütun isimleri farklı olabilir.
Önemli olan ON koşulunun doğru olmasıdır.


============================================================
4. WHERE İLE BİRLEŞTİRME
============================================================

Eski birleştirme yazımlarından biridir.

ÖRNEK:

SELECT *
FROM Kitap k1, Kitap2 k2
WHERE k1.KitapAd = k2.KitapAdi;

Burada FROM içinde iki tablo yazılır.

WHERE ise eşleştirme koşulunu belirtir.

EŞDEĞER INNER JOIN:

SELECT *
FROM Kitap k1
INNER JOIN Kitap2 k2
    ON k1.KitapAd = k2.KitapAdi;

Bu örneklerde sonuç aynıdır.

ÖNEMLİ:
WHERE koşulunu unutursak
kartezyen çarpım oluşabilir.

İlişkili tabloları birleştirirken
INNER JOIN + ON kullanmak çoğunlukla
daha okunabilir bir yöntemdir.


============================================================
5. CROSS JOIN VE KARTEZYEN ÇARPIM
============================================================

CROSS JOIN, iki tablodaki her satırın
diğer tablodaki her satırla birleşmesini sağlar.

ÖRNEK:

SELECT *
FROM Kitap
CROSS JOIN Kitap2;

Eğer:

Kitap  -> 12 satır
Kitap2 -> 11 satır

ise:

12 * 11 = 132 sonuç satırı oluşur.

CROSS JOIN kendi başına hata değildir.

Ancak iki tabloyu ortak bir alandan
eşleştirmek isterken JOIN koşulunu unutursak
istenmeyen kartezyen çarpım oluşabilir.

SINAVDA:
JOIN koşulu yoksa tüm kombinasyonlara dikkat et.


============================================================
6. LEFT JOIN MANTIĞI
============================================================

GENEL SÖZDİZİMİ:

SELECT *
FROM TabloA a
LEFT JOIN TabloB b
    ON a.ID = b.ID;

Sol tablo TabloA'dır.

Tüm TabloA satırları sonuçta korunur.

Sağ tabloda eşleşme bulunmazsa
sağ tablodan seçilen sütunlar NULL olur.

ÖRNEK:

FROM Kitap k1
LEFT JOIN Kitap2 k2
    ON k1.KitapAd = k2.KitapAdi;

Sefiller sadece Kitap tablosunda varsa:

Sefiller | NULL | NULL

sonucu görülebilir.

ÖNEMLİ:
LEFT JOIN sadece eşleşmeyenleri getirmez.
Eşleşenleri VE soldaki eşleşmeyenleri getirir.


============================================================
7. RIGHT JOIN MANTIĞI
============================================================

GENEL SÖZDİZİMİ:

SELECT *
FROM TabloA a
RIGHT JOIN TabloB b
    ON a.ID = b.ID;

Sağ tablo TabloB'dir.

Tüm TabloB satırları korunur.

Solda eşleşme bulunmayan satırlarda
sol tablonun sütunları NULL olur.

ÖRNEK:

FROM Kitap k1
RIGHT JOIN Kitap2 k2
    ON k1.KitapAd = k2.KitapAdi;

Burada korunan tablo Kitap2'dir.

Eşleşmeyen kayıtları görebilmek için
sağ tablonun sütunlarını da SELECT etmeliyiz.


============================================================
8. LEFT JOIN VE RIGHT JOIN EŞDEĞERLİĞİ
============================================================

A LEFT JOIN B

ile:

B RIGHT JOIN A

aynı eşleştirme koşulları kullanıldığında
aynı satırları üretebilir.

Örneğin:

Kitap LEFT JOIN Kitap2

ile:

Kitap2 RIGHT JOIN Kitap

aynı korunan tabloyu ifade eder.

Tablo sırası tersine çevrilirken
seçilen sütunlara dikkat edilmelidir.

RIGHT JOIN öğrenmek önemlidir.
Ancak pratikte sorguları LEFT JOIN
olarak yeniden yazmak çoğu zaman kolaydır.


============================================================
9. ON VE WHERE FARKI
============================================================

ON:
JOIN satır eşleştirme koşulunu belirtir.

WHERE:
Sorgu sonucundaki satırları filtreler.

INNER JOIN için bazı koşullar ON
veya WHERE içinde yazıldığında
aynı sonucu üretebilir.

Ancak OUTER JOIN için bu
her zaman geçerli değildir.

ÖRNEK:

LEFT JOIN Kitap2 k2
ON k1.KitapAd = k2.KitapAdi
AND k2.KitapTur = 'roman';

Burada sol tablonun satırları korunur.

Fakat:

LEFT JOIN Kitap2 k2
ON k1.KitapAd = k2.KitapAdi
WHERE k2.KitapTur = 'roman';

yazarsak eşleşmeyen ve tür bilgisi NULL
olan satırlar filtrelenir.

SINAVDA:
LEFT/RIGHT JOIN sorgularında
ON ve WHERE koşullarını ayrıca incele.


============================================================
10. ÜÇ TABLOLU JOIN
============================================================

Birden fazla JOIN arka arkaya kullanılabilir.

ÖRNEK:

FROM Kitap k1
INNER JOIN Kitap2 k2
    ON k1.KitapAd = k2.KitapAdi
INNER JOIN Kitap3 k3
    ON k2.KitapRenk = k3.KitapRengi;

BİRİNCİ İLİŞKİ:
Kitap ile Kitap2

İKİNCİ İLİŞKİ:
Kitap2 ile Kitap3

Böylece Kitap -> Kitap2 -> Kitap3
zinciri kurulur.

Üçlü INNER JOIN sonucuna girmek için
iki JOIN koşulunun da sağlanması gerekir.

İki tablo eşleşip üçüncü tablo eşleşmezse
INNER JOIN o kayıtları sonuçtan çıkarır.


============================================================
11. JOIN VE GROUP BY
============================================================

JOIN ile birleştirilen satırlar
GROUP BY ile gruplanabilir.

ÖRNEK:

SELECT
    k2.KitapTur,
    COUNT(*) AS KitapSayisi,
    SUM(k1.KitapFiyat) AS ToplamFiyat
FROM Kitap k1
INNER JOIN Kitap2 k2
    ON k1.KitapAd = k2.KitapAdi
GROUP BY k2.KitapTur;

ÖNCE:
Tablolar ilişkilendirilir.

SONRA:
Kitap türleri gruplandırılır.

SON OLARAK:
COUNT ve SUM her grup için hesaplanır.

ÖNEMLİ:
JOIN sonucu aynı kitabı birden fazla satırda
gösteriyorsa COUNT ve SUM da bu satırlardan
etkilenir. Çoklu eşleşmelerde toplamların
tekrar hesaplanması riskine dikkat et.


============================================================
12. GROUP BY HATALARI
============================================================

HATALI:

GROUP BY KitapAdi
GROUP BY KitapTur;

Aynı sorgu düzeyinde iki ayrı
GROUP BY bölümü kullanılamaz.

DOĞRU:

GROUP BY KitapAdi, KitapTur;

Ancak bu, iki sütunun birleşimine göre
gruplama yapar.

Eğer amaç tür bazında toplam ise:

GROUP BY KitapTur;

kullanılır.

DİĞER HATA:

SELECT KitapAdi, KitapTur, COUNT(*)
...
GROUP BY KitapTur;

KitapAdi, aynı türdeki farklı
kitapları ifade edebilir.

Bu nedenle tek bir KitapAdi
değeri belirlenemeyebilir.

ONLY_FULL_GROUP_BY etkinse
MySQL sorguyu reddedebilir.

ÇÖZÜM:
Sorgunun amacına göre uygun
GROUP BY sütunları ve toplama
fonksiyonları kullanılmalıdır.


============================================================
13. PRIMARY KEY VE FOREIGN KEY
============================================================

PRIMARY KEY (PK):
- Bir tablodaki satırları benzersiz tanımlar.
- Tekrar eden değer kabul etmez.
- NULL olamaz.

FOREIGN KEY (FK):
- Bir tablodaki sütunların başka bir
  tablonun anahtarına referans vermesini sağlar.
- Referans bütünlüğünü korumaya yardımcı olur.

ÖNEMLİ:
JOIN yazmak için mutlaka FOREIGN KEY
kısıtı tanımlanmış olması gerekmez.

İki sütunun değerleri uygun olduğunda
ON ile eşleştirme yapılabilir.

Ancak gerçek ilişkisel veritabanı tasarımında
sayısal kitap kimliği gibi benzersiz anahtarlarla
ilişki kurmak daha güvenilirdir.

Kitap adına göre JOIN yapmanın riskleri:
- Kitap adları değişebilir.
- Aynı ad birden fazla kitapta bulunabilir.
- Yazım farkları eşleşmeyi bozabilir.

Bizim örnek tablolarımız JOIN mantığını
öğrenmek amacıyla hazırlanmıştır.


============================================================
14. JOIN SATIR SAYISI
============================================================

JOIN sonucundaki satır sayısı her zaman
tabloların kayıt sayısına eşit değildir.

Örnek:

TabloA:
ID = 1
ID = 2

TabloB:
ID = 1
ID = 1
ID = 3

INNER JOIN ON A.ID = B.ID:

A'daki ID=1 kaydı, B'deki iki kayıtla eşleşir.

SONUÇ:
2 satır oluşur.

Yani tek bir soldaki satır,
sağda birden fazla satırla eşleşebilir.

SINAVDA:
Eşleşen değerleri tek tek kontrol et.
Sadece tablolardaki toplam satır sayısına bakma.


============================================================
15. EŞLEŞMEYEN KAYITLARI BULMA
============================================================

Sol tabloda bulunup sağda bulunmayanlar:

SELECT k1.KitapAd
FROM Kitap k1
LEFT JOIN Kitap2 k2
    ON k1.KitapAd = k2.KitapAdi
WHERE k2.KitapAdi IS NULL;

Bu sorgu önce LEFT JOIN yapar.

Ardından sağ tarafta eşleşme
bulunmayan satırları filtreler.

Örnek veri setinde:
Sefiller

sonuçta görüntülenir.

NOT:
IS NULL, burada sağ tablonun
eşleşmeyi tanımlayan ve NULL olmayan
anahtar sütununa uygulanmaktadır.


============================================================
16. SIK KARŞILAŞILAN HATALAR
============================================================

1. ON koşulunu unutmak.

2. Tablo takma adlarını karıştırmak.

3. Aynı isimli sütunları tablo adı
   belirtmeden seçmek (ambiguous column).

4. WHERE ile CROSS JOIN farkını anlamamak.

5. INNER JOIN'in eşleşmeyenleri
   de getirdiğini sanmak.

6. LEFT JOIN'in yalnızca
   eşleşmeyen satırları getirdiğini sanmak.

7. RIGHT JOIN'de hangi tablonun
   korunduğunu karıştırmak.

8. JOIN işleminden sonra COUNT veya SUM
   kullanırken çoğalan satırları fark etmemek.

9. GROUP BY ve ORDER BY işlemlerini
   birbiriyle karıştırmak.

10. İki ayrı GROUP BY bölümü yazmak.

11. SELECT içindeki sütunların
    gruplamayla ilişkisini kontrol etmemek.

12. INNER JOIN için doğru olan ON/WHERE
    yerleşiminin LEFT JOIN'de de her zaman
    aynı sonucu vereceğini sanmak.


============================================================
17. MYSQL HATA KODLARI
============================================================

Error 1054:
Unknown column.

Neden:
Sütun adı yanlış yazılmış olabilir.

Error 1052:
Column is ambiguous.

Neden:
Birden fazla tabloda aynı isimli
sütun var, hangi tablo olduğu belirtilmemiş.

Error 1055:
GROUP BY ile uyumsuz sütun seçimi.

Neden:
Seçilen sütun, gruplama sütunları
tarafından belirlenemiyor olabilir.

Error 1146:
Table doesn't exist.

Neden:
Tablo adı veya veritabanı yanlış olabilir.

Error 1064:
SQL sözdizimi hatası.

Neden:
Eksik anahtar kelime, yanlış JOIN
yazımı veya tekrar eden GROUP BY olabilir.


============================================================
18. VİZE İÇİN KISA HATIRLATMA
============================================================

JOIN:
Birden fazla tablodaki verileri birleştirir.

INNER JOIN:
Yalnızca ON koşuluyla eşleşen satırlar.

LEFT JOIN:
Soldaki tüm satırlar + sağdaki eşleşmeler.

RIGHT JOIN:
Sağdaki tüm satırlar + soldaki eşleşmeler.

CROSS JOIN:
Tüm satır kombinasyonları.

ON:
Tabloların nasıl eşleşeceğini belirler.

WHERE:
Satırları filtreler.

AS:
Tablo veya sütuna geçici takma ad verir.

GROUP BY:
Satırları gruplar.

HAVING:
Grupları filtreler.

COUNT:
Sonuç satırlarını sayabilir.

SUM:
Sayısal değerleri toplar.

EN ÖNEMLİ SINAV KURALLARI:

1. Önce hangi tablolara ihtiyaç olduğunu bul.

2. Tabloların hangi sütunlarla
   ilişkilendirileceğini belirle.

3. Eşleşmeyen satırlar gerekli mi?
   INNER / LEFT / RIGHT seçimini buna göre yap.

4. İstenen sütunları SELECT içine yaz.

5. Ek filtreler için WHERE kullan.

6. Grup hesapları isteniyorsa
   GROUP BY ve toplama fonksiyonlarını ekle.

7. Sonucu sıralamak gerekiyorsa ORDER BY ekle.

============================================================
*/
