
-- ============================================================
-- KONU: LIKE, NOT LIKE ve Desen Arama
-- KAYNAK: Murat Yücedağ - SQL Ders 20
-- ORTAM: MySQL 8.x / MySQL Workbench
-- ============================================================

USE `kitaplık`;

-- Önceki derste oluşturduğumuz tablo:
SELECT * FROM KitapSorguPratik;


-- ============================================================
-- 1. LIKE: METİN İÇİNDE KARAKTER ARAMA
-- ============================================================

-- Adının herhangi bir yerinde 'a' bulunan kitaplar.

SELECT *
FROM KitapSorguPratik
WHERE KitapAd LIKE '%a%';

-- % işareti sıfır veya daha fazla karakteri temsil eder.
-- Metnin başında, ortasında veya sonunda 'a' olabilir.


-- 2. ADINDA 'b' HARFİ BULUNAN KİTAPLAR

SELECT *
FROM KitapSorguPratik
WHERE KitapAd LIKE '%b%';

-- Hiçbir kayıt koşulu sağlamıyorsa sonuç boş gelir.
-- Bu durum sorgunun hatalı olduğu anlamına gelmez.


-- 3. BELİRLİ HARFLE BAŞLAYANLAR

SELECT *
FROM KitapSorguPratik
WHERE KitapAd LIKE 'a%';

-- İlk karakter a olmalıdır.
-- Devamında sıfır veya daha fazla karakter olabilir.


-- 4. BELİRLİ HARFLE BİTENLER

SELECT *
FROM KitapSorguPratik
WHERE KitapAd LIKE '%b';

-- Son karakter b olmalıdır.
-- Öncesinde herhangi bir uzunlukta metin bulunabilir.


-- ============================================================
-- 5. MYSQL VE MSSQL ARASINDAKİ ÖNEMLİ FARK
-- ============================================================

-- SQL Server'da:
-- WHERE KitapAd LIKE '[ab]%';

-- Bu desen SQL Server'da a veya b ile başlayan
-- metinleri bulmak için kullanılabilir.
--
-- MySQL LIKE içinde [ab] joker karakter değildir.
-- Dolayısıyla aynı anlamda KULLANILAMAZ.

-- MySQL'de doğru alternatif:

SELECT *
FROM KitapSorguPratik
WHERE KitapAd LIKE 'a%'
   OR KitapAd LIKE 'b%';

-- İki başlangıç koşulundan biri sağlanmalıdır.


-- 6. REGEXP İLE ALTERNATİF DESEN ARAMA

SELECT *
FROM KitapSorguPratik
WHERE KitapAd REGEXP '^[ab]';

-- REGEXP: Düzenli ifade ile desen eşleştirir.
-- ^ : Metnin başlangıcı.
-- [ab] : a veya b karakteri.
--
-- Not: Büyük/küçük harf davranışı kullanılan
-- karakter seti ve collation ayarına bağlıdır.


-- ============================================================
-- 7. ALT ÇİZGİ (_) İLE KARAKTER SAYISI
-- ============================================================

SELECT *
FROM KitapSorguPratik
WHERE KitapAd LIKE 'M____';

-- M harfiyle başlayan ve toplam 5 karakter
-- uzunluğunda olan kitap adlarını arar.
--
-- M + 4 alt çizgi = 5 karakter.
-- Örnek verilerimizde Masal eşleşebilir.


-- 8. SABİT UZUNLUKTAKİ METİN

SELECT 'elmas' LIKE 'e____' AS Eslesme;

-- Sonuç 1 olur:
-- e l m a s -> Toplam 5 karakter.
--
-- LIKE 'e____' deseninde:
-- e = İlk karakter sabit.
-- ____ = Tam olarak dört ek karakter.


-- 9. İKİNCİ KARAKTERE GÖRE ARAMA

SELECT *
FROM KitapSorguPratik
WHERE KitapAd LIKE '_a%';

-- İlk karakter herhangi biri olabilir.
-- İkinci karakter a olmalıdır.
-- Geri kalan karakter sayısı serbesttir.


-- ============================================================
-- 10. NOT LIKE: DESENE UYMAYANLAR
-- ============================================================

SELECT *
FROM KitapSorguPratik
WHERE KitapAd NOT LIKE '%a%';

-- Adında a harfi bulunmayan kitapları arar.
-- KitapAd NULL olsaydı bu koşul onu getirmezdi.


-- 11. LIKE VE AND BİRLİKTE

SELECT KitapAd, KitapFiyat
FROM KitapSorguPratik
WHERE KitapAd LIKE '%a%'
  AND KitapFiyat > 50;

-- Adında a bulunan ve fiyatı 50'den büyük
-- olan kayıtları seçer.


-- ============================================================
-- KONU TEKRARI / VİZE NOTLARI
-- ============================================================

/*
============================================================
1. LIKE NEDİR?
============================================================

LIKE, metinsel değerleri belirli bir desene
göre sorgulamak için kullanılır.

GENEL KULLANIM:

SELECT *
FROM Tablo
WHERE Sutun LIKE 'Desen';

LIKE, WHERE koşuluyla birlikte kullanılır.

Örneğin:

WHERE KitapAd LIKE '%a%';

Kitap adının içinde a bulunanları arar.

ÖNEMLİ:
LIKE, metnin bir desene uyup uymadığını
kontrol eder. Metni değiştirmez.


============================================================
2. % JOKER KARAKTERİ
============================================================

% sıfır veya daha fazla karakter demektir.

LIKE 'a%'
-> a ile başlayanlar.

LIKE '%a'
-> a ile bitenler.

LIKE '%a%'
-> herhangi bir yerinde a bulunanlar.

LIKE '%abc%'
-> içinde abc dizisi bulunanlar.

LIKE '%'
-> NULL olmayan her metinle eşleşir.

% boş karakter dizisiyle de eşleşebilir.

ÖNEMLİ:
'%a%' ifadesi, yalnızca tek başına a
harfini değil, içinde a bulunan daha uzun
metinleri de kapsar.


============================================================
3. _ JOKER KARAKTERİ
============================================================

_ tam olarak bir karakteri temsil eder.

ÖRNEK:

LIKE 'a_'
-> a ile başlayan, toplam 2 karakter.

LIKE 'a__'
-> a ile başlayan, toplam 3 karakter.

LIKE '_a%'
-> ikinci karakteri a olanlar.

LIKE 'e____'
-> e ile başlayan, toplam 5 karakter.

% ve _ FARKI:

% -> Sıfır veya daha fazla karakter.
_ -> Tam olarak bir karakter.

DİKKAT:

LIKE 'e____' ile LIKE 'e%' aynı değildir.

İlkinde toplam uzunluk 5 karakterdir.
İkincisinde uzunluk sabit değildir.


============================================================
4. MSSQL - MYSQL FARKI
============================================================

SQL SERVER:

LIKE '[ab]%'

SQL Server'da a veya b ile başlayan
metinler için kullanılabilir.

MYSQL:

LIKE '[ab]%'

Bu ifade MySQL'de aynı anlama gelmez.

MySQL LIKE içinde köşeli parantez
bir karakter kümesi belirtmez.

MYSQL ALTERNATİFİ:

WHERE Sutun LIKE 'a%'
   OR Sutun LIKE 'b%';

VEYA:

WHERE Sutun REGEXP '^[ab]';

REGEXP düzenli ifade desteği sağlar.

^    -> Metnin başlangıcı.
[ab] -> a veya b karakteri.

VİZEDE:
Kullanılan veritabanı sistemine dikkat et.


============================================================
5. NOT LIKE
============================================================

LIKE:
Desene uyan kayıtları arar.

NOT LIKE:
Desene uymayan kayıtları arar.

ÖRNEK:

WHERE KitapAd NOT LIKE '%a%';

Kitap adında a bulunmayanları arar.

NULL DEĞERLER:

NULL LIKE '%a%' sonucu UNKNOWN olur.
NULL NOT LIKE '%a%' da UNKNOWN olur.

WHERE yalnızca TRUE olanları getirir.

NULL kayıtlarını ayrıca getirmek için
IS NULL koşulu kullanılmalıdır.


============================================================
6. BÜYÜK/KÜÇÜK HARF DUYARLILIĞI
============================================================

MySQL'de LIKE karşılaştırmalarının
büyük/küçük harf duyarlılığı, kullanılan
collation ayarına bağlıdır.

Örneğin bazı collations için:

LIKE 'a%'
ve
LIKE 'A%'

aynı sonuçları verebilir.

Ancak tüm MySQL veritabanlarında
bu durumun aynı olduğunu varsayma.

Karakter seti ve collation,
metin karşılaştırmalarını etkiler.


============================================================
7. LIKE İLE EŞİTLİK FARKI
============================================================

WHERE KitapAd = 'Masal';

Tam değer eşitliğini kontrol eder.

WHERE KitapAd LIKE '%Masal%';

Masal ifadesini içinde barındıran
metinlerle eşleşir.

Örneğin:

Masal
Masallar
Bir Masal

İkinci sorgunun desenine uyabilir.

Ancak karşılaştırma collation
kurallarına göre değerlendirilir.


============================================================
8. SIK YAPILAN HATALAR
============================================================

1. LIKE yazmayı unutmak.

YANLIŞ:
WHERE KitapAd '%a%';

DOĞRU:
WHERE KitapAd LIKE '%a%';

2. % ile _ karakterlerini karıştırmak.

3. SQL Server'daki [ab] sözdizimini
   MySQL LIKE içinde kullanmak.

4. LIKE sonucunda hiçbir kayıt
   gelmediğinde SQL'in bozuk olduğunu sanmak.

5. Büyük/küçük harf davranışının
   her veritabanında aynı olduğunu sanmak.

6. NULL değerlerinin NOT LIKE ile
   otomatik olarak geleceğini düşünmek.


============================================================
9. VİZE İÇİN KISA HATIRLATMA
============================================================

LIKE       -> Desene uyanları bulur.
NOT LIKE   -> Desene uymayanları bulur.

%          -> Sıfır veya daha fazla karakter.
_          -> Tam olarak bir karakter.

'a%'       -> a ile başlayan.
'%a'       -> a ile biten.
'%a%'      -> İçinde a bulunan.
'_a%'      -> İkinci karakteri a olan.
'a__'      -> a ile başlayan 3 karakterli metin.

REGEXP     -> Düzenli ifade ile desen arama.

EN ÖNEMLİ KURAL:

MySQL LIKE ile SQL Server LIKE
sözdizimlerini tamamen aynı varsayma.

============================================================
*/
