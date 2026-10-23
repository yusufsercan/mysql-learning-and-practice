# 📌 01 - SQL Temelleri ve DDL/DML Pratikleri

Bu klasör; ilişkisel veritabanı yönetim sistemlerinin (RDBMS) temel yapı taşlarını, tablo tanımlama kurallarını (DDL), veri işleme komutlarını (DML) ve SQL veri tiplerini kapsamaktadır.

---

## 📂 İçerik ve Dosya Rehberi

### 1. `01_ddl_ve_dml_temelleri.sql`
- **Şema ve Tablo Yönetimi:** `CREATE DATABASE`, `USE`, `DROP TABLE IF EXISTS` ve `CREATE TABLE` komutları.
- **Kısıtlar (Constraints):**
  - `PRIMARY KEY`: Tabloda varlık bütünlüğünü (Entity Integrity) sağlar; sütunun benzersiz olmasını zorunlu kılar ve `NULL` değer kabul etmez.
  - `NOT NULL`: Zorunlu veri giriş alanlarını tanımlar.
- **Veri Manipülasyonu (DML):**
  - Tek satırlı `INSERT INTO ... VALUES (...)` kullanımı.
  - Çoklu (toplu) veri ekleme yapısı.
  - `SELECT *` ile kayıt listeleme.
  - `TRUNCATE TABLE` ile tablo yapısını bozmadan tüm veriyi sıfırlama.
- **Karşılaşılan Hatalar ve Mühendislik Çözümleri:**
  - `Error 1064 (Syntax Error)`: Tablo oluştururken son sütunun ardından virgül konulmaması kuralı.
  - `Error 1062 (Duplicate Entry)`: Önceden eklenmiş bir `PRIMARY KEY` değerinin tekrar girilmeye çalışılması durumu.

### 2. `02_veri_tipleri_rehberi.sql`
- **Sayısal Tipler:** `BIGINT` (8 byte devasa sayılar), `INT` (standart tam sayı), `SMALLINT` (2 byte), `TINYINT` (1 byte), `BOOLEAN` (1 bit mantıksal).
- **Finans ve Hassasiyet:** Yuvarlama hatalarını önlemek için `FLOAT` yerine kesin hesaplama sunan `DECIMAL(p, s)` kullanımı.
- **Metin Tipleri:** `CHAR(n)` (sabit uzunluklu alanlar, örn: TC No) ve `VARCHAR(n)` (değişken uzunluklu metinler).
- **Zaman Tipleri:** `DATE` (sadece gün), `DATETIME` (tarih + saat), `TIMESTAMP` (saat dilimi duyarlı) ve `TIME` (sadece saat).
- **Özel Alanlar:** Harita/GIS verileri için `GEOMETRY`, evrensel kimlikler için `UUID` formatında `CHAR(36)`.

---

## 🛠️ Çeviri Kılavuzu (MSSQL / T-SQL ➡️ MySQL)

Murat Yücedağ eğitim serisinde gösterilen MSSQL sözdizimlerinin MySQL standartlarındaki karşılıkları:

| Kavram / Tip | MSSQL (T-SQL) | MySQL (Kullandığımız Standart) |
| :--- | :--- | :--- |
| **Görsel / Dosya Saklama** | `image` | `VARCHAR(255)` (Yol tutulur) veya `LONGBLOB` |
| **Büyük Metin** | `nvarchar(MAX)` | `LONGTEXT` |
| **Mantıksal (0/1)** | `bit` | `BOOLEAN` / `TINYINT(1)` |
| **Kısa Tarih** | `smalldatetime` | `DATETIME` |
| **Para Birimi** | `money` / `smallmoney` | `DECIMAL(19,4)` / `DECIMAL(10,2)` |
| **Benzersiz Kimlik** | `uniqueidentifier` | `CHAR(36)` (UUID) |
| **Unicode Metin** | `nchar(10)` | `CHAR(10)` (utf8mb4) |

---

## 💡 Mühendislik Notları
> - **Depolama Mantığı:** Resim, video veya PDF gibi büyük dosyaların saf ikili (binary) verileri veritabanı motorunu şişirmemek adına doğrudan tabloya gömülmez; sunucu dosya yolunun (`path`) metin olarak saklanması esastır.
> - **Sözdizimi İzolasyonu:** Her SQL komutunun bağımsız çalışabilmesi için satır sonlarına noktalı virgül (`;`) eklenmelidir.
