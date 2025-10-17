# 🧠 OMOP Concept Usage Summary

This python package runs a SQL script against an OMOP Common Data Model (CDM) database to summarize **concept usage frequency** across major clinical tables (conditions, drugs, procedures, measurements, observations).

The results are generated in a CSV file, which does not contain any patient information.

---

## What to do?

1. Check below for dependencies
2. Open `run.py` and add your DB parameters
3. Navigate into the folder on your terminal
4. Run the code - see Running the Code
5. Zip the content of results folder and email the zip-file to alexey.ryzhenkov@helsinki.fi 

## 🚀 Running the Code

### 🧪 **Pip Users**

```bash
pip install -r requirements.txt
python run.py
```

---

### 🧬 **Conda Users**

```bash
conda create -n hus_bmi_package python=3.10
conda activate hus_bmi_package
conda install -c conda-forge pandas pyodbc
python run.py
```

---

## ⚙️ Dependencies

Before running the Python scripts, make sure you have:

* Python **3.8+**
* An available **ODBC connection** to your database
* If your OMOP instance is running on Microsoft SQL Server and you do not have the ODBC driver installed please see "Installing ODBC Driver 18 for SQL Server" below

---

## 🧩 Installing ODBC Driver 18 for SQL Server

### 🪟 **Windows**

```bash
winget install Microsoft.ODBCDriverForSQLServer.18
```

Or download manually from Microsoft:
👉 [ODBC Driver 18 for SQL Server](https://learn.microsoft.com/sql/connect/odbc/download-odbc-driver-for-sql-server)

---

### 🍎 **macOS**

```bash
brew tap microsoft/mssql-release https://github.com/Microsoft/homebrew-mssql-release
brew update
brew install msodbcsql18
```

> You may need to accept Microsoft’s license during installation.

---

### 🐧 **Linux (Ubuntu / Debian)**

```bash
sudo su
curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
curl https://packages.microsoft.com/config/ubuntu/22.04/prod.list > /etc/apt/sources.list.d/mssql-release.list
exit
sudo apt-get update
sudo ACCEPT_EULA=Y apt-get install -y msodbcsql18 unixodbc-dev
```

For other distros (RHEL, CentOS, etc.), see:
👉 [Microsoft Docs: Install the ODBC Driver on Linux & macOS](https://learn.microsoft.com/sql/connect/odbc/linux-mac/)

---





## 🧾 Output

After successful execution, the script will generate an output file:

```
concept_usage_summary.csv
```

Containing columns:
| table_name | concept_id | concept_name | vocabulary_id | row_count |

Each row shows how many times a given concept was used in a specific OMOP table.

---
