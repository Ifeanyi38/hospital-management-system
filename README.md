<<<<<<< HEAD
# Hospital Management System — SQL Database Project

## Overview
This project is a relational database for managing the day to day operations 
of a hospital. It covers everything from departments and staff to patient 
appointments, treatments, lab tests and payments. The goal was to design 
a clean, normalised database that reflects how a real hospital system 
would store and manage its data.

Built and tested using XAMPP and phpMyAdmin on a local machine.

## Tech Stack
- MySQL
- XAMPP (phpMyAdmin)
- SQL

## Database Structure
The database has 12 tables covering departments, rooms, doctors, nurses, 
patients, medical records, appointments, admissions, treatments, 
prescriptions, lab tests and payments.


A full ERD diagram is available in the docs folder.

![ERD](docs/erd.png)

## How to Run

Make sure XAMPP is installed and both Apache and MySQL are running 
in the XAMPP Control Panel before you start.

1. Open your browser and go to `http://localhost/phpmyadmin`
2. Create a new database and name it `hospital_management`
3. Open the SQL tab, paste the contents of `database/schema.sql` and click Go
4. Once the tables are created, paste the contents of `database/sample_data.sql` and click Go
5. To run the analytical queries open `database/queries.sql`, copy any query and run it in the SQL tab

## Project Structure


hospital-management-system/
├── database/
│   ├── schema.sql
│   ├── sample_data.sql
│   └── queries.sql
├── docs/
│   └── erd.png
├── README.md
└── .gitignore


## Design Notes
Tables were created first without any constraints, then primary keys, 
foreign keys and unique constraints were added separately using ALTER TABLE. 
This was a deliberate choice to show a clear understanding of how constraints 
work independently of table creation.

A unique constraint on the medical record table ensures each patient has 
only one record. A unique constraint on the admission table ensures one 
appointment can only produce one admission.

## Status
Complete — built and tested locally using XAMPP
=======
# README

## Summary

Brief instructions to run app with Node.js and to initialize a local MySQL database using XAMPP

## Prerequisites

- Node.js (v14+ recommended)
- npm (comes with Node.js)
- XAMPP (includes Apache + MySQL / MariaDB)
- The SQL dump file (`sql_dump.sql`) included in this repository

## Setup (project)

1. Open a terminal in the project root (where `index.js` lives):

```
cd node_template
```

2. Install dependencies:

```
npm install
```

## Configure database connection

COnfigure environmental variables in `.env` file. If not then rename `env_sample.txt` to `.env`. Backup contents if needed

```
DB_HOST=
DB_PORT=
DB_USER=
DB_PASS=
DB_NAME=
```

Adjust keys to match your the project's configuration name (attendance_system).

## Initialize XAMPP and MySQL

1. Start XAMPP Control Panel.
2. Start **Apache** and **MySQL** services.
3. Open phpMyAdmin: http://localhost/phpmyadmin
4. Paste SQL dump into sql tab of phpMyAdmin

## Run the application

Start the Node.js process:

```
node index.js
```

## For PowerShell

Allows to run Scripts

`Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned -Force`
>>>>>>> 5d37f7263400fbb21e83f6a5d519d2e7c58806d2
