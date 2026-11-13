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
2.
