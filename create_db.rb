require "sqlite3"

# Open a database
db = SQLite3::Database.new "notepad.sqlite3"

# Create a table
# rows = db.execute <<-SQL
#   create table numbers (
#     name varchar(30),
#     val int
#   );
# SQL
