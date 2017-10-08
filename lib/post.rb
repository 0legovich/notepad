require 'sqlite3'

class Post

  @@SQLITE_DB_FILE = 'notepad.sqlite3'

  def self.post_types
    {'Memo' => Memo, 'Link' => Link, 'Task' => Task}
  end

  def self.create(type)
    post_types[type].new
  end

  def initialize
    @created_at = Time.now
    @text = nil
  end

  def self.find_by_id(type, id)
    db = SQLite3::Database.open(@@SQLITE_DB_FILE)

    #  1. Конкретная запись
    db.results_as_hash = true
    result = db.execute("SELECT * FROM posts WHERE rowid = ? AND type = ?", [id, type])

    result = result[0] if result.is_a? Array

    db.close

    if result.nil?
      puts "Такая запись не найдена"
      return nil
    else
      post = create(result['type'])
      post.load_data(result)
      return post
    end
  end

  def self.find_all(limit, type)
    db = SQLite3::Database.open(@@SQLITE_DB_FILE)

    #  2. Таблица записей
    db.results_as_hash = false
    query = "SELECT rowid, * FROM posts "
    query += "WHERE type = :type " unless type.nil?
    query += "ORDER by rowid DESC "
    query += "LIMIT :limit" unless limit.nil?
    begin
      statement = db.prepare(query)
    rescue SQLite3::SQLException => error
      puts "Не удалось выполнить запрос к базе #{@@SQLITE_DB_FILE}"
      raise error.inspect
    end

    statement.bind_param('type', type) unless type.nil?
    statement.bind_param('limit', limit) unless limit.nil?

    result = statement.execute!

    statement.close
    db.close

    return result
  end

  def save
    file = File.new(file_path, "w")
    to_strings.each do |string|
      file.puts(string)
    end
    file.close
  end

  def save_to_db
    db = SQLite3::Database.open(@@SQLITE_DB_FILE)
    db.results_as_hash = true
    begin
      db.execute(
        "INSERT INTO posts ("+
          to_db_hash.keys.join(",") +
          ")" +
          " VALUES (" +
          ('?,'*to_db_hash.keys.size).chomp(',') +
          ")",
        to_db_hash.values
      )
    rescue SQLite3::SQLException => error
      puts "Не удалось выполнить запрос к базе #{@@SQLITE_DB_FILE}"
      raise error.inspect
    end
    insert_row_id = db.last_insert_row_id

    db.close
    insert_row_id
  end

  def to_db_hash
    {
      'type' => self.class.name,
      'created_at' => @created_at.to_s
    }
  end

  def file_path
    current_path = File.dirname(__FILE__)
    file_name = @created_at.strftime("#{self.class.name}_%Y-%m-%d_%H-%M-%S.txt")
    current_path + "/" + file_name
  end

  def load_data(data_hash)
    @created_at = Time.parse(data_hash['created_at'])
  end

end
