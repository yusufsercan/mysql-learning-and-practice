# 📌 01 - SQL Basics & DDL/DML Practices

This directory covers the foundational building blocks of Relational Database Management Systems (RDBMS), Data Definition Language (DDL) constraints, Data Manipulation Language (DML) operations, and comprehensive SQL data types. 

The content is synthesized from university coursework (**Database Management Systems**) and **Murat Yücedağ's SQL Lecture Series**, adapted and standardized directly for MySQL environments.

> ⚠️ **Note:** All SQL scripts, queries, and architectural notes in this directory are prepared strictly for **academic tracking, personal learning, and practical laboratory exercises**. They do not claim any official qualification, professional certification, or production-grade architecture status.

---

## 📂 Contents & Script Directory

* 📄 [`01_ddl_ve_dml_temelleri.sql`](./01_ddl_ve_dml_temelleri.sql) — **DDL & DML Fundamentals:** Schema definitions, primary key constraints, single/bulk insert, and maintenance operations.- **Schema & Table Management:** Essential commands including `CREATE DATABASE`, `USE`, `DROP TABLE IF EXISTS`, and `CREATE TABLE`.
- **Integrity Constraints:**
  - `PRIMARY KEY`: Enforces Entity Integrity by ensuring unique row identification and disallowing `NULL` values.
  - `NOT NULL`: Enforces mandatory field input at the schema level.
- **Data Manipulation (DML):**
  - Single-row `INSERT INTO ... VALUES (...)` statements.
  - Multi-row bulk insertion syntax.
  - Data retrieval via `SELECT *`.
  - Rapid table truncation via `TRUNCATE TABLE` (resets data while preserving the table schema).
- **Encountered Errors & Engineering Fixes:**
  - `Error 1064 (Syntax Error)`: Preventing trailing commas after the final column definition.
  - `Error 1062 (Duplicate Entry)`: Resolving primary key collision caused by duplicate identifier insertion.

### 2. `02_veri_tipleri_rehberi.sql`
- **Numeric Types:** `BIGINT` (8-byte large integers), `INT` (standard 4-byte integers), `SMALLINT` (2-byte), `TINYINT` (1-byte), and `BOOLEAN` (logical bit/flag).
- **Financial Precision:** Implementing `DECIMAL(p, s)` to prevent floating-point rounding anomalies typical of `FLOAT`/`DOUBLE`.
- **String Types:** Fixed-length `CHAR(n)` for static patterns (e.g., National ID) vs variable-length `VARCHAR(n)` for dynamic text.
- **Temporal Types:** `DATE` (calendar dates), `DATETIME` (combined timestamp), `TIMESTAMP` (timezone-aware UTC storage), and `TIME` (duration/time of day).
- **Spatial & Specialized:** `GEOMETRY` for spatial/GIS data and `CHAR(36)` optimized for Universal Unique Identifiers (UUID v4).

---

## 🛠️ Syntax Translation Guide (MSSQL / T-SQL ➡️ MySQL)

Mapping table between Microsoft SQL Server implementations used in video references and MySQL ANSI standards used in this repository:

| Concept / Type | MSSQL (T-SQL) | MySQL (Repository Standard) |
| :--- | :--- | :--- |
| **Media / File Storage** | `image` | `VARCHAR(255)` (File Path) or `LONGBLOB` |
| **Large Text** | `nvarchar(MAX)` | `LONGTEXT` |
| **Boolean Flag** | `bit` | `BOOLEAN` / `TINYINT(1)` |
| **Compact Timestamp** | `smalldatetime` | `DATETIME` |
| **Currency** | `money` / `smallmoney` | `DECIMAL(19,4)` / `DECIMAL(10,2)` |
| **Unique Identifier** | `uniqueidentifier` | `CHAR(36)` (UUID) |
| **Unicode Characters** | `nchar(10)` | `CHAR(10)` (utf8mb4) |

---

## 💡 Engineering Best Practices
> - **Storage Decoupling:** Large binary files (images, PDFs, documents) must not be stored directly inside database rows to avoid severe engine and I/O bottlenecks; storing local paths or object storage URLs as `VARCHAR` is standard practice.
> - **Statement Isolation:** Every independent SQL statement must terminate with a semicolon (`;`) to guarantee deterministic query parsing and prevent engine execution errors.
