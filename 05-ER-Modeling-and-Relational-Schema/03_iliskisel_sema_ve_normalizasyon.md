# 03 — E-R Modelinden İlişkisel Şemaya Dönüşüm ve Normalizasyon

**Ders:** Veritabanı Yönetim Sistemleri (VYS)  
**Konu:** İlişkisel şema, birincil ve yabancı anahtarlar, E-R dönüşüm kuralları, 1NF, 2NF ve 3NF  
**Amaç:** Verilen bir E-R modelini doğru tablolara dönüştürebilmek, PK/FK alanlarını belirleyebilmek ve normalizasyon problemlerini anlayabilmek.

---

## 1. E-R Modeli ile İlişkisel Şema Arasındaki Fark

E-R modeli, bir veritabanının kavramsal tasarımını gösterir. Varlıklar, nitelikler ve ilişkiler Chen gösteriminde dikdörtgen, elips ve eşkenar dörtgen gibi şekillerle ifade edilir.

İlişkisel şema ise bu kavramsal modelin tablolar, sütunlar ve anahtarlar şeklinde düzenlenmiş hâlidir. Veritabanı tablolarını SQL ile oluşturmadan önce hangi tablonun hangi alanları içereceğini ve tabloların birbirlerine nasıl bağlanacağını belirlememizi sağlar.

Örneğin E-R modelinde bir eğitmenin birden fazla ders verebildiği belirtiliyorsa bu bilgiyi ilişkisel şemada EĞİTMEN ve DERS tabloları arasındaki yabancı anahtar ilişkisiyle temsil edebiliriz.

İlişkisel şema örneği:

`EGITMEN(egitmenNo PK, ad, uzmanlik)`

`DERS(dersNo PK, dersAd, kapasite, egitmenNo FK)`

Burada `DERS.egitmenNo`, `EGITMEN.egitmenNo` alanına referans verir.

## 2. Primary Key ve Foreign Key

**Primary Key (PK)**, bir tablodaki her satırı benzersiz olarak tanımlar. PK değerleri tekrarlanamaz ve NULL olamaz.

**Foreign Key (FK)**, bir tablodaki sütunun veya sütun grubunun başka bir tablonun aday anahtarına, genellikle birincil anahtarına, referans vermesini sağlayan kısıttır. FK değerleri, referans verilen tablodaki mevcut değerlerle tutarlı olmalıdır. FK'nin NULL alıp alamayacağı ilişki kısıtlarına ve sütunun tanımına bağlıdır.

Bir tablonun kendi PK'si ile başka bir tabloya referans veren FK'si aynı tabloda bulunabilir. Ayrıca aynı sütun hem PK'nin parçası hem de FK olabilir.

Örneğin:

| Tablo | Sütun | Görevi |
|---|---|---|
| DEPARTMAN | departmanNo | PK |
| PERSONEL | personelNo | PK |
| PERSONEL | departmanNo | FK |

Bir departmanın birçok personeli olabilir. Her personelin yalnızca bir departmanı olduğu için `departmanNo` alanı PERSONEL tablosunda bulunur.

**Önemli:** PK veya FK doğrudan bir varlığın adı değildir; bir veya birden fazla sütuna uygulanan anahtar rolüdür.

## 3. Güçlü Varlığın Tabloya Dönüştürülmesi

Güçlü varlıklar genellikle ayrı birer tabloya dönüştürülür. Varlığın basit nitelikleri tablonun sütunlarını, birincil anahtarı ise tablonun PK'sini oluşturur.

Örneğin:

`PAKET(paketNo PK, paketAd, ucret, sureAy)`

Burada PAKET güçlü bir varlıktır ve benzersiz `paketNo` değeriyle tanımlanır.

Bileşik nitelikler ilişkisel şemaya aktarılırken genellikle anlamlı alt bileşenlerine ayrılır. Örneğin bir adresin şehir ve ilçe olarak saklanması gerekiyorsa bu alanlar ayrı sütunlara dönüştürülebilir.

## 4. 1:N İlişkilerin Dönüştürülmesi

Bir bire çok ilişkide, 1 tarafındaki tablonun anahtarı N tarafındaki tabloya FK olarak eklenir.

FitZone senaryosunda bir eğitmen birçok ders verebilir ancak her dersin tam olarak bir eğitmeni vardır.

`EGITMEN(egitmenNo PK, ad, uzmanlik)`

`DERS(dersNo PK, dersAd, kapasite, egitmenNo FK)`

DERS tablosundaki `egitmenNo`, eğitmenin kimliğini gösterir. Birden fazla ders aynı eğitmeni referans verebilir. Bu nedenle `egitmenNo` değerinin DERS tablosunda tekrar etmesi normaldir.

Her dersin mutlaka bir eğitmeni bulunması gerekiyorsa `DERS.egitmenNo` alanı `NOT NULL` olarak tanımlanır.

**Temel kural: 1:N ilişkide FK, N tarafında bulunur.**

Bu kuralda genellikle yalnızca ilişkiyi göstermek için yeni bir ara tablo oluşturmamız gerekmez.

## 5. N:M İlişkilerin Dönüştürülmesi

Çoka çok ilişkiler ilişkisel modelde genellikle ayrı bir bağlantı tablosuyla temsil edilir. Bu ara tablo, ilişkideki iki varlığın anahtarlarını FK olarak içerir.

Örneğin bir öğrenci birçok kulübe katılabilir ve bir kulüpte birçok öğrenci bulunabilir.

`OGRENCI(ogrenciNo PK, ad)`

`KULUP(kulupNo PK, kulupAd)`

`UYELIK(ogrenciNo PK/FK, kulupNo PK/FK, katilmaTarihi)`

Burada `(ogrenciNo, kulupNo)` birlikte bileşik PK'dir. Bu iki sütun aynı zamanda ilgili tablolara referans veren FK'lerdir.

`katilmaTarihi`, öğrencinin kulüple kurduğu üyelik ilişkisine ait olduğu için UYELIK tablosunda saklanır.

Bu tasarım, aynı öğrenci-kulüp ikilisi için tek bir üyelik kaydı bulunabileceğini varsayar. Aynı kulübe farklı dönemlerde tekrar üyelik yapılabilmesi gerekiyorsa anahtar tasarımı buna göre değiştirilmelidir.

**Temel kural: N:M ilişki ara tabloya dönüştürülür ve iki adet 1:N ilişkiyle temsil edilir.**

## 6. 1:1 İlişkilerin Dönüştürülmesi

Bire bir ilişkide FK, tasarımın gereksinimlerine göre uygun taraflardan birine yerleştirilebilir. Aynı kaydın birden fazla eşleşmeye sahip olmasını engellemek için genellikle `UNIQUE` kısıtı kullanılır.

Örneğin bir çalışanın en fazla bir dolabı, bir dolabın da en fazla bir kullanıcısı olabilir.

`CALISAN(calisanNo PK, ad)`

`DOLAP(dolapNo PK, calisanNo FK UNIQUE)`

Burada `UNIQUE`, aynı çalışanın iki farklı dolapla ilişkilendirilmesini engeller. İsteğe bağlı ilişki varsa `calisanNo` NULL olabilir.

İki tarafın da ilişkiye katılmasının zorunlu olması gibi daha güçlü kurallar için basit FK ve UNIQUE kısıtları her zaman yeterli değildir.

## 7. Çok Değerli Niteliklerin Dönüştürülmesi

Bir varlığın aynı niteliği birden fazla değer alabiliyorsa bu bilgi ayrı bir tabloya dönüştürülebilir.

FitZone örneğinde bir üyenin birden fazla telefon numarası olabilir. Telefonları tek hücrede virgülle ayırarak tutmak yerine UYE_TELEFON tablosu oluştururuz.

`UYE(uyeNo PK, ad, soyad, dogumTarihi)`

`UYE_TELEFON(uyeNo PK/FK, telefon PK)`

Bu tasarımda `(uyeNo, telefon)` birlikte PK'dir. Böylece aynı üye farklı telefon numaralarına sahip olabilir.

Örnek:

| uyeNo | telefon |
|---|---|
| 101 | 0532... |
| 101 | 0544... |
| 102 | 0555... |

Böylece her telefon numarası ayrı bir satırda saklanabilir.

## 8. Zayıf Varlıkların Dönüştürülmesi

Zayıf varlığın kendi kısmi anahtarı, onu bütün veritabanında benzersiz tanımlamak için yeterli değildir. Bu nedenle sahip varlığın anahtarı zayıf varlık tablosuna eklenir.

FitZone'da ACİL KİŞİ'nin sıra numarası yalnızca ilgili üye içinde anlamlıdır.

`UYE(uyeNo PK, ad, soyad, dogumTarihi)`

`ACIL_KISI(uyeNo PK/FK, siraNo PK, ad, telefon)`

Burada `(uyeNo, siraNo)` birlikte PK'dir. `uyeNo` aynı zamanda UYE tablosunu referans eden FK'dir.

Örnek:

| uyeNo | siraNo | ad |
|---|---|---|
| 101 | 1 | Ayşe |
| 101 | 2 | Mehmet |
| 102 | 1 | Zeynep |

`1` sıra numarası iki farklı üyeye ait olabilir; ancak `(101,1)` ve `(102,1)` birbirinden farklı anahtarlardır.

## 9. Türetilen Niteliklerin Dönüştürülmesi

Türetilen nitelikler başka bilgilerden hesaplanabilir. Örneğin yaş, doğum tarihinden elde edilebilir.

Bu nedenle FitZone şemasında `yas` sütununu zorunlu olarak saklamamıza gerek yoktur. `dogumTarihi` tutulması yeterlidir.

Böylece zaman ilerledikçe yaş bilgisinin güncelliğini kaybetmesi önlenebilir.

## 10. FitZone'un Tam İlişkisel Şeması

Hocanın FitZone senaryosunun ilişkisel karşılığı aşağıdaki gibi yazılabilir.

**UYE**

`UYE(uyeNo PK, ad, soyad, dogumTarihi, antrenorNo FK NULL)`

`antrenorNo → EGITMEN.egitmenNo`

**UYE_TELEFON**

`UYE_TELEFON(uyeNo PK/FK, telefon PK)`

`uyeNo → UYE.uyeNo`

**ACIL_KISI**

`ACIL_KISI(uyeNo PK/FK, siraNo PK, ad, telefon)`

`uyeNo → UYE.uyeNo`

**PAKET**

`PAKET(paketNo PK, ad, ucret, sureAy)`

**EGITMEN**

`EGITMEN(egitmenNo PK, ad, uzmanlik)`

**DERS**

`DERS(dersNo PK, ad, kapasite, egitmenNo FK NOT NULL)`

`egitmenNo → EGITMEN.egitmenNo`

**ABONELIK**

`ABONELIK(uyeNo PK/FK, paketNo PK/FK, baslangic, bitis)`

`uyeNo → UYE.uyeNo`

`paketNo → PAKET.paketNo`

**KAYIT**

`KAYIT(uyeNo PK/FK, dersNo PK/FK, kayitTarihi)`

`uyeNo → UYE.uyeNo`

`dersNo → DERS.dersNo`

### Şemadaki önemli kararlar

ÜYE tablosundaki `antrenorNo` yabancı anahtarı NULL olabilir. Çünkü üyenin kişisel antrenör seçmesi zorunlu değildir. Her üyenin en fazla bir antrenörü olabildiği için bu ilişki ayrı bir N:M tablosu gerektirmez.

DERS tablosundaki `egitmenNo` ise NOT NULL olmalıdır; çünkü her ders tam olarak bir eğitmene bağlıdır.

ABONELIK ve KAYIT tabloları N:M ilişkilerden oluşmuş ara tablolardır. İlişki nitelikleri de bu tablolarda tutulur.

**Sınav notu:** ABONELIK tablosunda `(uyeNo, paketNo)` bileşik PK kullanımı, hocanın örnek şemasındaki tercihle uyumludur. Bu model aynı üye-paket çifti için yalnızca bir abonelik satırına izin verir. Yenilemelerin ayrı kayıtlar olarak tutulması gerekiyorsa `baslangic` veya ayrı bir `abonelikNo` kimliği de anahtar tasarımına dahil edilebilir.

**Ek tasarım notu:** "Her üyenin en az bir acil kişisi vardır" gibi minimum katılım kuralları, yalnızca PK ve FK tanımlarıyla her durumda garanti edilemez. Gerekirse ek uygulama veya veritabanı kurallarıyla uygulanır.

## 11. Normalizasyon Nedir?

Normalizasyon, bir veritabanındaki verileri işlevsel bağımlılıklarına göre uygun tablolara ayırarak gereksiz veri tekrarlarını ve tutarsızlık riskini azaltmaya yönelik bir tasarım sürecidir.

Normalizasyon yapılmayan bir tabloda aynı bilgi birçok kayıtta tekrar edebilir. Örneğin bir eğitmenin adı on farklı ders kaydında tutuluyorsa eğitmenin adı değiştiğinde bu kayıtların tamamını güncellemek gerekebilir.

Bu durum güncelleme anomalisine neden olabilir. Ayrıca yeni bilgi eklerken veya kayıt silerken de ekleme ve silme anomalileri oluşabilir.

İlk üç normal form 1NF, 2NF ve 3NF olarak adlandırılır.

## 12. Birinci Normal Form (1NF)

1NF'de sütunlardaki değerlerin tanımlanan veri alanı açısından atomik olması ve tekrarlayan alan grupları bulunmaması beklenir.

Örneğin aşağıdaki tablo uygun değildir:

| uyeNo | ad | telefonlar |
|---|---|---|
| 101 | Ahmet | 0532..., 0544... |
| 102 | Ayşe | 0555... |

Burada birden fazla telefon numarası aynı hücrede liste olarak tutulmaktadır.

Daha iyi tasarımda ÜYE ve ÜYE_TELEFON tablolarını ayırırız.

`UYE(uyeNo PK, ad)`

`UYE_TELEFON(uyeNo PK/FK, telefon PK)`

Bu sayede her telefon numarası kendi satırında tutulur ve telefon numaraları üzerinde sorgulama yapmak kolaylaşır.

**Hatırlama yöntemi:** Bir hücrede, ayrı ayrı yönetilmesi gereken değerleri liste olarak saklama.

## 13. İkinci Normal Form (2NF)

Bir tablonun 2NF'de olması için öncelikle 1NF'de olması gerekir. Ayrıca anahtar olmayan nitelikler herhangi bir aday anahtarın yalnızca bir bölümüne kısmi olarak bağımlı olmamalıdır.

Örneğin:

`KAYIT(ogrenciNo, dersNo, ogrenciAd, dersAd, kayitTarihi)`

PK: `(ogrenciNo, dersNo)`

| ogrenciNo | dersNo | ogrenciAd | dersAd | kayitTarihi |
|---|---|---|---|---|
| 1 | 101 | Ali | SQL | 2026-09-01 |
| 1 | 102 | Ali | Java | 2026-09-02 |
| 2 | 101 | Zeynep | SQL | 2026-09-03 |

İşlevsel bağımlılıklar şunlardır:

- `ogrenciNo → ogrenciAd`
- `dersNo → dersAd`
- `(ogrenciNo, dersNo) → kayitTarihi`

`ogrenciAd`, bileşik anahtarın sadece `ogrenciNo` kısmına bağlıdır. Benzer şekilde `dersAd` yalnızca `dersNo` kısmına bağlıdır.

Bu durum kısmi bağımlılık oluşturur ve 2NF'ye aykırıdır.

Çözüm:

`OGRENCI(ogrenciNo PK, ogrenciAd)`

`DERS(dersNo PK, dersAd)`

`KAYIT(ogrenciNo PK/FK, dersNo PK/FK, kayitTarihi)`

Artık öğrenci adı ve ders adı kendi tablolarında tutulur. Kayıt tarihi ise öğrenci ve ders birleşimine aittir.

**Hatırlama yöntemi:** Bileşik anahtarın yalnızca bir parçasına bağımlı olan anahtar dışı bilgileri ayır.

## 14. Üçüncü Normal Form (3NF)

3NF'de tablo 2NF koşullarını sağlamalı ve anahtar olmayan nitelikler arasında uygunsuz geçişli bağımlılıklar bulunmamalıdır.

Örneğin:

`DERS(dersNo, dersAd, egitmenNo, egitmenAd)`

PK: `dersNo`

Her dersin tek bir eğitmeni olduğunu ve her `egitmenNo` değerinin bir eğitmeni tanımladığını düşünelim.

Bu durumda:

`dersNo → egitmenNo → egitmenAd`

`egitmenAd`, doğrudan dersin kimliğinden değil, dersin bağlı olduğu eğitmenin kimliğinden belirlenmektedir.

Bu bağımlılık zinciri, ders tablosunda eğitmen adının tekrar etmesine neden olur.

Çözüm:

`EGITMEN(egitmenNo PK, egitmenAd)`

`DERS(dersNo PK, dersAd, egitmenNo FK)`

Artık eğitmenin adı yalnızca EGITMEN tablosunda tutulur.

**Hatırlama yöntemi:** Anahtar olmayan bir nitelik, başka bir anahtar olmayan niteliğin bilgisi olduğu için tekrar tutuluyorsa tabloyu bölmeyi değerlendir.

Bu açıklama temel 3NF problemlerini tanımak içindir. 3NF'nin teknik tanımı, işlevsel bağımlılıklar ve aday anahtarlar üzerinden yapılır.

## 15. Normal Formları Karşılaştırma

| Normal form | Sınavda aranacak sorun | Çözüm yaklaşımı |
|---|---|---|
| 1NF | Bir alanda değer listesi veya tekrarlayan alan grupları | Atomik değerler ve uygun ayrı tablolar |
| 2NF | Bileşik aday anahtarın bir parçasına kısmi bağımlılık | Kısmi bağımlı alanları uygun tabloya ayırma |
| 3NF | Anahtar olmayan nitelikler arasında uygunsuz geçişli bağımlılık | Bağımlı nitelikleri kendi varlık tablosunda tutma |

Normalizasyon aşamalı değerlendirilir. Bir tablo 3NF'de ise 2NF ve 1NF koşullarını da sağlar.

## 16. MySQL ile PK/FK Örneği

Aşağıdaki kod, 1:N ilişkiyi gerçek MySQL tablolarıyla göstermektedir.

```sql
CREATE TABLE Egitmen (
    egitmenNo INT PRIMARY KEY,
    ad VARCHAR(50) NOT NULL
);

CREATE TABLE Ders (
    dersNo INT PRIMARY KEY,
    dersAd VARCHAR(50) NOT NULL,
    egitmenNo INT NOT NULL,

    CONSTRAINT fk_ders_egitmen
        FOREIGN KEY (egitmenNo)
        REFERENCES Egitmen(egitmenNo)
);
```

Bu örnekte Egitmen tablosu önce oluşturulur. Ders tablosundaki `egitmenNo`, Egitmen tablosuna referans veren FK'dir.

`NOT NULL`, eğitmen numarasının boş bırakılmasını önler. FK ise var olmayan bir eğitmene referans verilmesini engeller.

N:M ilişkide bileşik PK şu şekilde tanımlanabilir:

```sql
CREATE TABLE Kayit (
    uyeNo INT NOT NULL,
    dersNo INT NOT NULL,
    kayitTarihi DATE NOT NULL,

    PRIMARY KEY (uyeNo, dersNo),

    FOREIGN KEY (uyeNo)
        REFERENCES Uye(uyeNo),

    FOREIGN KEY (dersNo)
        REFERENCES Ders(dersNo)
);
```

Bu ikinci örneğin çalışabilmesi için `Uye` ve `Ders` tablolarının önceden oluşturulmuş olması gerekir.

## 17. Sınavda İlişkisel Şema Sorusu Çözme Yöntemi

1. Senaryodaki güçlü ve zayıf varlıkları belirle.
2. Her varlık için tablo ve PK oluştur.
3. Çok değerli nitelikleri ayrı tablolarla temsil et.
4. Türetilen niteliklerin ayrıca saklanmasının gerekip gerekmediğini değerlendir.
5. Her 1:N ilişkide FK'yi N tarafına yerleştir.
6. Her N:M ilişki için ara tablo oluştur ve ilişki niteliklerini bu tabloya ekle.
7. Zayıf varlığın PK'sini sahip varlığın anahtarı ve kısmi anahtarla oluştur.
8. İsteğe bağlı ve zorunlu katılımlara göre NULL/NOT NULL durumunu düşün.
9. Bileşik anahtarların hangi tekrarları engellediğini kontrol et.
10. Gereksiz tekrar, kısmi bağımlılık ve geçişli bağımlılık olup olmadığını incele.

## 18. Sık Yapılan Hatalar

- PK ile FK'yi birbiriyle karıştırmak.
- Her tablonun kendi PK'si olabileceğini unutmak.
- 1:N ilişkide FK'yi yanlışlıkla 1 tarafına koymak.
- N:M ilişki için ara tablo oluşturmamak.
- Çok değerli telefonları tek metin alanında liste olarak saklamak.
- Zayıf varlığın kısmi anahtarını tek başına PK kabul etmek.
- Her FK'nin benzersiz olması gerektiğini düşünmek.
- Bileşik PK'nin yalnızca tek bir sütundan oluştuğunu sanmak.
- İsteğe bağlı bir ilişkiyi gereksiz yere NOT NULL yapmak.
- Kısmi bağımlılıkla geçişli bağımlılığı birbirine karıştırmak.
- Senaryoda tekrar eden kayıtların mümkün olup olmadığını düşünmeden PK seçmek.

## 19. Hızlı Tekrar

**1:N:** FK, N tarafına yerleştirilir.

**N:M:** Ara tablo oluşturulur; iki varlığın anahtarları FK olur.

**1:1:** Uygun tarafa FK ve genellikle UNIQUE kısıtı eklenir.

**Çok değerli nitelik:** Ayrı tabloya dönüştürülür.

**Zayıf varlık:** Sahip varlığın anahtarıyla birlikte tanımlanır.

**1NF:** Atomik değerler ve tekrarlayan grupların kaldırılması.

**2NF:** Kısmi bağımlılığın kaldırılması.

**3NF:** Uygunsuz geçişli bağımlılıkların kaldırılması.

**En önemli sınav kuralı:** Her tablonun hangi varlıktan veya ilişkiden oluştuğunu, PK'nin neden seçildiğini ve FK'nin neden o tabloda bulunduğunu açıklayabiliyorsan E-R modelinden ilişkisel şemaya dönüşümün temel mantığını anlamışsın demektir.

---

**Sonraki konu:** SQL SELECT, WHERE, JOIN, GROUP BY, HAVING, ORDER BY, toplulaştırma fonksiyonları ve sorgu sonuçlarının elle hesaplanması.
