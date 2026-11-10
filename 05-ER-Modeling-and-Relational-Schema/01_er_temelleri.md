# 01 — E-R Diyagramı Temelleri ve Chen Gösterimi

**Ders:** Veritabanı Yönetim Sistemleri  
**Konu:** Varlıklar, nitelikler, anahtarlar, güçlü ve zayıf varlıklar  
**Amaç:** Verilen bir senaryodaki veritabanı bileşenlerini belirlemek ve Chen gösterimiyle modelleyebilmek.

---

## 1. E-R Diyagramı Nedir?

E-R (Entity–Relationship), Türkçede Varlık–İlişki modeli olarak adlandırılır. Bir veritabanının tasarım aşamasında hangi varlıkların bulunacağını, bu varlıkların hangi özelliklere sahip olacağını ve birbirleriyle nasıl ilişkilendirileceğini göstermek için kullanılır.

Örneğin bir üniversite otomasyonunda öğrenci, ders ve öğretmen bilgilerini saklamak istiyoruz. SQL tablolarını oluşturmadan önce ÖĞRENCİ, DERS ve ÖĞRETMEN varlıklarını belirler, bunların özelliklerini tanımlar ve aralarındaki ilişkileri kurarız.

**Önemli:** E-R diyagramı doğrudan SQL kodu değildir. Veritabanının kavramsal tasarımını gösterir. Bu model daha sonra ilişkisel şemaya ve SQL tablolarına dönüştürülür.

## 2. Varlık (Entity)

Varlık, hakkında bilgi saklamak istediğimiz ve birbirinden ayırt edilebilen nesne veya kavramdır.

Örneğin FitZone spor salonu senaryosunda ÜYE, PAKET, EĞİTMEN ve DERS birer varlıktır.

Chen gösteriminde varlıklar dikdörtgen şeklinde çizilir.

**Örnek:**

`[ÜYE]`  
`[PAKET]`  
`[EĞİTMEN]`

Bir senaryodaki varlıkları belirlerken isimlere ve bağımsız olarak hakkında bilgi saklanıp saklanmayacağına dikkat edilir. Ancak metindeki her isim ayrı bir varlık değildir. Örneğin üye adı veya paket ücreti, başlı başına varlık yerine ilgili varlığın niteliği olabilir.

## 3. Nitelik (Attribute)

Nitelik, bir varlığın sahip olduğu özelliği veya hakkında saklanan bilgiyi ifade eder.

**Örnek:**

| Varlık | Nitelikler |
|---|---|
| ÜYE | üyeNo, ad, soyad, doğumTarihi |
| PAKET | paketNo, ad, ücret, süreAy |
| EĞİTMEN | eğitmenNo, ad, uzmanlık |
| DERS | dersNo, ad, kapasite |

Chen gösteriminde nitelikler elips ile çizilir ve ait oldukları varlığa çizgiyle bağlanır.

Nitelikler farklı türlerde olabilir. Bunlar basit, bileşik, çok değerli, türetilen ve anahtar nitelikler olarak incelenir.

### 3.1. Basit nitelik

Anlamlı daha küçük alt bileşenlere ayrılması gerekmeyen niteliktir. Örneğin bir öğrencinin numarası basit nitelik olarak düşünülebilir.

**Gösterim:** Tek elips.

### 3.2. Bileşik nitelik

Kendi içinde alt özelliklere ayrılabilen niteliktir. Örneğin adres bilgisi şehir, ilçe, mahalle ve sokak olarak ayrılabilir.

Chen gösteriminde alt nitelikler ana niteliğe bağlanır.

**Örnek:**

- ADRES
  - şehir
  - ilçe
  - mahalle

Burada ADRES bileşik bir niteliktir. Bu kavram, ileride göreceğimiz bileşik anahtarla karıştırılmamalıdır.

### 3.3. Çok değerli nitelik (Multivalued Attribute)

Bir varlık için birden fazla değer alabilen niteliktir.

FitZone senaryosunda bir üyenin birden fazla telefon numarası olabilir. Bu nedenle telefon, çok değerli niteliktir.

**Chen gösterimi:** Çift elips.

**Örnek:**

Üye 101 → 0532..., 0544...

Bu bilgileri ilişkisel modele aktarırken genellikle ayrı bir telefon tablosu oluşturulur. Böylece aynı üyenin birden fazla telefon numarası düzenli biçimde saklanabilir.

### 3.4. Türetilen nitelik (Derived Attribute)

Başka bir nitelikten hesaplanabilen özelliktir.

Örneğin yaş bilgisi doğum tarihinden hesaplanabilir.

**Chen gösterimi:** Kesikli elips.

**Örnek:**

- doğumTarihi = 2005-04-10
- yaş = sorgulama tarihine göre hesaplanır

Yaşı ayrıca saklamak yerine gerektiğinde doğum tarihinden hesaplamak çoğu tasarımda daha uygundur. Böylece yaş bilgisinin zamanla güncelliğini kaybetmesi önlenir.

**Sınav uyarısı:** Türetilen nitelik ile zayıf varlık farklı kavramlardır. Yaş türetilen niteliktir; bağımsız tanımlanamayan ACİL KİŞİ ise zayıf varlık olabilir.

## 4. Anahtarlar (Keys)

Anahtarlar, tablodaki veya varlık kümesindeki kayıtların nasıl tanımlanacağını belirlemek için kullanılır.

### 4.1. Süper anahtar (Super Key)

Bir kaydı benzersiz olarak tanımlayabilen bir veya birden fazla nitelikten oluşan kümedir.

Örneğin öğrenci numarası benzersiz ise hem `(ogrenciNo)` hem de `(ogrenciNo, ogrenciAd)` birer süper anahtar olabilir.

### 4.2. Aday anahtar (Candidate Key)

Bir kaydı benzersiz tanımlayan ve gereksiz nitelik içermeyen minimal süper anahtardır.

Örneğin hem öğrenci numarası hem de kurumsal e-posta adresi ayrı ayrı benzersizse ikisi de aday anahtar olabilir.

### 4.3. Birincil anahtar (Primary Key — PK)

Aday anahtarlardan seçilerek kayıtların temel kimliği olarak kullanılan anahtardır.

Örneğin ÖĞRENCİ varlığında `ogrenciNo` birincil anahtar olabilir.

**Özellikleri:**

- Her kaydı benzersiz tanımlar.
- NULL değer alamaz.
- Aynı değer iki farklı kayıt için kullanılamaz.

**Chen gösterimi:** Anahtar niteliğin ismi altı çizili yazılır.

### 4.4. Alternatif anahtar (Alternate Key)

Aday anahtarlar arasından birincil anahtar olarak seçilmeyen diğer anahtarlardır.

Örneğin `ogrenciNo` PK seçilmişse benzersiz kurumsal e-posta adresi alternatif anahtar olabilir.

### 4.5. Bileşik anahtar (Composite Key)

Birden fazla nitelikten oluşan anahtardır.

Örneğin bir öğrencinin bir derse kaydı `(ogrenciNo, dersNo)` birleşimiyle tanımlanabilir.

Burada yalnızca öğrenci numarası veya yalnızca ders numarası bütün kayıtları benzersiz tanımlamaya yetmeyebilir.

### 4.6. Yabancı anahtar (Foreign Key — FK)

Bir tablodaki sütunun veya sütun grubunun başka bir tablonun aday anahtarına (genellikle PK'sine) referans vermesini sağlayan kısıttır.

Örneğin bir DERS tablosunda `egitmenNo`, EĞİTMEN tablosundaki `egitmenNo` alanına referans verebilir.

**Önemli ayrım:** PK kaydın kimliğini belirler; FK tablolar arasında referans bütünlüğü kurulmasını sağlar.

## 5. Güçlü Varlık (Strong Entity)

Güçlü varlık, başka bir varlığın kimliğine bağımlı olmadan kendi anahtarıyla tanımlanabilen varlıktır.

FitZone örneğinde ÜYE, benzersiz `üyeNo` alanına sahip olduğu için güçlü varlıktır.

**Chen gösterimi:** Tek çizgili dikdörtgen.

Örnek:

`[ÜYE]`

Anahtar niteliği: `üyeNo`

## 6. Zayıf Varlık (Weak Entity)

Zayıf varlık, kendi kısmi anahtarıyla tek başına benzersiz tanımlanamayan ve kimliği başka bir varlığa bağlı olan varlıktır.

FitZone senaryosundaki ACİL KİŞİ örneğinde sıra numarası yalnızca ait olduğu üye içinde anlamlıdır.

**Örnek kayıtlar:**

| üyeNo | sıraNo | ad |
|---|---|---|
| 101 | 1 | Ayşe |
| 101 | 2 | Mehmet |
| 102 | 1 | Zeynep |

Bu örnekte `sıraNo` tek başına benzersiz değildir. Ancak `(üyeNo, sıraNo)` birleşimi her acil kişiyi tanımlayabilir.

- Güçlü varlık: ÜYE
- Zayıf varlık: ACİL KİŞİ
- Kısmi anahtar: sıraNo
- İlişkisel modeldeki bileşik PK: (üyeNo, sıraNo)

**Chen gösterimi:** Zayıf varlık çift dikdörtgenle, tanımlayıcı ilişki çift eşkenar dörtgenle gösterilir. Kısmi anahtarın altı genellikle kesikli çizilir.

Zayıf varlığın sahibi olan güçlü varlıkla ilişkisi, kimliğini belirlemek için gereklidir.

## 7. Chen Gösterimi — Sınav İçin Şekil Tablosu

| Kavram | Kullanılan şekil |
|---|---|
| Güçlü varlık | Tek dikdörtgen |
| Zayıf varlık | Çift dikdörtgen |
| Basit nitelik | Elips |
| Anahtar nitelik | Adı altı çizili elips |
| Çok değerli nitelik | Çift elips |
| Türetilen nitelik | Kesikli elips |
| İlişki | Eşkenar dörtgen |
| Tanımlayıcı ilişki | Çift eşkenar dörtgen |
| Zorunlu (tam) katılım | Çift bağlantı çizgisi |

**Önemli:** Bileşik nitelik, kendisine bağlı alt niteliklerin bulunduğu elipslerle gösterilir. Zayıf varlık ile çok değerli niteliğin şekilleri birbirinden farklıdır.

## 8. Örnek Chen Şeması — ÜYE

Aşağıdaki metinsel taslakta bir ÜYE varlığının temel nitelikleri gösterilmiştir. Bu bir yerleşim taslağıdır; sınav kâğıdında nitelikleri gerçek elipslerle ve gerekli çizgi biçimleriyle çizmeliyiz.

```text
                 (ad)
                  |
(üyeNo — PK) --- [ÜYE] --- ((telefon))
                  |
          (doğumTarihi)
                  |
         (- - yaş - -)
```

Bu taslakta `üyeNo` anahtar niteliktir ve çizimde altı çizilir. `telefon` çift elipsle, `yaş` kesikli elipsle gösterilir. Yaşın doğum tarihinden türetilmesi ayrıca açıklanabilir.

## 9. Örnek Şema — ÜYE ve ACİL KİŞİ

Bir üye birden fazla acil kişi tanımlayabilir ve her acil kişi tek bir üyeye bağlıdır.

**Kavramsal ilişki:**

```text
[ÜYE] --- <tanımlayıcı ilişki> --- [[ACİL KİŞİ]]
  PK                                 kısmi anahtar
 üyeNo                                  sıraNo
```

Burada çift köşeli gösterim zayıf varlığı hatırlatmak içindir. Gerçek Chen çiziminde ACİL KİŞİ çift dikdörtgen, tanımlayıcı ilişki ise çift eşkenar dörtgen olmalıdır.

İlişkisel şemaya dönüştürüldüğünde:

**UYE**(uyeNo [PK], ad, soyad, dogumTarihi)

**ACIL_KISI**(uyeNo [PK, FK], siraNo [PK], ad, telefon)

Bu şemada `uyeNo`, ACIL_KISI tablosunda hem bileşik PK'nin parçasıdır hem de UYE tablosuna referans veren FK'dir.

İlişki çizgileri, 1:N gösterimi ve katılım koşulları bir sonraki dersin konusudur.

## 10. Senaryodan Varlık ve Nitelik Bulma Yöntemi

Hocanın sınav formatında bir senaryo metni verildiğinde önce metindeki temel varlık adaylarını belirlemeliyiz.

Örneğin:

"Her üyenin benzersiz üye numarası, adı, soyadı ve doğum tarihi tutulur. Bir üyenin birden fazla telefon numarası olabilir ve yaşı doğum tarihinden hesaplanır."

Bu cümleden şu sonuçları çıkarabiliriz:

1. **Varlık:** ÜYE
2. **Anahtar:** üyeNo
3. **Basit nitelikler:** ad, soyad, doğumTarihi
4. **Çok değerli nitelik:** telefon
5. **Türetilen nitelik:** yaş

Metinde "benzersiz" ifadesi, anahtar adaylarını belirlemek için önemli bir ipucudur. Ancak yalnızca bu kelimeyi aramak yeterli değildir; adayın gerçekten benzersiz ve uygun bir anahtar olması gerekir.

"Birden fazla" ifadesi çok değerli nitelik veya ilişki çokluğu anlamına gelebilir. Karar verirken söz konusu bilginin ayrı bir varlık mı yoksa mevcut varlığın tekrarlanabilen bir özelliği mi olduğunu değerlendirmeliyiz.

## 11. Sınavda Sık Yapılan Hatalar

- Her ismi bağımsız varlık olarak düşünmek.
- Anahtar olarak benzersiz olmayan bir nitelik seçmek.
- Bileşik nitelik ile bileşik anahtarı karıştırmak.
- Çok değerli niteliği normal tek elipsle göstermek.
- Türetilen niteliği zayıf varlık sanmak.
- Zayıf varlığı tek dikdörtgenle çizmek.
- Kısmi anahtarı tek başına yeterli bir PK kabul etmek.
- PK ile FK arasındaki farkı karıştırmak.
- E-R diyagramı ile ilişkisel şemayı aynı gösterim sanmak.
- Şema dönüşümünde zayıf varlığın sahip varlıkla ilişkisini unutmak.

## 12. Vize İçin Kısa Tekrar

**Varlık:** Hakkında bilgi saklanacak nesne veya kavramdır.

**Nitelik:** Varlığın özelliğidir.

**Primary Key:** Bir kaydı benzersiz tanımlar.

**Foreign Key:** Başka bir tablonun anahtarına referans verir.

**Çok değerli nitelik:** Bir varlık için birden fazla değer alabilir; çift elipsle gösterilir.

**Türetilen nitelik:** Başka bilgilerden hesaplanır; kesikli elipsle gösterilir.

**Güçlü varlık:** Kendi anahtarıyla tanımlanabilir; tek dikdörtgenle gösterilir.

**Zayıf varlık:** Kimliği sahip varlığın anahtarına bağlıdır; çift dikdörtgenle gösterilir.

**Kısmi anahtar:** Zayıf varlık örneklerini aynı sahip varlık içerisinde ayırt etmeye yardımcı olur.

**Bileşik anahtar:** Birden fazla nitelikten oluşan anahtardır.

### En önemli sınav kuralı

Senaryoyu okurken önce varlıkları belirle, sonra nitelikleri ayır, benzersiz anahtarları tespit et ve özel niteliklerin çizim türlerini kontrol et. İlişki çizimine geçmeden önce bu temel yapı doğru olmalıdır.

---

**Sonraki konu:** İlişki türleri, 1:1–1:N–N:M, zorunlu ve isteğe bağlı katılım, tanımlayıcı ilişkiler ve tam Chen diyagramı çizimi.
