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
- **
