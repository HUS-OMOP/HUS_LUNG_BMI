import pyodbc
import pandas as pd
import getpass

# === 1. Database connection parameters (no password here) ===
server = "your_server_name"
database = "your_database_name"
username = "your_username"
schema_name = "cdm_schema"  # <-- set your schema here

# Prompt for password securely
password = getpass.getpass("Enter database password: ")

# Build connection string (SQL Server example)
conn_str = (
    "DRIVER={ODBC Driver 18 for SQL Server};"
    f"SERVER={server};"
    f"DATABASE={database};"
    f"UID={username};"
    f"PWD={password};"
    f"Authentication=ActiveDirectoryPassword;" #Remove in not Microsoft Authentication
)

# === 2. Connect via ODBC ===
conn = pyodbc.connect(conn_str)

print(f"Connection successful",flush=True)

# === 3. Read SQL from external file ===
with open("script.sql", "r", encoding="utf-8") as f:
    query_template  = f.read()

query = query_template.format(schema=schema_name)

print(f"Executing",flush=True)
# === 4. Execute query and load results into pandas DataFrame ===
df = pd.read_sql(query, conn)

print(f"Writing results",flush=True)
# === 5. Save to CSV ===
output_file = "results/concept_usage_summary.csv"
df.to_csv(output_file, index=False)

# === 6. Close connection ===
conn.close()

print(f"✅ Query executed successfully. Results saved to {output_file}")
