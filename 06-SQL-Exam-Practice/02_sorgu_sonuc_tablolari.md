# 02 — SQL Sorguları, Sonuç Tabloları ve Çözüm Mantığı

**Ders:** Veritabanı Yönetim Sistemleri (VYS)  
**Konu:** SQL sorgularını okuma, JOIN işlemleri, gruplama, filtreleme ve sonuç tablolarını hesaplama  
**Çalışma ortamı:** MySQL 8.x / MySQL Workbench

## 1. Bu Dosyanın Amacı

Bu çalışma, SQL sorgularını yalnızca çalıştırmayı değil, sorguların hangi kayıtları getireceğini önceden tahmin edebilmeyi öğretmek amacıyla hazırlanmıştır.

Üniversite sınavında bir SQL sorgusu yazmamızın yanında sorgunun sonucunda oluşan tabloyu da belirtmemiz gerekebilir. Bu nedenle her örnekte sorunun ne istediğini, sorguyu nasıl düşünmemiz gerektiğini, beklenen sonuç tablosunu ve dikkat edilmesi gereken SQL kurallarını inceleyeceğiz.

Çalışmalar `00_fitzone_pratik_veri_seti.sql` dosyasıyla oluşturulan veriler üzerinden yapılmaktadır. SQL sorguları için `01_join_groupby_having_pratik.sql` dosyası kullanılabilir.

**Önerilen çalışma yöntemi:** Önce soru metnini oku, sonucu kendin tahmin et, ardından bu dosyadaki tabloyla karşılaştır. Özellikle yanlış tahmin ettiğin satırların neden oluştuğunu incele.

---

## 2. Kullanılan Örnek Veri Seti

### Uye tablosu

| uyeNo | ad | sehir |
|---:|---|---|
| 1 | Ali Kaya | Trabzon |
| 2 | Buse Can | Rize |
| 3 | Can Öz | Trabzon |
| 4 | Duru Ak | Giresun |

### Egitmen tablosu

| egitmenNo | ad |
|---|---|
| E1 | Mert |
| E2 | Nil |

### Ders tablosu

| dersNo | ad | ucret | egitmenNo |
|---|---|---:|---|
| D1 | Pilates | 300 | E1 |
| D2 | Yoga | 250 | E2 |
| D3 | Crossfit | 400 | E1 |
| D4 | Yüzme | 150 | E2 |

### Kayit tablosu

| uyeNo | dersNo | tarih |
|---:|---|---|
| 1 | D1 | 2026-09-01 |
| 1 | D3 | 2026-09-05 |
| 2 | D2 | 2026-09-02 |
| 3 | D1 | 2026-09-03 |
| 3 | D4 | 2026-09-03 |

Bu veri setinde özellikle dikkat edilmesi gereken üç durum bulunmaktadır. Ali Kaya ve Can Öz ikişer derse kayıtlıdır, Duru Ak'ın hiçbir ders kaydı yoktur ve Mert'in verdiği derslerde aynı üye birden fazla kayıt oluşturabilir.

Bu ayrıntılar özellikle INNER JOIN, LEFT JOIN, COUNT ve COUNT(DISTINCT) sonuçlarını etkiler.

---

# 3. Çözümlü Sorular ve Sonuç Tabloları

## A1 — WHERE ve ORDER BY

**Soru:** Ücreti 250 TL'den yüksek olan derslerin adlarını ve ücretlerini listeleyiniz. Sonuçları ücret bakımından büyükten küçüğe sıralayınız.

### Çözüm yaklaşımı

İstenen iki bilgi, ders adı ve ders ücretidir. Bu bilgiler yalnızca Ders tablosunda bulunduğu için JOIN kullanmamıza gerek yoktur.

Öncelikle `WHERE ucret > 250` koşulunu uygularız. Böylece yalnızca 250 TL'den yüksek ücretli dersler kalır. Ardından `ORDER BY ucret DESC` ile sonuçları büyükten küçüğe sıralarız.

### Beklenen sonuç

| DersAdi | Ucret |
|---|---:|
| Crossfit | 400 |
| Pilates | 300 |

### Önemli notlar

- `WHERE`, belirtilen koşula uyan satırları seçer.
- `>` operatörü sınır değerini içermez. Bu nedenle ücreti tam 250 TL olan Yoga sonuçta bulunmaz.
- `ORDER BY ucret DESC`, büyükten küçüğe sıralama yapar.
- `ASC`, küçükten büyüğe veya alfabetik artan sıralama anlamına gelir.
- Bir sorudaki bütün sütunlar aynı tabloda bulunuyorsa gereksiz JOIN yazılmamalıdır.

## A2 — DISTINCT

**Soru:** Üyelerin yaşadığı farklı şehirleri alfabetik sırayla listeleyiniz.

### Çözüm yaklaşımı

Uye tablosunda Trabzon iki farklı üyede bulunmaktadır. Ancak soru bütün şehir kayıtlarını değil, farklı şehirleri istediği için `DISTINCT` kullanmalıyız.

Önce `DISTINCT sehir` ile tekrarlanan şehir değerlerini kaldırır, sonra `ORDER BY sehir ASC` ile alfabetik sıralama yaparız.

### Beklenen sonuç

| Sehir |
|---|
| Giresun |
| Rize |
| Trabzon |

### Önemli notlar

- `DISTINCT`, sonuçta seçilen sütunların oluşturduğu tekrar eden kombinasyonları kaldırır.
- Tekrarlanan Trabzon değeri yalnızca bir kez gösterilir.
- `DISTINCT`, veritabanındaki kayıtları silmez. Yalnızca sorgu sonucunu etkiler.
- Birden fazla sütun seçildiğinde yalnızca ilk sütun değil, seçilen değerlerin tamamı birlikte değerlendirilir.

## A3 — INNER JOIN ve WHERE

**Soru:** Trabzon'da yaşayan üyelerin kayıt oldukları dersleri listeleyiniz. Sonuçta üyenin adı ve dersin adı bulunsun.

### Çözüm yaklaşımı

Üyenin adı ve yaşadığı şehir Uye tablosunda, dersin adı Ders tablosundadır. Bir üyenin hangi derse kayıt olduğunu ise Kayit tablosu gösterir.

Bu nedenle üç tabloyu birbirine bağlamamız gerekir:

1. `Uye.uyeNo = Kayit.uyeNo`
2. `Kayit.dersNo = Ders.dersNo`

Tablo takma adlarıyla bu koşullar `u.uyeNo = k.uyeNo` ve `k.dersNo = d.dersNo` şeklinde yazılır.

Ardından `WHERE u.sehir = 'Trabzon'` koşulu uygulanır.

### Beklenen sonuç

| UyeAdi | DersAdi |
|---|---|
| Ali Kaya | Crossfit |
| Ali Kaya | Pilates |
| Can Öz | Pilates |
| Can Öz | Yüzme |

### Önemli notlar

- `AS u`, Uye tablosuna takma ad verir. `u.ad` ifadesi Uye tablosunun ad sütununu gösterir.
- `AS UyeAdi` ise sonuç tablosundaki sütun başlığını değiştirir.
- `ON`, iki tablonun hangi sütunlar üzerinden eşleştirileceğini belirtir.
- `INNER JOIN`, yalnızca eşleşen satırları getirir.
- Ali ve Can'ın birden fazla satırda görünmesi normaldir; çünkü birden fazla ders kayıtları vardır.
- `WHERE`, JOIN sonucunda oluşan satırları filtreler.
- Dersleri yalnızca ders numarasından değil, adlarıyla gösterebilmek için Ders tablosuyla da JOIN yapılmalıdır.

## A4 — Dört Tablolu INNER JOIN

**Soru:** Trabzon'da yaşayan üyelerin kayıt oldukları dersleri ve bu dersleri veren eğitmenleri listeleyiniz.

### Çözüm yaklaşımı

Bu soruda üç farklı bilgi istenmektedir: üye adı, ders adı ve eğitmen adı.

Bu bilgileri elde etmek için dört tabloyu kullanırız: Uye, Kayit, Ders ve Egitmen.

Bağlantıları şu şekilde kurarız:

- Uye ile Kayit, `uyeNo` üzerinden eşleştirilir.
- Kayit ile Ders, `dersNo` üzerinden eşleştirilir.
- Ders ile Egitmen, `egitmenNo` üzerinden eşleştirilir.

Son olarak WHERE ile Trabzon filtresi uygulanır.

### Beklenen sonuç

| UyeAdi | DersAdi | EgitmenAdi |
|---|---|---|
| Ali Kaya | Crossfit | Mert |
| Ali Kaya | Pilates | Mert |
| Can Öz | Pilates | Mert |
| Can Öz | Yüzme | Nil |

### Önemli notlar

- JOIN sayısını ezberlemek yerine istenen bilgilerin hangi tablolarda bulunduğunu belirlemeliyiz.
- Bir tabloda ihtiyaç duyulan bilgi yoksa o tabloya ulaşmamızı sağlayan ilişkiyi takip etmeliyiz.
- `ON d.egitmenNo = e.egitmenNo` ifadesi, dersin hangi eğitmene ait olduğunu belirler.
- INNER JOIN, eşleşmeyen kayıtları sonuçta göstermez.
- Çok tablolu sorgularda takma ad kullanmak, sütun isimlerini karıştırmayı önler.

## A5 — LEFT JOIN ve COUNT

**Soru:** Hiçbir derse kayıt olmayanlar da dahil olmak üzere bütün üyelerin kayıtlı oldukları ders sayılarını listeleyiniz.

### Çözüm yaklaşımı

Sorunun en önemli ifadesi "bütün üyeler"dir. INNER JOIN kullanırsak hiçbir derse kayıtlı olmayan Duru Ak sonuçta görünmez.

Bu nedenle Uye tablosunu sol tarafa koyarak LEFT JOIN kullanırız. Daha sonra üye bazında GROUP BY yapıp `COUNT(k.dersNo)` ile kayıt sayılarını hesaplarız.

### Beklenen sonuç

| UyeAdi | DersSayisi |
|---|---:|
| Ali Kaya | 2 |
| Can Öz | 2 |
| Buse Can | 1 |
| Duru Ak | 0 |

### Önemli notlar

- `LEFT JOIN`, sol tablodaki bütün kayıtları korur.
- Sağ tabloda eşleşme yoksa sağ tabloya ait sütunlar NULL olur.
- `COUNT(k.dersNo)` yalnızca NULL olmayan ders numaralarını sayar.
- `COUNT(*)` eşleşmeyen üye için oluşturulan satırı da sayabilir. Bu nedenle aynı sonucu vermeyebilir.
- `GROUP BY`, aynı üyeye ait kayıtları bir araya getirir.
- Üye adları benzersiz olmak zorunda değildir. Bu nedenle gruplamada üye numarasının da kullanılması daha güvenlidir.

## A6 — GROUP BY ve HAVING

**Soru:** En fazla bir derse kayıtlı olan üyeleri listeleyiniz. Hiçbir derse kayıtlı olmayan üyeler de sonuçta bulunsun.

### Çözüm yaklaşımı

Önce bütün üyeleri korumak için LEFT JOIN kullanılır. Sonra her üyenin ders sayısı COUNT ile hesaplanır.

Soru "en fazla bir ders" dediği için grup sonucuna `HAVING COUNT(k.dersNo) <= 1` koşulu uygulanır.

### Beklenen sonuç

| UyeAdi | DersSayisi |
|---|---:|
| Duru Ak | 0 |
| Buse Can | 1 |

### Önemli notlar

- `WHERE`, gruplama öncesinde satırları filtreler.
- `HAVING`, GROUP BY ile oluşturulan grupları filtreler.
- `COUNT(...)` gibi toplulaştırma fonksiyonlarıyla elde edilen sonuçları filtrelemek için genellikle HAVING kullanılır.
- `<= 1` koşulu hem 0 hem 1 değerlerini içerir.
- LEFT JOIN yerine INNER JOIN kullanılırsa sıfır kaydı bulunan Duru sonuçtan kaybolur.

## A7 — COUNT ve COUNT(DISTINCT)

**Soru:** Her eğitmenin derslerindeki toplam kayıt sayısını ve kayıt olan farklı üye sayısını bulunuz.

### Çözüm yaklaşımı

Önce Egitmen, Ders ve Kayit tablolarını birleştiririz. Daha sonra her eğitmeni ayrı bir grup hâline getiririz.

Toplam kayıt sayısını `COUNT(k.uyeNo)` ile, farklı üye sayısını ise `COUNT(DISTINCT k.uyeNo)` ile hesaplarız.

### Beklenen sonuç

| EgitmenAdi | KayitSayisi | FarkliUyeSayisi |
|---|---:|---:|
| Mert | 3 | 2 |
| Nil | 2 | 2 |

### Sonuç neden böyle oluştu?

Mert, Pilates ve Crossfit derslerini vermektedir. Ali bu iki derse de kayıt olduğu için Mert'in derslerinde Ali'ye ait iki kayıt bulunmaktadır. Can da Pilates'e kayıtlıdır.

Bu nedenle Mert'in toplam kayıt sayısı 3, farklı üye sayısı 2'dir.

Nil'in Yoga dersine Buse, Yüzme dersine Can kayıtlıdır. Bu nedenle hem toplam kayıt sayısı hem de farklı üye sayısı 2'dir.

### Önemli notlar

- `COUNT(*)` satır sayısını hesaplar.
- `COUNT(sutun)` belirtilen sütundaki NULL olmayan değerleri sayar.
- `COUNT(DISTINCT sutun)` tekrar eden NULL olmayan değerleri yalnızca bir kez sayar.
- "Kaç kayıt?" ve "Kaç farklı kişi?" soruları aynı anlama gelmez.
- JOIN sonucunda aynı üye birden fazla satır oluşturabilir. Bu durum toplam kayıt sayısını etkiler.

---

# 4. Ek Sınav Soruları ve Çözüm Yaklaşımları

## B1 — Koşullu Sorgu ve Sıralama

**Soru:** Ücreti 250 TL veya daha fazla olan dersleri listeleyiniz. Sonuçları ücrete göre azalan, eşit ücret varsa ders adına göre artan sıralayınız.

### Çözüm yaklaşımı

Öncelikle `>=` operatörünün sınır değerini içerdiğini hatırlamalıyız. Ardından ORDER BY içinde birden fazla sütun kullanabiliriz.

### SQL çözümü

```sql
SELECT
    d.ad AS DersAdi,
    d.ucret AS Ucret
FROM Ders AS d
WHERE d.ucret >= 250
ORDER BY d.ucret DESC, d.ad ASC;
```

### Beklenen sonuç

| DersAdi | Ucret |
|---|---:|
| Crossfit | 400 |
| Pilates | 300 |
| Yoga | 250 |

### Önemli notlar

- `>= 250`, ücreti tam 250 olan dersleri de kapsar.
- Birinci sıralama ölçütü ücret, ikinci ölçüt ders adıdır.
- İkinci ORDER BY sütunu, ilk sütunda eşitlik olduğunda sonuç sırasını belirler.
- `ORDER BY` olmadan belirli bir satır sırası garanti edilmez.

## B2 — Dört Tablolu JOIN ve Birleşik WHERE Koşulu

**Soru:** Trabzon veya Rize'de yaşayan üyelerin, ücreti en az 250 TL olan kayıtlı derslerini listeleyiniz. Üye, ders, eğitmen adı ve ücret gösterilsin.

### Çözüm yaklaşımı

İstenen bilgiler dört farklı tabloya dağılmıştır. Önce Uye, Kayit, Ders ve Egitmen tablolarını ilgili anahtarlarla birleştirmeliyiz.

Ardından şehir ve ücret koşullarını birlikte uygulamalıyız. Birden fazla kabul edilen şehir bulunduğundan `IN` kullanılabilir.

### SQL çözümü

```sql
SELECT
    u.ad AS UyeAdi,
    d.ad AS DersAdi,
    e.ad AS EgitmenAdi,
    d.ucret AS Ucret
FROM Uye AS u
INNER JOIN Kayit AS k
    ON u.uyeNo = k.uyeNo
INNER JOIN Ders AS d
    ON k.dersNo = d.dersNo
INNER JOIN Egitmen AS e
    ON d.egitmenNo = e.egitmenNo
WHERE u.sehir IN ('Trabzon', 'Rize')
  AND d.ucret >= 250
ORDER BY u.ad ASC, d.ad ASC;
```

### Beklenen sonuç

| UyeAdi | DersAdi | EgitmenAdi | Ucret |
|---|---|---|---:|
| Ali Kaya | Crossfit | Mert | 400 |
| Ali Kaya | Pilates | Mert | 300 |
| Buse Can | Yoga | Nil | 250 |
| Can Öz | Pilates | Mert | 300 |

### Önemli notlar

- `IN ('Trabzon','Rize')`, iki şehirden herhangi birinde yaşayan üyeleri seçer.
- `AND`, şehir ve ücret koşullarının birlikte sağlanmasını zorunlu kılar.
- Can'ın Yüzme kaydı bulunmasına rağmen ücreti 150 TL olduğu için sonuçta yer almaz.
- Sorguda hangi tabloların kullanılacağını belirlerken önce SELECT ve WHERE bölümlerinde ihtiyaç duyulan sütunları tespit etmeliyiz.

## B3 — GROUP BY ve HAVING

**Soru:** En az iki derse kayıtlı üyelerin adlarını ve ders sayılarını listeleyiniz.

### Çözüm yaklaşımı

Her üyenin kaç derse kayıt olduğunu hesaplayabilmek için Uye ve Kayit tablolarını birleştirip gruplama yapmalıyız.

Soru belirli bir toplam kayıt sayısını sağlayan grupları istediği için HAVING kullanmalıyız.

### SQL çözümü

```sql
SELECT
    u.ad AS UyeAdi,
    COUNT(k.dersNo) AS DersSayisi
FROM Uye AS u
LEFT JOIN Kayit AS k
    ON u.uyeNo = k.uyeNo
GROUP BY u.uyeNo, u.ad
HAVING COUNT(k.dersNo) >= 2
ORDER BY DersSayisi DESC, u.ad ASC;
```

### Beklenen sonuç

| UyeAdi | DersSayisi |
|---|---:|
| Ali Kaya | 2 |
| Can Öz | 2 |

### Önemli notlar

- `GROUP BY` üyeleri gruplandırır.
- `COUNT(k.dersNo)` her üyenin ders kaydını sayar.
- `HAVING COUNT(k.dersNo) >= 2`, en az iki kaydı olan üyeleri bırakır.
- En az iki derse kayıtlı üyeler için INNER JOIN de kullanılabilir; ancak LEFT JOIN bütün üyelerden başlayarak gruplama mantığını incelemek açısından yararlıdır.

## B4 — Hiç Kaydı Olmayan Üyeler

**Soru:** Hiçbir derse kayıt olmayan üyeleri listeleyiniz.

### Çözüm yaklaşımı

Bu soruda kayıtlı olanları değil, eşleşmesi bulunmayanları arıyoruz.

Öncelikle bütün üyeleri korumak için LEFT JOIN kullanılır. Daha sonra Kayit tablosunda eşleşmesi bulunmayan satırları `IS NULL` ile seçeriz.

### SQL çözümü

```sql
SELECT u.ad AS UyeAdi
FROM Uye AS u
LEFT JOIN Kayit AS k
    ON u.uyeNo = k.uyeNo
WHERE k.uyeNo IS NULL
ORDER BY u.ad ASC;
```

### Beklenen sonuç

| UyeAdi |
|---|
| Duru Ak |

### Önemli notlar

- LEFT JOIN eşleşmeyen üyeleri de sonuçta tutar.
- Eşleşmeyen satırda Kayit tarafındaki `uyeNo` NULL olur.
- `IS NULL`, değerin NULL olup olmadığını kontrol eder.
- SQL'de NULL karşılaştırması için `= NULL` kullanılmaz.
- "Hiç kaydı olmayan", "eşleşmeyen" veya "henüz işlem yapmamış" ifadeleri LEFT JOIN ve IS NULL yaklaşımına işaret edebilir.

## B5 — DISTINCT ile Tekrarsız Üye Listesi

**Soru:** Mert'in verdiği derslere kayıt olmuş farklı üyelerin adlarını listeleyiniz. Aynı üye birden fazla derse kayıtlı olsa bile sonuçta yalnızca bir kez görünsün.

### Çözüm yaklaşımı

Bir üyenin hangi eğitmenin dersine kayıtlı olduğunu bulabilmek için dört tabloyu birleştirmeliyiz.

Mert'in iki dersine de kayıtlı Ali, JOIN sonucunda iki satır oluşturur. Ancak soru farklı üyeleri istediği için tekrarları kaldırmamız gerekir.

### SQL çözümü

```sql
SELECT DISTINCT
    u.uyeNo,
    u.ad AS UyeAdi
FROM Uye AS u
INNER JOIN Kayit AS k
    ON u.uyeNo = k.uyeNo
INNER JOIN Ders AS d
    ON k.dersNo = d.dersNo
INNER JOIN Egitmen AS e
    ON d.egitmenNo = e.egitmenNo
WHERE e.ad = 'Mert'
ORDER BY UyeAdi ASC;
```

### Beklenen sonuç

| uyeNo | UyeAdi |
|---:|---|
| 1 | Ali Kaya |
| 3 | Can Öz |

### Önemli notlar

- DISTINCT, seçilen sütunların oluşturduğu tekrar eden satırları kaldırır.
- `uyeNo` seçilmesi, aynı ada sahip farklı üyelerin yanlışlıkla tek kişi kabul edilmesini önler.
- Ali'nin hem Pilates hem de Crossfit kaydı bulunur. Ancak sonuçta yalnızca bir kez yer alır.
- Gerçek sistemlerde eğitmenin adı her zaman benzersiz olmayabilir. Böyle durumlarda eğitmen numarasıyla filtreleme yapmak daha güvenlidir.

## B6 — Alt Sorgu ve AVG

**Soru:** Ücreti bütün derslerin ortalama ücretinden yüksek olan dersleri listeleyiniz.

### Çözüm yaklaşımı

Önce bütün derslerin ortalama ücretini hesaplamalıyız. Daha sonra bu ortalamadan yüksek ücretli dersleri bulmalıyız.

Ortalama değeri başka bir SELECT sorgusuyla hesaplayıp ana sorgunun WHERE koşulunda kullanabiliriz. Bu yapıya alt sorgu denir.

### SQL çözümü

```sql
SELECT
    d.ad AS DersAdi,
    d.ucret AS Ucret
FROM Ders AS d
WHERE d.ucret > (
    SELECT AVG(ucret)
    FROM Ders
)
ORDER BY d.ucret DESC;
```

### Ortalama ücret hesabı

Ders ücretleri 300, 250, 400 ve 150 TL'dir.

Toplam ücret 1100 TL, ders sayısı 4'tür. Ortalama ücret `1100 / 4 = 275 TL` olur.

### Beklenen sonuç

| DersAdi | Ucret |
|---|---:|
| Crossfit | 400 |
| Pilates | 300 |

### Önemli notlar

- `AVG`, sayısal sütunun ortalamasını hesaplar.
- İçteki SELECT sorgusu ortalama ücreti bulur.
- Dıştaki SELECT sorgusu dersleri bu ortalamayla karşılaştırır.
- `>`, ortalama değere eşit olan kayıtları dahil etmez.
- Alt sorgu, ana sorgunun ihtiyaç duyduğu bir değer veya sonuç kümesi üretebilir.
- Bu örnekte alt sorgu tek bir sayısal değer döndürmektedir.

---

# 5. SQL Sınav Sorularına Yaklaşma Yöntemi

Bir SQL sorusunu okuduğumuzda doğrudan kod yazmaya başlamadan önce hangi bilgilerin istendiğini ve bu bilgilerin hangi tablolarda bulunduğunu belirlemeliyiz.

### Adım 1 — İstenen sütunları belirle

Örneğin "Üye adı, ders adı ve eğitmen adı" isteniyorsa bu bilgilerin sırasıyla Uye, Ders ve Egitmen tablolarında bulunduğunu tespit ederiz.

### Adım 2 — Gerekli tablo bağlantılarını kur

Tabloları PK/FK ilişkileri üzerinden bağlarız. FitZone örneğinde bağlantı zinciri Uye → Kayit → Ders → Egitmen şeklindedir.

Birleştirme sırasında `ON` koşulunda birbirleriyle ilişkili anahtar alanları karşılaştırırız.

### Adım 3 — INNER JOIN mi, LEFT JOIN mi kullanacağını belirle

Yalnızca eşleşen kayıtlar isteniyorsa INNER JOIN kullanılır.

Bütün üyelerin listelenmesi, kaydı olmayanların gösterilmesi veya sıfır kayıt sayılarının hesaplanması isteniyorsa LEFT JOIN değerlendirilebilir.

### Adım 4 — Satır filtrelerini uygula

Şehir, ücret, tarih ve benzeri koşullar için WHERE kullanılır.

Birden fazla koşul varsa AND, OR veya IN gibi yapılar kullanılabilir. AND ve OR birlikte kullanıldığında işlem önceliğini açıkça belirtmek için parantez kullanmak yararlıdır.

### Adım 5 — Gruplama gerekli mi, karar ver

"Her üye için", "her eğitmen için", "departmanlara göre" gibi ifadeler GROUP BY kullanmamız gerektiğini gösterebilir.

Toplam, ortalama, sayı, en küçük veya en büyük değer isteniyorsa COUNT, SUM, AVG, MIN veya MAX fonksiyonlarından yararlanırız.

### Adım 6 — Grup filtresi olup olmadığını kontrol et

"En az iki derse kayıtlı üyeler" veya "Toplam satışı belirli tutardan fazla olan gruplar" gibi ifadeler HAVING kullanılmasını gerektirebilir.

WHERE satırları, HAVING grupları filtreler.

### Adım 7 — Sonuç tablosunu hesapla

JOIN sonucunda hangi satırların oluştuğunu buluruz. Ardından WHERE koşullarıyla elenen satırları çıkarır, varsa GROUP BY ve HAVING işlemlerini uygularız.

Son aşamada SELECT ile gösterilecek sütunları ve ORDER BY ile sıralamayı belirleriz.

---

# 6. Sınavda Sık Yapılan SQL Hataları

## Hata 1 — Tablo takma adı ile sütun takma adını karıştırmak

`FROM Uye AS u` ifadesi Uye tablosunun takma adını belirler.

`SELECT u.ad AS UyeAdi` ifadesi ise sonuç sütununun başlığını UyeAdi yapar.

## Hata 2 — JOIN sırasında yanlış sütunları eşleştirmek

Uye ve Kayit tablolarını birleştirirken `u.uyeNo = k.uyeNo` kullanılır.

Kayit ve Ders tablolarını birleştirirken `k.dersNo = d.dersNo` kullanılır.

Birleştirilen sütunların aynı varlığı veya ilişkiyi temsil etmesi gerekir.

## Hata 3 — INNER JOIN ile kaydı olmayanları göstermeye çalışmak

INNER JOIN yalnızca eşleşen kayıtları getirir.

Kaydı olmayan üyeleri de göstermek için LEFT JOIN gibi uygun bir birleştirme gerekir.

## Hata 4 — COUNT(*) ile COUNT(sutun) farkını unutmak

COUNT(*) sonuç satırlarını sayar. COUNT(sutun) ise o sütundaki NULL olmayan değerleri sayar.

LEFT JOIN ile kaydı olmayan üyelerin sayısı hesaplanırken bu ayrım önemlidir.

## Hata 5 — WHERE ve HAVING'i karıştırmak

WHERE, gruplama öncesinde satırları filtreler.

HAVING, gruplama sonrasında hesaplanan grupları filtreler.

## Hata 6 — DISTINCT'i yanlış yorumlamak

DISTINCT yalnızca sonuçta seçilmiş değer kombinasyonlarının tekrarlarını kaldırır.

Aynı ada sahip iki farklı kişi varsa yalnızca ad sütununu seçmek onları tek satırda gösterebilir. Bu nedenle gerektiğinde benzersiz kimlik alanı da seçilmelidir.

## Hata 7 — ORDER BY olmadan sonuç sırasını kesin kabul etmek

SQL'de ORDER BY yazılmadıkça satırların belirli bir sırayla geleceği garanti değildir.

Sonuç tablosunu elle hazırlarken soru sıralama istiyorsa ORDER BY koşullarına dikkat edilmelidir.

---

# 7. Son Tekrar — Hızlı Kontrol

| İfade | Ne işe yarar? |
|---|---|
| `AS` | Tablo veya sonuç sütununa takma ad verir. |
| `ON` | JOIN sırasında satırların eşleşme koşulunu belirtir. |
| `WHERE` | Satırları filtreler. |
| `INNER JOIN` | Eşleşen kayıtları getirir. |
| `LEFT JOIN` | Sol taraftaki eşleşmeyen kayıtları da korur. |
| `GROUP BY` | Kayıtları gruplandırır. |
| `HAVING` | Grupları filtreler. |
| `COUNT(*)` | Sonuç satırlarını sayar. |
| `COUNT(sutun)` | NULL olmayan sütun değerlerini sayar. |
| `COUNT(DISTINCT sutun)` | Farklı NULL olmayan değerleri sayar. |
| `AVG` | Ortalama hesaplar. |
| `ORDER BY` | Sonucu sıralar. |
| Alt sorgu | Bir sorgunun sonucunu başka bir sorguda kullanır. |

## Sonuç

SQL sorularını çözerken sorgunun tamamını bir anda düşünmek yerine işlemleri sırayla değerlendirmek daha güvenilir bir yöntemdir.

Önce tablolar ve aralarındaki ilişkiler belirlenmeli, ardından filtreleme ve gruplama uygulanmalı, son olarak hangi sütunların hangi sırayla gösterileceğine karar verilmelidir.

**En önemli kazanım:** Bir sorgunun neden belirli sayıda satır ürettiğini açıklayabiliyorsak JOIN, WHERE, GROUP BY ve HAVING işlemlerinin temel mantığını anlamışız demektir.

---

**Sonraki çalışma:** Yeni veri setleri üzerinde SQL kodlarını bağımsız yazma, sonuç tablolarını tahmin etme ve VYS sınav provası.
