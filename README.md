# SQL Practice

**A structured practice repository for developing proficiency in SQL**, with emphasis on analytical queries commonly used in data analysis, business intelligence, and technical interviews.

---

## Overview

This repository contains carefully organized SQL scripts covering foundational to intermediate concepts. The material is designed to build practical query-writing skills suitable for:

- Data analysis roles
- Academic projects involving databases
- Technical interviews

Queries are written in a style compatible with major relational databases (MySQL, PostgreSQL, SQLite) and focus on real-world analytical patterns.

---

## Learning Objectives

By completing this repository, a learner will be able to:

- Write precise `SELECT` queries with appropriate filtering
- Perform aggregations and grouping operations
- Apply multi-table JOINs effectively (INNER, LEFT, RIGHT)
- Use the `HAVING` clause and conditional logic in SQL
- Apply Window Functions for advanced analytical tasks
- Solve business-oriented analytical problems using SQL

---

## Topics Covered

| # | Topic | File |
|---|-------|------|
| 01 | SELECT Statement | `01_select.sql` |
| 02 | Filtering with WHERE | `02_filtering_where.sql` |
| 03 | SUM & COUNT | `03_sum_count.sql` |
| 04 | Aggregate Functions + GROUP BY | `04_aggregate_groupby.sql` |
| 05 | GROUP BY | `05_groupby.sql` |
| 06 | ORDER BY | `06_orderby.sql` |
| 07 | HAVING Clause | `07_having.sql` |
| 08–10 | Practice Sets | `08_practice_01.sql` – `10_practice_03.sql` |
| 11 | IN Operator | `11_in_operator.sql` |
| 12 | INNER JOIN | `12_inner_join.sql` |
| 13 | LEFT & RIGHT JOIN | `13_left_right_join.sql` |
| 14–16 | Additional Practice | `14_practice_04.sql` – `16_practice_05.sql` |
| 17–18 | Window Functions | `17_window_functions_01.sql` – `18_window_functions_02.sql` |

---

## Repository Structure

```text
SQL/
├── 01_select.sql
├── 02_filtering_where.sql
├── 03_sum_count.sql
├── 04_aggregate_groupby.sql
├── 05_groupby.sql
├── 06_orderby.sql
├── 07_having.sql
├── 08_practice_01.sql
├── 09_practice_02.sql
├── 10_practice_03.sql
├── 11_in_operator.sql
├── 12_inner_join.sql
├── 13_left_right_join.sql
├── 14_practice_04.sql
├── 15_if_elseif_else.sql
├── 16_practice_05.sql
├── 17_window_functions_01.sql
└── 18_window_functions_02.sql
```

---

## How to Use

1. Clone the repository:
   ```bash
   git clone https://github.com/shivamkumar98017/SQL.git
   ```
2. Open the `.sql` files in any SQL client (MySQL Workbench, DBeaver, pgAdmin, etc.) or notebook environment.
3. Execute queries against a compatible database.
4. Dataset context: E-commerce style schema (`customers`, `products`, `orders`, `order_items`, etc.).

> **Note:** Some queries reference tables with the prefix `e1.` (e.g., `e1.customers`). Adjust the schema name according to your environment.

---

## Prerequisites

- Basic understanding of relational databases
- Familiarity with tables, rows, and columns

---

## Tech Stack

- SQL (MySQL / PostgreSQL / SQLite compatible)
- Focus on analytical and business-intelligence style queries

---

## Why This Repository Matters

SQL remains one of the most important skills for data and ML roles. This repository shows deliberate practice from basic queries all the way to **Window Functions** — a topic that many students skip but is highly valued in academia and industry.

A teacher can clearly see:
- Structured progression from SELECT to advanced analytics
- Multiple independent practice sets
- Exposure to JOINs and Window Functions

---

## Author

**Shivam Kumar**  
Aspiring AI/ML Engineer & Cybersecurity Enthusiast  
Motihari, Bihar  

[GitHub](https://github.com/shivamkumar98017) • [Email](mailto:shivamk34442@gmail.com)

---

*Part of a structured learning path: Core Python → SQL → NumPy → Pandas → Machine Learning*
