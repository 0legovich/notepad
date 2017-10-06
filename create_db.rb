require "sqlite3"

# Open a database
db = SQLite3::Database.new "notepad.sqlite3"

rows = db.execute <<-SQL
  CREATE TABLE posts(
    type varchar,
    created_at numeric,
    text varchar,
    url varchar,
    due_date numeric
  );
SQL
