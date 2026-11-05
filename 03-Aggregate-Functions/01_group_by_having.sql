
-- ============================================================
-- KONU: GROUP BY, HAVING ve Toplama Fonksiyonları
-- KAYNAK: Murat Yücedağ - SQL Ders 25, 26, 27
-- ORTAM: MySQL 8.x / MySQL Workbench
-- ============================================================

-- Bu dosya mevcut çalışma tablolarını kullanır.
-- CREATE, DROP, UPDATE veya DELETE işlemi yapmaz.
--
-- Gerekli tablolar:
-- kitaplık.KitapSorguPratik
-- sql_vize_pratik.Kisiler


-- ============================================================
-- VİDEO 25: GROUP BY / 1
-- ============================================================

USE `kitaplık`;

-- 1. COUNT(*) İLE TOPLAM KAYIT SAYISI

SELECT COUNT(*) AS ToplamKitapKaydi
FROM KitapSorguPratik;

-- COUNT(*):
-- Tablodaki satır sayısını hesaplar.
-- NULL değer bulunan satırları da sayar.


-- 2. YAZARLARA GÖRE KİTAP SAYISI

SELECT
    KitapYazar,
    COUNT(*) AS KitapSayisi
FROM KitapSorguPratik
GROUP BY KitapYazar;

-- GROUP BY:
-- Aynı yazar adına sahip kayıtları gruplar.
--
-- COUNT(*):
-- Her grupta kaç satır bulunduğunu hesaplar.
--
-- AS:
-- Hesaplanan sütuna geçici isim verir.


-- 3. KİTAP ADLARINA GÖRE KAYIT SAYISI

SELECT
    KitapAd,
    COUNT(*) AS AyniAdliKayitSayisi
FROM KitapSorguPratik
GROUP BY KitapAd
ORDER BY AyniAdliKayitSayisi DESC;

-- Aynı isimli kitap kayıtlarını gruplar.
-- Örneğimizde Sırça Köşk iki kayıtta yer alır.
--
-- DİKKAT:
-- COUNT(*) gerçek stok miktarı değildir.
-- Yalnızca tablodaki kayıt sayısını hesaplar.


-- 4. YAYINEVLERİNE GÖRE KİTAP SAYISI

SELECT
    KitapYayinEvi,
    COUNT(*) AS KitapSayisi
FROM KitapSorguPratik
GROUP BY KitapYayinEvi
ORDER BY KitapYayinEvi ASC;

-- Aynı yayınevindeki kitap kayıtlarını
-- tek grup altında toplar.
--
-- NULL yayınevi değerleri de
-- ayrı bir grup oluşturabilir.


-- 5. SUM: TOPLAM FİYAT HESAPLAMA

SELECT
    KitapYayinEvi,
    SUM(KitapFiyat) AS ToplamFiyat
FROM KitapSorguPratik
GROUP BY KitapYayinEvi;

-- SUM:
-- Her yayınevindeki kitap kayıtlarının
-- fiyatlarını toplar.
--
-- ÖNEMLİ:
-- Bu değer satış geliri değildir.
-- Yalnızca kayıt fiyatlarının toplamıdır.


-- 6. AVG: ORTALAMA FİYAT HESAPLAMA

SELECT
    KitapYayinEvi,
    ROUND(AVG(KitapFiyat), 2) AS OrtalamaFiyat
FROM KitapSorguPratik
GROUP BY KitapYayinEvi;

-- AVG:
-- Sayısal değerlerin ortalamasını hesaplar.
--
-- ROUND(..., 2):
-- Sonucu iki ondalık basamağa yuvarlar.


-- 7. MIN VE MAX: EN DÜŞÜK / YÜKSEK FİYAT

SELECT
    KitapYayinEvi,
    MIN(KitapFiyat) AS EnDusukFiyat,
    MAX(KitapFiyat) AS EnYuksekFiyat
FROM KitapSorguPratik
GROUP BY KitapYayinEvi;

-- MIN: Her grubun en küçük fiyatını getirir.
-- MAX: Her grubun en büyük fiyatını getirir.


-- 8. BİRDEN FAZLA TOPLAMA FONKSİYONU

SELECT
    KitapYayinEvi,
    COUNT(*) AS KitapSayisi,
    SUM(KitapFiyat) AS ToplamFiyat,
    ROUND(AVG(KitapFiyat), 2) AS OrtalamaFiyat,
    MIN(KitapFiyat) AS EnDusukFiyat,
    MAX(KitapFiyat) AS EnYuksekFiyat
FROM KitapSorguPratik
GROUP BY KitapYayinEvi
ORDER BY KitapSayisi DESC, KitapYayinEvi ASC;

-- Aynı sorguda birden fazla toplama
-- fonksiyonu kullanılabilir.


-- ============================================================
-- 9. COUNT(*) VE COUNT(SÜTUN) FARKI
-- ============================================================

SELECT
    COUNT(*) AS ToplamKayit,
    COUNT(KitapYayinEvi) AS YayinEviDoluKayit
FROM KitapSorguPratik;

-- COUNT(*):
-- Tüm satırları sayar.
--
-- COUNT(KitapYayinEvi):
-- Yalnızca yayınevi NULL olmayanları sayar.


-- 10. COUNT(DISTINCT)

SELECT
    COUNT(DISTINCT KitapYazar) AS FarkliYazarSayisi
FROM KitapSorguPratik;

-- Aynı yazar birden fazla kez bulunsa bile
-- yalnızca bir kez sayılır.
-- NULL değerler sayıya dahil edilmez.


-- ============================================================
-- VİDEO 26: GROUP BY / 2 - KİŞİLER TABLOSU
-- ============================================================

USE sql_vize_pratik;

-- Önceki derste oluşturduğumuz 30 kişilik tablo.
SELECT * FROM Kisiler;


-- 11. MESLEKLERE GÖRE KİŞİ SAYISI

SELECT
    Meslek,
    COUNT(*) AS `Personel Sayısı`
FROM Kisiler
GROUP BY Meslek
ORDER BY COUNT(*) ASC;

-- Aynı mesleğe sahip kişileri gruplar.
-- Her meslekte kaç kişi bulunduğunu hesaplar.
-- Sonuçları kişi sayısına göre artan sıralar.


-- 12. MESLEKLERE GÖRE TOPLAM MAAŞ

SELECT
    Meslek,
    COUNT(*) AS `Personel Sayısı`,
    SUM(Maas) AS `Toplam Maaş`
FROM Kisiler
GROUP BY Meslek;

-- Meslek gruplarının toplam maaşlarını hesaplar.
-- COUNT(*) kişi sayısını,
-- SUM(Maas) maaş toplamını gösterir.


-- 13. MESLEKLERE GÖRE ORTALAMA MAAŞ

SELECT
    Meslek,
    COUNT(*) AS `Personel Sayısı`,
    SUM(Maas) AS `Toplam Maaş`,
    ROUND(AVG(Maas), 2) AS `Ortalama Maaş`
FROM Kisiler
GROUP BY Meslek
ORDER BY `Ortalama Maaş` DESC;

-- AVG(Maas):
-- Her mesleğin ortalama maaşını hesaplar.
--
-- ROUND:
-- Sonucu iki ondalık basamağa yuvarlar.


-- 14. ŞEHİRLERE GÖRE ÇALIŞAN SAYISI

SELECT
    Sehir,
    COUNT(*) AS KisiSayisi
FROM Kisiler
GROUP BY Sehir
ORDER BY KisiSayisi DESC;

-- Aynı şehirde yaşayan kişileri gruplar.
-- Şehir başına kişi sayısını hesaplar.


-- 15. BİRDEN FAZLA SÜTUNLA GROUP BY

SELECT
    Sehir,
    Meslek,
    COUNT(*) AS KisiSayisi
FROM Kisiler
GROUP BY Sehir, Meslek
ORDER BY Sehir ASC, Meslek ASC;

-- Gruplar Sehir + Meslek ikilisine göre oluşur.
--
-- Örneğin:
-- Trabzon / Mühendis ayrı bir gruptur.
-- Ankara / Mühendis başka bir gruptur.


-- ============================================================
-- VİDEO 27: HAVING KULLANIMI
-- ============================================================

-- 16. HAVING: GRUP SAYISINA GÖRE FİLTRELEME

SELECT
    Meslek,
    COUNT(*) AS KisiSayisi
FROM Kisiler
GROUP BY Meslek
HAVING COUNT(*) > 2
ORDER BY KisiSayisi DESC;

-- Önce aynı meslekteki kişiler gruplandırılır.
-- Ardından 2'den fazla kişisi olan
-- meslek grupları seçilir.
--
-- HAVING, gruplama sonrasında filtreleme yapar.


-- 17. ORTALAMA MAAŞA GÖRE HAVING

SELECT
    Meslek,
    ROUND(AVG(Maas), 2) AS OrtalamaMaas
FROM Kisiler
GROUP BY Meslek
HAVING AVG(Maas) > 60000
ORDER BY OrtalamaMaas DESC;

-- Ortalama maaşı 60000'den fazla
-- olan meslek gruplarını getirir.


-- 18. SUM İLE HAVING

SELECT
    Sehir,
    SUM(Maas) AS ToplamMaas
FROM Kisiler
GROUP BY Sehir
HAVING SUM(Maas) > 100000
ORDER BY ToplamMaas DESC;

-- Toplam maaş miktarı 100000'i aşan
-- şehir gruplarını getirir.


-- ============================================================
-- 19. WHERE VE HAVING BİRLİKTE
-- ============================================================

SELECT
    Meslek,
    COUNT(*) AS KisiSayisi,
    ROUND(AVG(Maas), 2) AS OrtalamaMaas
FROM Kisiler
WHERE Maas >= 50000
GROUP BY Meslek
HAVING COUNT(*) >= 2
ORDER BY OrtalamaMaas DESC;

-- ÇALIŞMA MANTIĞI:
--
-- 1. WHERE ile maaşı en az 50000 olan
--    kişiler seçilir.
--
-- 2. GROUP BY ile kişiler mesleklerine
--    göre gruplandırılır.
--
-- 3. HAVING ile en az iki kişi içeren
--    gruplar seçilir.
--
-- 4. ORDER BY ile ortalamaya göre sıralanır.
--
-- ÖNEMLİ:
-- WHERE satırları, HAVING grupları filtreler.


-- ============================================================
-- 20. HAVING: VİDEODAKİ VERGİ ÖRNEĞİ
-- ============================================================

USE `kitaplık`;

-- Videodaki örnekte Vergi sütunu kullanılıyordu.
-- Ancak KitapSorguPratik tablomuzda Vergi yok.
--
-- Bu nedenle gerçek tabloyu değiştirmeden
-- örnek olarak %10 varsayımsal vergi hesaplayacağız.
--
-- UYARI:
-- Bu oran gerçek bir vergi kuralı değildir.
-- Sadece GROUP BY / HAVING pratiği içindir.

SELECT
    KitapYayinEvi,
    COUNT(*) AS KitapSayisi,
    SUM(KitapFiyat) AS BrutTutar,
    ROUND(SUM(KitapFiyat) * 0.10, 2) AS VarsayilanVergi,
    ROUND(SUM(KitapFiyat) * 0.90, 2) AS NetTutar
FROM KitapSorguPratik
GROUP BY KitapYayinEvi
HAVING SUM(KitapFiyat) * 0.90 > 100
ORDER BY NetTutar DESC;

-- BrutTutar:
-- Her yayınevindeki fiyat toplamı.
--
-- VarsayilanVergi:
-- Toplam fiyatın %10'u.
--
-- NetTutar:
-- Toplam fiyatın %90'ı.
--
-- HAVING:
-- Net tutarı 100'den fazla olan
-- yayınevi gruplarını seçer.
--
-- NOT:
-- Hesaplamalar SELECT sonucunda yapılır.
-- Kitap fiyatlarını değiştirmez.


-- ============================================================
-- 21. HAVING İLE BİRDEN FAZLA KOŞUL
-- ============================================================

SELECT
    KitapYayinEvi,
    COUNT(*) AS KitapSayisi,
    SUM(KitapFiyat) AS ToplamFiyat
FROM KitapSorguPratik
GROUP BY KitapYayinEvi
HAVING COUNT(*) >= 2
   AND SUM(KitapFiyat) > 100
ORDER BY ToplamFiyat DESC;

-- En az iki kitap kaydı bulunan
-- VE toplam fiyatı 100'den yüksek olan
-- yayınevlerini getirir.


-- ============================================================
-- KONU TEKRARI / VİZE NOTLARI
-- ============================================================

/*
============================================================
1. GROUP BY NEDİR?
============================================================

GROUP BY, aynı değere sahip satırları
belirli gruplar altında toplar.

Özellikle COUNT, SUM, AVG, MIN ve MAX gibi
toplama fonksiyonlarıyla kullanılır.

GENEL KULLANIM:

SELECT Sutun, COUNT(*)
FROM Tablo
GROUP BY Sutun;

ÖRNEK:

SELECT Meslek, COUNT(*)
FROM Kisiler
GROUP BY Meslek;

ÇALIŞMA MANTIĞI:

1. Kisiler tablosu okunur.
2. Aynı mesleğe sahip satırlar gruplandırılır.
3. COUNT(*) her gruptaki satırları sayar.
4. Her meslek için bir sonuç satırı oluşur.

ÖNEMLİ:

GROUP BY kayıtları silmez veya değiştirmez.
Yalnızca sorgu sonucunu gruplar.


============================================================
2. COUNT FONKSİYONU
============================================================

COUNT(*):
Bütün satırları sayar.

COUNT(Sutun):
Sadece o sütundaki NULL olmayan
değerleri sayar.

COUNT(DISTINCT Sutun):
NULL olmayan farklı değerleri sayar.

ÖRNEK:

SELECT COUNT(*)
FROM Kisiler;

Toplam satır sayısını verir.

SELECT COUNT(DISTINCT Meslek)
FROM Kisiler;

Farklı meslek sayısını verir.

ÖNEMLİ AYRIM:

COUNT(*) satır sayısıdır.

Kitap tablosunda COUNT(*) kullanmak,
fiziksel kitap stok miktarını otomatik
olarak hesaplamaz.

Stok miktarı ayrı bir sütunda saklanıyorsa
ona uygun toplama işlemi gerekir.


============================================================
3. SUM FONKSİYONU
============================================================

SUM, sayısal değerlerin toplamını hesaplar.

ÖRNEK:

SELECT Meslek, SUM(Maas)
FROM Kisiler
GROUP BY Meslek;

Her mesleğin toplam maaşını getirir.

SUM yalnızca NULL olmayan
sayısal değerleri toplar.

ÖNEMLİ:

SUM(KitapFiyat) toplam fiyatı verir.
Bu tek başına satış geliri anlamına gelmez.

Gelir hesaplamak için satış adedi,
satış tutarı gibi veriler de gerekebilir.


============================================================
4. AVG FONKSİYONU
============================================================

AVG, sayısal değerlerin ortalamasını
hesaplar.

ÖRNEK:

SELECT Meslek, AVG(Maas)
FROM Kisiler
GROUP BY Meslek;

Her mesleğin ortalama maaşını getirir.

GENEL MANTIK:

Ortalama = Toplam / Değer Sayısı

AVG yalnızca NULL olmayan değerleri
hesaplamaya dahil eder.

ROUND(AVG(Maas), 2):

Sonucu iki ondalık basamağa yuvarlar.

DİKKAT:

AVG = Ortalama
SUM = Toplam

Bu iki fonksiyon farklı sonuçlar üretir.


============================================================
5. MIN VE MAX FONKSİYONLARI
============================================================

MIN:
Bir gruptaki en küçük değeri getirir.

MAX:
Bir gruptaki en büyük değeri getirir.

ÖRNEK:

SELECT
    Meslek,
    MIN(Maas) AS EnDusukMaas,
    MAX(Maas) AS EnYuksekMaas
FROM Kisiler
GROUP BY Meslek;

Her meslekteki en düşük ve
en yüksek maaşı hesaplar.

MIN ve MAX metinsel ve tarihsel
verilerde de kullanılabilir.


============================================================
6. WHERE VE HAVING FARKI
============================================================

WHERE:
Gruplama öncesinde satırları filtreler.

HAVING:
Gruplama sonrasında grupları filtreler.

ÖRNEK:

SELECT Meslek, COUNT(*)
FROM Kisiler
WHERE Maas > 50000
GROUP BY Meslek
HAVING COUNT(*) > 2;

ÇALIŞMA SIRASI:

1. FROM -> Tablo belirlenir.
2. WHERE -> Satırlar filtrelenir.
3. GROUP BY -> Gruplar oluşturulur.
4. HAVING -> Gruplar filtrelenir.
5. SELECT -> Sonuç ifadeleri hesaplanır.
6. ORDER BY -> Sonuçlar sıralanır.

Bu sıra, sorgunun mantıksal işlenişinin
basitleştirilmiş anlatımıdır.

Veritabanı motoru fiziksel olarak
farklı optimizasyonlar yapabilir.

EN ÖNEMLİ SINAV BİLGİSİ:

WHERE -> Satır filtresi.
HAVING -> Grup filtresi.


============================================================
7. NEDEN COUNT(*) WHERE İÇİNDE KULLANILMAZ?
============================================================

HATALI:

SELECT Meslek, COUNT(*)
FROM Kisiler
WHERE COUNT(*) > 2
GROUP BY Meslek;

COUNT(*) bir toplama fonksiyonudur.
Bu aşamada gruplama henüz yapılmamıştır.

DOĞRU:

SELECT Meslek, COUNT(*)
FROM Kisiler
GROUP BY Meslek
HAVING COUNT(*) > 2;

COUNT(*) sonucuna göre
gruplar HAVING ile filtrelenir.

NOT:
Toplama sonucunu önce ayrı bir alt sorguda
hesaplayıp dış sorguda WHERE ile filtrelemek
mümkündür. Bunu ileride öğreneceğiz.


============================================================
8. GROUP BY VE DISTINCT FARKI
============================================================

DISTINCT:
Seçilen sonuç satırlarını tekilleştirir.

GROUP BY:
Satırları gruplara ayırır ve
grup bazında hesaplama yapılmasını sağlar.

ÖRNEK:

SELECT DISTINCT Meslek
FROM Kisiler;

Farklı meslekleri listeler.

SELECT Meslek, COUNT(*)
FROM Kisiler
GROUP BY Meslek;

Her mesleğin kaç kişide bulunduğunu
hesaplar.

İkisi bazı sorgularda aynı görünen
değerleri döndürebilir, ancak
kullanım amaçları farklıdır.


============================================================
9. BİRDEN FAZLA SÜTUNLA GROUP BY
============================================================

ÖRNEK:

SELECT Sehir, Meslek, COUNT(*)
FROM Kisiler
GROUP BY Sehir, Meslek;

Gruplama Sehir + Meslek birleşimine göre yapılır.

Trabzon / Mühendis
Ankara / Mühendis

iki farklı gruptur.

Birden fazla sütunla GROUP BY kullanıldığında
aynı grup için bütün grup sütunlarının
değerleri eşleşmelidir.


============================================================
10. GROUP BY VE SELECT KURALI
============================================================

MySQL'de ONLY_FULL_GROUP_BY varsayılan
olarak etkindir.

Gruplu sorguda SELECT içinde kullanılan
toplama dışı sütunlar, genel olarak
GROUP BY içinde bulunmalıdır.

İSTİSNA:
Gruplanan sütunlara işlevsel bağımlılığı
kanıtlanabilen sütunlara izin verilebilir.

YANLIŞ ÖRNEK:

SELECT Meslek, Ad, COUNT(*)
FROM Kisiler
GROUP BY Meslek;

Bir meslekte birden fazla ad olabilir.
MySQL hangi adı göstereceğini belirleyemez.

DOĞRU:

SELECT Meslek, COUNT(*)
FROM Kisiler
GROUP BY Meslek;

YA DA:

SELECT Meslek, Ad, COUNT(*)
FROM Kisiler
GROUP BY Meslek, Ad;

İkinci sorgu, meslek ve ada göre
gruplama yaptığı için farklı sonuçlar üretir.

ONLY_FULL_GROUP_BY kontrolünü kapatmak
yerine doğru gruplama yazmayı öğrenmeliyiz.


============================================================
11. NULL VE TOPLAMA FONKSİYONLARI
============================================================

COUNT(*) NULL içeren satırları da sayar.

COUNT(Sutun) NULL değerlerini saymaz.

SUM(Sutun) NULL değerlerini toplamaz.

AVG(Sutun) NULL değerlerini
ortalama hesabına katmaz.

MIN ve MAX NULL değerlerini dikkate almaz.

GROUP BY:
NULL olan grup anahtarı değerlerini
aynı grup içinde değerlendirebilir.

ÖRNEK:

SELECT KitapYayinEvi, COUNT(*)
FROM KitapSorguPratik
GROUP BY KitapYayinEvi;

Yayınevi NULL olan kitaplar da
ayrı bir grup oluşturabilir.


============================================================
12. HAVING İLE HESAPLAMA
============================================================

HAVING, gruplama sonucunda hesaplanan
değerler üzerinde koşul kurabilir.

ÖRNEK:

SELECT
    Meslek,
    AVG(Maas) AS Ortalama
FROM Kisiler
GROUP BY Meslek
HAVING AVG(Maas) > 50000;

Ortalama maaşı 50000 üzerinde
olan meslek gruplarını getirir.

Birden fazla koşul için:

HAVING COUNT(*) > 2
AND SUM(Maas) > 100000;

kullanılabilir.

HAVING yalnızca COUNT için değildir.
SUM, AVG, MIN ve MAX ile de kullanılabilir.


============================================================
13. VERGİ ÖRNEĞİ VE HESAPLANMIŞ SÜTUNLAR
============================================================

Video örneğinde SUM(Vergi) kullanılıyordu.

Ancak kullandığımız kitap tablosunda
Vergi isimli bir sütun yok.

Bu nedenle doğrudan:

SUM(Vergi)

yazarsak Unknown column hatası oluşur.

Alternatif olarak:

SUM(KitapFiyat) * 0.10

ifadesiyle toplam fiyatın %10'unu
varsayımsal bir tutar olarak hesaplayabiliriz.

Net tutar örneği:

SUM(KitapFiyat) * 0.90

Bu işlem yeni sütun oluşturmaz.
Gerçek tablo verilerini de değiştirmez.

ÖNEMLİ:

Hesaplanan değerin anlamını doğru belirt.
Varsayımsal bir tutarı gerçek vergi ya da
gerçek satış geliri olarak değerlendirme.


============================================================
14. SQL SÖZDİZİMİ SIRASI
============================================================

Genel yazım sırası:

SELECT Sutun, COUNT(*)
FROM Tablo
WHERE SatirKosulu
GROUP BY Sutun
HAVING GrupKosulu
ORDER BY Sutun ASC;

ÖNEMLİ:

WHERE, GROUP BY'dan önce yazılır.

HAVING, GROUP BY'dan sonra yazılır.

ORDER BY genellikle sorgunun
sonuç sıralama bölümüdür.

MySQL'de LIMIT kullanılıyorsa
ORDER BY'dan sonra yazılır.


============================================================
15. SIK YAPILAN HATALAR
============================================================

1. GROUP BY ile ORDER BY'ı karıştırmak.

GROUP BY -> Gruplama.
ORDER BY -> Sıralama.

2. SUM ve AVG fonksiyonlarını karıştırmak.

3. COUNT(Ad) ile COUNT(*) değerlerinin
   her zaman aynı olacağını sanmak.

4. COUNT(*) değerini otomatik olarak
   stok miktarı kabul etmek.

5. HAVING yerine WHERE içinde
   COUNT(*) koşulu yazmak.

6. GROUP BY yapılan sütunlar dışındaki
   alanları yanlış biçimde SELECT etmek.

7. NULL değerlerinin toplama
   fonksiyonlarındaki etkisini unutmak.

8. Olmayan Vergi sütununa SUM uygulamak.

9. SELECT içindeki hesaplanan sütunlar
   arasına virgül koymayı unutmak.

10. HAVING koşulunun bütün satırlara
    ayrı ayrı uygulandığını sanmak.


============================================================
16. VİZE İÇİN KISA HATIRLATMA
============================================================

GROUP BY -> Satırları gruplar.
HAVING   -> Grupları filtreler.
WHERE    -> Satırları filtreler.

COUNT(*) -> Satır sayısı.
SUM()    -> Sayısal toplam.
AVG()    -> Ortalama.
MIN()    -> En küçük değer.
MAX()    -> En büyük değer.

ROUND(x, 2) -> İki ondalık basamağa yuvarlar.

COUNT(DISTINCT Sutun):
Farklı ve NULL olmayan değerleri sayar.

EN ÖNEMLİ AYRIMLAR:

WHERE ile HAVING aynı şey değildir.

COUNT(*) ile COUNT(Sutun) her zaman
aynı sonucu vermez.

GROUP BY ile ORDER BY aynı şey değildir.

SUM ile AVG aynı şey değildir.

GRUPLAMA SORULARINDA:

Önce hangi satırların seçileceğini,
sonra hangi sütuna göre gruplama yapılacağını,
son olarak hangi grupların kalacağını düşün.

============================================================
*/
