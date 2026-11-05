# 📌 02 - SQL Filtering & Sorting Practices

This directory documents my MySQL exercises covering conditional queries, logical operators, data modification, sorting, column aliases, date filtering, and pattern matching.

The exercises are based on my university Database Management Systems studies and **Murat Yücedağ's SQL tutorial series**.

Since the tutorial series primarily uses Microsoft SQL Server (T-SQL), relevant examples have been adapted to MySQL syntax.

---

## 📂 Contents & Script Directory

### 📄 [01_where_ve_mantiksal_operatorler.sql](./01_where_ve_mantiksal_operatorler.sql) — WHERE & Logical Operators

**Source Lessons:** SQL Lessons 8–9

**Topics Covered:**
- **Conditional Queries:** Filtering records using `WHERE`.
- **Comparison Operators:** `=`, `<>`, `!=`, `>`, `<`, `>=`, `<=`.
- **Logical Operators:** Combining conditions with `AND` and `OR`.
- **Multiple Value Filtering:** `IN` and `NOT IN`.
- **Pattern Matching:** Basic `LIKE` expressions and wildcards.
- **Range Filtering:** `BETWEEN` and inclusive boundaries.
- **NULL Handling:** `IS NULL` and `IS NOT NULL`.
- **Operator Precedence:** Understanding parentheses and logical evaluation order.
- **Error Handling:** Common syntax and column-reference errors.

**Key Learning Outcomes:**
- Writing conditional SQL queries.
- Combining multiple filtering conditions.
- Understanding comparison and logical operators.
- Distinguishing between `AND`, `OR`, and `IN`.
- Handling NULL values correctly.
- Predicting the results of conditional queries.

---

### 📄 [02_update_ve_delete.sql](./02_update_ve_delete.sql) — UPDATE & DELETE Operations

**Source Lessons:** SQL Lessons 11–12

**Topics Covered:**
- **Data Modification:** Updating existing records with `UPDATE`.
- **Column Assignment:** Using `SET` to modify single or multiple columns.
- **Conditional Updates:** Targeting records using `WHERE`.
- **Arithmetic Updates:** Modifying values using existing column data.
- **Multiple Record Updates:** Filtering with `IN`.
- **Record Deletion:** Removing records with `DELETE FROM`.
- **Conditional Deletion:** Deleting specific records using primary key conditions.
- **Safe Updates:** Understanding MySQL `Error 1175`.
- **Data Removal:** Comparing `DELETE`, `TRUNCATE`, and `DROP`.
- **Transaction Awareness:** Understanding autocommit and basic rollback considerations.

**Key Learning Outcomes:**
- Updating selected records without affecting unrelated data.
- Modifying multiple columns in a single query.
- Understanding the consequences of omitting `WHERE`.
- Deleting specific records safely.
- Recognizing MySQL Safe Updates restrictions.
- Distinguishing between data modification and table deletion.

---

### 📄 [03_distinct_orderby_as_between.sql](./03_distinct_orderby_as_between.sql) — DISTINCT, ORDER BY, AS & BETWEEN

**Source Lessons:** SQL Lessons 13–16

**Topics Covered:**
- **Duplicate Elimination:** Removing repeated result rows using `DISTINCT`.
- **Sorting:** Using `ORDER BY`, `ASC`, and `DESC`.
- **Multiple Column Sorting:** Applying different sorting directions.
- **Column Aliases:** Renaming result columns with `AS`.
- **Arithmetic Expressions:** Addition, subtraction, multiplication, and division.
- **Calculated Columns:** Displaying computed values without modifying stored data.
- **Date Filtering:** Comparing `DATE` and `DATETIME` values.
- **Range Queries:** Using `BETWEEN` and `NOT BETWEEN`.
- **Result Limitation:** Returning selected numbers of records using `LIMIT`.
- **Combined Queries:** Using `WHERE`, `ORDER BY`, and calculated columns together.

**Key Learning Outcomes:**
- Eliminating duplicate results without deleting records.
- Sorting query results in ascending or descending order.
- Understanding multi-column sorting rules.
- Creating readable column aliases.
- Performing calculations directly within SELECT queries.
- Filtering records by numeric and date ranges.
- Understanding inclusive boundaries and DATETIME comparison behavior.

---

### 📄 [04_like_komutu.sql](./04_like_komutu.sql) — LIKE & Pattern Matching

**Source Lesson:** SQL Lesson 20

**Topics Covered:**
- **Pattern Matching:** Searching text values using `LIKE`.
- **Wildcard Characters:** Using `%` and `_`.
- **Prefix Matching:** Finding values beginning with specific characters.
- **Suffix Matching:** Finding values ending with specific characters.
- **Substring Matching:** Searching for characters within text.
- **Fixed-Length Patterns:** Matching specific character positions.
- **Negative Matching:** Filtering with `NOT LIKE`.
- **Regular Expressions:** Basic pattern matching using `REGEXP`.
- **Case Sensitivity:** Understanding the effect of MySQL collations.
- **SQL Dialect Differences:** Comparing SQL Server and MySQL pattern syntax.

**Key Learning Outcomes:**
- Writing flexible text-search queries.
- Understanding the difference between `%` and `_`.
- Matching prefixes, suffixes, and fixed-length patterns.
- Using `NOT LIKE` to exclude matching values.
- Understanding NULL behavior in pattern matching.
- Recognizing SQL Server-specific LIKE syntax that requires adaptation in MySQL.

---

## 🔄 SQL Server (T-SQL) vs. MySQL

Some tutorial examples use SQL Server-specific syntax and features.

The following table summarizes important differences encountered during these exercises.

| Concept | SQL Server (T-SQL) | MySQL |
|---|---|---|
| Result limitation | `TOP 3` | `LIMIT 3` |
| Date and time | `SMALLDATETIME` | `DATETIME` as an alternative |
| Basic pattern matching | `LIKE '%a%'` | `LIKE '%a%'` |
| Character set in LIKE | `LIKE '[ab]%'` | `REGEXP '^[ab]'` or multiple LIKE conditions |
| Column aliases | `AS [New Name]` | `AS \`New Name\`` |
| Conditional updates | `UPDATE ... WHERE` | `UPDATE ... WHERE` |
| Safe update protection | No identical default SSMS restriction | `SQL_SAFE_UPDATES` may restrict operations |
| Date conversion | `CONVERT()` / `CAST()` | `STR_TO_DATE()` / `CAST()` depending on usage |
| Date arithmetic | `DATEADD()` | `DATE_ADD()` |

> **Note:** These mappings represent practical alternatives rather than exact behavioral equivalents. Syntax, date precision, transaction behavior, and pattern-matching features may differ between database systems.

---

## 🛠️ Study Methodology

Each SQL topic follows a structured learning process:

1. Study the concept through university materials or tutorial videos.
2. Write SQL queries independently in MySQL Workbench.
3. Execute statements and analyze the returned results.
4. Identify syntax errors and understand their causes.
5. Review technical accuracy and MySQL compatibility.
6. Add detailed Turkish explanations and revision notes.
7. Organize the completed exercises on GitHub.

AI-assisted tools may be used for technical review, SQL dialect adaptation, error explanation, and documentation improvements.

The primary objective is to understand query execution logic, filtering behavior, and data modification rather than simply collect working SQL examples.

---

## ⚠️ Important Practice Notes

- **Environment:** MySQL 8.x and MySQL Workbench.
- **Practice Database:** `kitaplık`.
- **Practice Tables:** `Kitap`, `KitapDMLPratik`, and `KitapSorguPratik`.
- **Setup Order:** The `03_distinct_orderby_as_between.sql` script creates `KitapSorguPratik`, which is required by `04_like_komutu.sql`.
- **Data Safety:** Some scripts contain `DROP TABLE IF EXISTS` statements that reset dedicated practice tables.
- **Duplicate Records:** Repeating INSERT operations without appropriate uniqueness constraints may create duplicate records.
- **UPDATE & DELETE:** Missing WHERE conditions may affect every record in a table.
- **Safe Updates:** MySQL Workbench may block unsafe modification queries with `Error 1175`.
- **NULL Handling:** NULL represents missing or unknown information and requires appropriate SQL conditions.
- **Date Comparison:** DATETIME values include time components, which can affect date-range filtering.
- **SQL Dialects:** SQL Server-specific commands must be reviewed before execution in MySQL.
- **Documentation:** SQL explanations and exam revision notes are written in Turkish.
- **Scope:** These scripts are educational exercises, not production-ready database implementations.

---

## 🎯 Next Learning Topics

The next module focuses on SQL aggregate functions, grouping, and group-level filtering.

**Planned topics:**
- `COUNT()`
- `SUM()`
- `AVG()`
- `MIN()` and `MAX()`
- `COUNT(DISTINCT ...)`
- `GROUP BY`
- `HAVING`
- Combining `WHERE`, `GROUP BY`, and `HAVING`
- Multi-column grouping
- Aggregate functions and NULL handling

These topics will be documented in the upcoming `03-Aggregate-Functions` directory.

---

*This directory is part of my ongoing MySQL learning and practice repository.*
