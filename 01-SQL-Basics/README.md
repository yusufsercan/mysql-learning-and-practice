
# 📌 01 - SQL Basics & DDL/DML Practices

This directory documents my introductory MySQL exercises, covering database creation, table structures, SQL data types, constraints, data manipulation, and schema modifications.

The exercises are based on my university Database Management Systems coursework and **Murat Yücedağ's SQL tutorial series**.

Since the tutorial series primarily uses Microsoft SQL Server (T-SQL), relevant examples have been adapted to MySQL syntax.

---

## 📂 Contents & Script Directory

### 📄 [01_ddl_ve_dml_temelleri.sql](./01_ddl_ve_dml_temelleri.sql) — DDL, DML & Basic Queries

**Topics Covered:**
- **Database Management:** `CREATE DATABASE`, `USE`.
- **Table Creation:** `CREATE TABLE`, `DROP TABLE IF EXISTS`.
- **Integrity Constraints:** `PRIMARY KEY`, `NOT NULL`.
- **Data Manipulation:** Single-row and multi-row `INSERT INTO`.
- **Data Retrieval:** `SELECT *`, selecting specific columns.
- **Table Inspection:** `DESCRIBE`.
- **Table Maintenance:** `TRUNCATE TABLE` and its differences from `DELETE` and `DROP`.
- **Error Handling:** Common MySQL errors such as `1064`, `1062`, `1046`, and `1050`.

**Key Learning Outcomes:**
- Understanding DDL, DML, and DQL classifications.
- Creating tables with appropriate constraints.
- Inserting and retrieving records.
- Distinguishing between table deletion and data removal.
- Recognizing potentially destructive SQL operations.

---

### 📄 [02_veri_tipleri_rehberi.sql](./02_veri_tipleri_rehberi.sql) — MySQL Data Types

**Topics Covered:**
- **Integer Types:** `TINYINT`, `SMALLINT`, `MEDIUMINT`, `INT`, `BIGINT`.
- **Integer Ranges:** `SIGNED` vs. `UNSIGNED`.
- **Exact and Approximate Numbers:** `DECIMAL`, `NUMERIC`, `FLOAT`.
- **String Types:** `CHAR`, `VARCHAR`.
- **Boolean Representation:** `BOOLEAN` and `TINYINT(1)`.
- **Date and Time:** `DATE`, `TIME`, `DATETIME`, `TIMESTAMP`.
- **Binary and Large Text:** `BINARY`, `LONGTEXT`.
- **Spatial Data:** `GEOMETRY`.
- **Identifiers:** UUID representation using `CHAR(36)`.
- **Practical Exercises:** Creating tables and inserting sample values.

**Key Learning Outcomes:**
- Selecting appropriate data types.
- Understanding numeric ranges and precision.
- Comparing fixed-length and variable-length strings.
- Distinguishing exact decimal values from approximate floating-point values.
- Understanding differences between SQL Server and MySQL data types.

---

### 📄 [03_alter_ve_tablo_guncelleme.sql](./03_alter_ve_tablo_guncelleme.sql) — ALTER TABLE & Schema Modifications

**Topics Covered:**
- **Schema Evolution:** Modifying existing tables with `ALTER TABLE`.
- **Column Addition:** `ADD COLUMN` and multi-column additions.
- **Column Removal:** `DROP COLUMN` and multi-column removal.
- **Schema Inspection:** `DESCRIBE`, `DESC`.
- **Table Definitions:** `SHOW CREATE TABLE`.
- **Constraints:** Understanding how structural changes may affect keys and indexes.
- **Data Safety:** Risks associated with destructive schema modifications.

**Key Learning Outcomes:**
- Modifying table structures without recreating tables.
- Adding and removing columns.
- Inspecting table definitions after changes.
- Understanding implicit commits and data loss risks.
- Recognizing MySQL-specific syntax differences.

---

## 🔄 SQL Server (T-SQL) vs. MySQL

Some tutorial examples use SQL Server-specific data types and syntax.

The following table summarizes alternatives used in MySQL.

| Concept | SQL Server | MySQL Alternative |
|---|---|---|
| Boolean values | `bit` | `BOOLEAN` / `TINYINT(1)` / `BIT(1)` |
| Currency | `money` | `DECIMAL(19,4)` |
| Small currency | `smallmoney` | `DECIMAL(10,2)` |
| Large Unicode text | `nvarchar(MAX)` | `LONGTEXT` |
| Date and time | `smalldatetime` | `DATETIME` |
| Unique identifier | `uniqueidentifier` | `CHAR(36)` / `BINARY(16)` |
| Binary media | `image` | `BLOB` types / External file reference |
| Fixed Unicode text | `nchar(n)` | `CHAR(n)` with Unicode character set |

> **Note:** These are practical alternatives rather than exact behavioral equivalents. Storage characteristics, precision, constraints, and database-specific behavior may differ.

---

## 🛠️ Study Methodology

Each SQL topic follows a structured learning process:

1. Study the topic through university materials or tutorial videos.
2. Write and execute SQL statements in MySQL Workbench.
3. Examine query results and identify possible errors.
4. Review technical accuracy and MySQL compatibility.
5. Add detailed Turkish explanations and revision notes.
6. Organize the completed exercises on GitHub.

AI-assisted tools may be used for technical review, SQL dialect adaptation, and documentation improvements.

The primary objective is to understand how each statement works rather than simply collect working SQL examples.

---

## ⚠️ Important Practice Notes

- **Environment:** MySQL 8.x and MySQL Workbench.
- **Practice Database:** `lab_db`.
- **Data Safety:** Some scripts contain `DROP TABLE IF EXISTS`, which removes existing practice tables and their data.
- **TRUNCATE:** Removes all table rows while preserving the table structure and cannot be rolled back as an ordinary MySQL transaction.
- **SQL Statements:** Semicolons (`;`) are used to separate SQL statements.
- **Documentation:** SQL explanations are written in Turkish for learning and university exam preparation.
- **Scope:** These scripts are educational exercises, not production-ready database implementations.

---

## 🎯 Next Learning Topics

The next module focuses on SQL filtering, conditional expressions, and sorting.

**Planned topics:**
- `WHERE`
- `AND`, `OR`, `NOT`
- `IN`, `BETWEEN`
- `IS NULL`, `IS NOT NULL`
- `LIKE`
- `DISTINCT`
- `ORDER BY`
- `LIMIT`

These topics will be documented in the upcoming `02-Filtering-and-Sorting` directory.

---

*This directory is part of my ongoing MySQL learning and practice repository.*
