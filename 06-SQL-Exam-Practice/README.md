# 06 — SQL Exam Practice

This directory contains exam-oriented MySQL exercises developed as part of my university Database Management Systems (VYS) coursework.

The main purpose of this module is to strengthen my ability to understand SQL queries, combine relational tables, predict query results, and solve database examination questions independently.

Unlike previous modules, which focus on learning individual SQL concepts, this module emphasizes **practical problem-solving, query execution analysis, and expected result tables**.

The exercises use a fictional fitness center database called **FitZone** and are designed to reinforce SQL concepts through realistic relational data.

---

## 📂 Contents & Script Directory

### 📄 [00_fitzone_pratik_veri_seti.sql](./00_fitzone_pratik_veri_seti.sql) — FitZone Practice Database

**Topics Covered:**

- Creating a dedicated MySQL practice database.
- Defining tables and their columns.
- Using primary keys and foreign keys.
- Establishing relationships between tables.
- Inserting sample records.
- Understanding one-to-many and many-to-many relationships.
- Preparing consistent data for JOIN and aggregation exercises.

**Tables Used:**

| Table | Description |
|---|---|
| Uye | Fitness center members |
| Egitmen | Instructors |
| Ders | Available fitness classes |
| Kayit | Member registrations for classes |

**Key Learning Outcomes:**

- Understanding relational table structures.
- Recognizing primary-key and foreign-key relationships.
- Identifying how data is distributed across multiple tables.
- Preparing sample data for complex SQL queries.

---

### 📄 [01_join_groupby_having_pratik.sql](./01_join_groupby_having_pratik.sql) — SQL Query Practice

This file contains exam-style SQL exercises focused on relational queries, filtering, aggregation, and multi-table operations.

**Topics Covered:**

- SELECT and column aliases.
- WHERE and conditional filtering.
- DISTINCT and duplicate elimination.
- ORDER BY with multiple columns.
- INNER JOIN and LEFT JOIN.
- Table aliases and ON conditions.
- Joining three or more tables.
- GROUP BY and HAVING.
- COUNT and COUNT(DISTINCT).
- Aggregate functions.
- Identifying members without related records.
- Introductory nested SELECT queries.

**Study Approach:**

Exercises are structured around SQL problems rather than isolated syntax examples. The goal is to understand which tables are needed, how they should be connected, which conditions should be applied, and how the query result is produced.

**Key Learning Outcomes:**

- Writing queries involving multiple related tables.
- Selecting the appropriate JOIN type.
- Using PK/FK relationships in ON conditions.
- Distinguishing row filtering from group filtering.
- Understanding how JOIN operations affect row counts.
- Recognizing differences between total and distinct counts.
- Combining several SQL concepts within a single query.

---

### 📄 [02_sorgu_sonuc_tablolari.md](./02_sorgu_sonuc_tablolari.md) — SQL Result Tables and Explanations

This document serves as a detailed study guide for the SQL practice exercises.

It includes:

- 13 SQL exam-style questions.
- Step-by-step solution approaches.
- Expected query result tables.
- Explanations of why specific rows appear in the output.
- Notes on common SQL mistakes.
- Strategies for approaching multi-table queries.
- A quick reference for JOIN, WHERE, GROUP BY, HAVING, COUNT, and other important SQL features.

**Key Learning Outcomes:**

- Predicting SQL query outputs without executing the code.
- Understanding row matching in INNER JOIN and LEFT JOIN.
- Explaining the effect of filtering conditions.
- Calculating grouped results manually.
- Identifying NULL-related counting issues.
- Developing a systematic SQL exam-solving method.

---

## 🧠 Study Methodology

My learning process follows a practical and explanation-based workflow:

1. Review the FitZone database structure and understand its table relationships.
2. Read each SQL practice question carefully and identify the requested information.
3. Determine which tables and relationships are necessary.
4. Attempt to write the SQL query independently.
5. Predict the expected result table before executing the query.
6. Run the query in MySQL Workbench and compare the actual output with the prediction.
7. Review the provided explanation to understand incorrect assumptions or missing conditions.
8. Repeat similar problems without looking at the original solution.

The objective is to improve SQL reasoning and problem-solving skills rather than simply memorize query syntax.

---

## 🎯 Exam Preparation Goals

By completing this module, I aim to become more confident in:

- Reading complex SQL statements.
- Understanding table aliases and qualified column references.
- Writing correct JOIN conditions.
- Combining multiple related tables.
- Applying WHERE and HAVING conditions correctly.
- Calculating aggregate values.
- Using GROUP BY and DISTINCT appropriately.
- Predicting the exact output of SQL queries.
- Solving university-level database examination questions under time constraints.

---

## 🛠 Development Environment

- **Database Management System:** MySQL 8.x
- **SQL Editor:** MySQL Workbench
- **Version Control:** Git & GitHub
- **Practice Database:** FitZone
- **Study Context:** University Database Management Systems coursework

## SQL Dialect

All executable SQL examples in this module are intended for MySQL.

Some learning resources and university materials may use Microsoft SQL Server syntax. Where necessary, examples are adapted to MySQL while preserving their underlying relational logic.

---

## 📝 Repository Notes

SQL comments, worked examples, explanations, and revision notes are primarily written in Turkish to support my personal study process and university exam preparation.

README documentation is maintained in English for consistency across the repository.

The examples use fictional data and are intended for learning purposes.

This module extends the earlier SQL fundamentals, filtering, aggregation, JOIN, and database modeling modules with exam-focused exercises.

---

## 📌 Related Modules

- [01-SQL-Basics](../01-SQL-Basics) — SQL fundamentals and database operations.
- [02-Filtering-and-Sorting](../02-Filtering-and-Sorting) — Conditional queries, filtering, and sorting.
- [03-Aggregate-Functions](../03-Aggregate-Functions) — Aggregate functions and grouping.
- [04-Joins-and-Relationships](../04-Joins-and-Relationships) — Relational queries and JOIN operations.
- [05-ER-Modeling-and-Relational-Schema](../05-ER-Modeling-and-Relational-Schema) — E-R modeling, relational schemas, and normalization.

---

**Repository:** [MySQL Learning & Practice](https://github.com/yusufsercan/mysql-learning-and-practice)

**Purpose:** Building practical SQL knowledge through university coursework, hands-on exercises, and structured exam preparation.
