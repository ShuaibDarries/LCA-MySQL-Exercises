# EduTrack SA — Exercise 02: Querying, Sorting, and Filtering Data

## Overview
This exercise builds on the EduTrack SA database from Exercise 01. It contains a series of `SELECT` queries that demonstrate sorting, filtering, wildcards, aggregate functions, and grouping in MySQL.

## Database
- **Database Name:** `edutrack_sa`
- **Port:** `3307`
- **Tool:** MySQL Workbench

> Run `USE edutrack_sa;` before executing any query.

## Queries Covered

| # | Task | SQL Concepts Used |
|---|------|-------------------|
| 1 | List all trainees sorted by surname (A-Z) | `ORDER BY ... ASC` |
| 2 | List all courses sorted by duration (longest first) | `ORDER BY ... DESC` |
| 3 | Retrieve the 3 most recently enrolled records | `ORDER BY` + `LIMIT` |
| 4 | List trainees filtered by province | `WHERE` |
| 5 | Find trainees whose first name starts with a specific letter | `LIKE 'J%'` |
| 6 | Filter courses by duration | `WHERE` + comparison operators |
| 7 | Filter enrolments by status | `WHERE` |
| 8 | Total trainee count | `COUNT(*)` |
| 9 | Average course duration | `AVG()` |
| 10 | Maximum course duration | `MAX()` |
| 11 | Enrolment count per course | `GROUP BY` + `COUNT()` |
| 12 | Trainee count per province | `GROUP BY` |
| 13 | Provinces with more than one trainee | `GROUP BY` + `HAVING` |
| 14 | Active enrolments sorted by most recent | `WHERE` + `ORDER BY` |
| 15 | Trainees from specific provinces | `OR` operator |
| 16 | Courses with duration not equal to 5 | `!=` operator |
| 17 | 2nd and 3rd most recent enrolments | `LIMIT` + `OFFSET` |
| 18 | Trainees with emails ending in `.co.za` | `LIKE '%.co.za'` |
| 19 | Facilitators who facilitate more than one course | `JOIN` + `GROUP BY` + `HAVING` |


## File Structure

```
LCA-MySQL-Exercises/
└── week1-mysql-ex-02/
    ├── week1_mysql_exo2_ShuaibDarries.sql
    └── README.md
```

## Author
- Name: Shuaib Darries
- Date: 2026-07-21
- Course: LCA MySQL Module — Week 1
