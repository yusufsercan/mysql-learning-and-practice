-- ============================================================================
-- 01 | FITZONE: COZUMLU SQL SINAV SORULARI
-- MySQL 8.x / MySQL Workbench | Kaynak: 00_fitzone_pratik_veri_seti.sql
-- ============================================================================
-- ÇALIŞMA YÖNTEMİ: Her bölümde önce SORU'yu oku. 'SORUYA YAKLAŞIM' kısmından
-- hangi tabloya neden ihtiyaç olduğunu anlamaya çalış. SQL'i kendi başına
-- tahmin et, ardından ÇÖZÜM'ü çalıştır. Sonuçları
-- 02_sorgu_sonuc_tablolari.md dosyasında karşılaştır.
-- Her SQL örneğinin altında önemli mantık ve sınav tuzakları açıklanmıştır.
-- ============================================================================
USE vys_vize_gun4;

-- ============================================================================
-- SORU 1 | WHERE + ORDER BY: Ücreti 250 TL'den büyük dersler
-- ============================================================================
-- SORU: Ücreti 250 TL'den büyük olan derslerin adlarını ve ücretlerini,
-- ücrete göre azalan sırayla getir. Eşitlikte ders adına göre artan sırala.
-- SORUYA YAKLAŞIM: Hem ders adı hem ücret Ders tablosunda. JOIN gereksiz.
-- Önce WHERE ile satırları filtrele, sonra ORDER BY ile sırala.
-- ÇÖZÜM:
SELECT d.ad AS DersAdi, d.ucret AS Ucret
FROM Ders AS d
WHERE d.ucret > 250
ORDER BY d.ucret DESC, d.ad ASC;
-- BEKLENEN SONUÇ: Crossfit | 400 ; Pilates | 300.
-- ÖNEMLİ NOT: '>' sınırdaki 250 değerini almaz; '>=' alsaydı Yoga da gelirdi.
-- ORDER BY yazılmadığında satır sırası garanti edilmez.

-- ============================================================================
-- SORU 2 | DISTINCT: Farklı şehirler
-- ============================================================================
-- SORU: Sistemdeki farklı şehirleri alfabetik sırada bir kez listele.
-- SORUYA YAKLAŞIM: Her üye ayrı satırdır fakat şehirler tekrarlanabilir.
-- DISTINCT seçilen değerleri tekilleştirir. JOIN ve GROUP BY gerekli değil.
-- ÇÖZÜM:
SELECT DISTINCT u.sehir AS Sehir
FROM Uye AS u
ORDER BY Sehir ASC;
-- BEKLENEN SONUÇ: Giresun, Rize, Trabzon.
-- ÖNEMLİ NOT: DISTINCT, tek bir sütun değil SELECT ile seçilen sütunların
-- birlikte oluşturduğu değer kombinasyonları üzerinde çalışır.

-- ============================================================================
-- SORU 3 | İKİ TABLOLU INNER JOIN: Ali'nin ders numaraları
-- ============================================================================
-- SORU: Üye numarası 1 olan kişinin adını ve kayıtlı olduğu ders numaralarını getir.
-- SORUYA YAKLAŞIM: İsim Uye'de, ders numaraları Kayit'ta bulunuyor.
-- Uye.uyeNo (PK) ile Kayit.uyeNo (FK) karşılaştırılmalı.
-- ÇÖZÜM:
SELECT u.ad AS UyeAdi, k.dersNo AS DersNo
FROM Uye AS u
INNER JOIN Kayit AS k ON u.uyeNo = k.uyeNo
WHERE u.uyeNo = 1
ORDER BY k.dersNo ASC;
-- BEKLENEN SONUÇ: Ali Kaya | D1 ; Ali Kaya | D3.
-- ÖNEMLİ NOT: 'Uye AS u' ifadesi tabloya u takma adını verir; u.ad sütuna
-- erişir. 'k.dersNo' Kayit tablosundaki dersNo sütunudur.
-- ON ilişkiyi kurar; WHERE yalnızca 1 numaralı üyeyi seçer.

-- ============================================================================
-- SORU 4 | ÜÇ TABLOLU INNER JOIN: Trabzon'daki üyelerin dersleri
-- ============================================================================
-- SORU: Trabzon'da yaşayan üyelerin kayıtlı oldukları derslerin adlarını getir.
-- Üye adı ve ders adına göre artan sırala.
-- SORUYA YAKLAŞIM: Şehir/ad Uye'de; ders adı Ders'te; ilişki Kayit'ta.
-- Bağlantı zinciri: Uye -> Kayit -> Ders.
-- ÇÖZÜM:
SELECT u.ad AS UyeAdi, d.ad AS DersAdi
FROM Uye AS u
INNER JOIN Kayit AS k ON u.uyeNo = k.uyeNo
INNER JOIN Ders AS d ON k.dersNo = d.dersNo
WHERE u.sehir = 'Trabzon'
ORDER BY u.ad ASC, d.ad ASC;
-- BEKLENEN SONUÇ: Ali/Crossfit, Ali/Pilates, Can/Pilates, Can/Yüzme.
-- ÖNEMLİ NOT: Kayit ara tablosu olmadan Uye ile Ders arasında doğrudan
-- hangi dersin hangi üyeye ait olduğunu öğrenemeyiz. INNER JOIN, kayıtlı
-- olmayan üyeyi getirmez. Aynı üye birden fazla derse kayıtlıysa tekrarlanır.

-- ============================================================================
-- SORU 5 | DÖRT TABLOLU INNER JOIN: Üye, ders ve eğitmen
-- ============================================================================
-- SORU: Trabzonlu üyelerin ders adlarını ve bu derslerin eğitmenlerini getir.
-- SORUYA YAKLAŞIM: Eğitmen adı Egitmen'de; bağlantı Ders.egitmenNo üzerinden.
-- Önce Uye -> Kayit -> Ders -> Egitmen zincirini kur, sonra şehir filtresini uygula.
-- ÇÖZÜM:
SELECT u.ad AS UyeAdi, d.ad AS DersAdi, e.ad AS EgitmenAdi
FROM Uye AS u
INNER JOIN Kayit AS k ON u.uyeNo = k.uyeNo
INNER JOIN Ders AS d ON k.dersNo = d.dersNo
INNER JOIN Egitmen AS e ON d.egitmenNo = e.egitmenNo
WHERE u.sehir = 'Trabzon'
ORDER BY u.ad ASC, d.ad ASC;
-- BEKLENEN: Ali/Crossfit/Mert, Ali/Pilates/Mert, Can/Pilates/Mert, Can/Yüzme/Nil.
-- ÖNEMLİ NOT: Her ON koşulu farklı bir PK-FK bağlantısını temsil eder.
-- ON d.egitmenNo = e.egitmenNo, dersin hangi eğitmene ait olduğunu bulur.
-- Dört tablo olsa bile yöntem iki tablolu JOIN ile tamamen aynıdır.
