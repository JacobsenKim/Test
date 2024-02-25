#!/bin/bash
#
# chmod +x sql_import_remote.sh
#
# This script will prompt you to enter the MySQL password and then proceed to import all SQL files in the specified directory into the homeassistant database on the MySQL server running at 192.168.0.76.
# Make sure to adjust the MYSQL_USER, MYSQL_HOST, MYSQL_DB, and SQL_DIR variables to match your environment. Additionally, ensure that the MySQL user (homeassistant) has the necessary privileges to access and modify the homeassistant database.
#
# Run the script like this:
#
# ./sql_import_remote.sh your_db_password
#
# Check if the password is provided as an argument
#!/bin/bash

# Check if the password is provided as an argument
if [ -z "$1" ]; then
    echo "Usage: $0 <mysql_password>"
    exit 1
fi

# MySQL connection parameters
MYSQL_USER="homeassistant"
MYSQL_HOST="192.168.24.24"
MYSQL_DB="homeassistant"
MYSQL_PASSWORD="$1"

# Directory containing SQL files
SQL_DIR="/home/user_name/ha2mariadb/output"

# Log file
LOG_FILE="/home/user_name/ha2mariadb/output/import_log.txt"

# Connect to MySQL and import SQL files
for file in "$SQL_DIR"/*.sql; do
    # Skip non-SQL files
    [ -f "$file" ] || continue

    # Import SQL file
    echo "Importing $file..."
    mysql -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" -h "$MYSQL_HOST" "$MYSQL_DB" < "$file" >> "$LOG_FILE" 2>&1
done

echo "All SQL files imported successfully. See $LOG_FILE for details."


