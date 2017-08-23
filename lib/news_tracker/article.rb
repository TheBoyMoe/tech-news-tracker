class NewsTracker::Article
  attr_accessor :id, :title, :author, :description, :url
  @@all = []

  def save
    self.class.all << self
  end

  def self.all
    @@all
  end

  def self.clear_all
    self.all.clear
  end

  def open_in_browser
    # works in ubuntu
    system("gnome-open '#{self.url}'")
    # on mac
    # system("open '#{self.url}'")
  end

  def self.create_table
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS articles (
        id INTEGER PRIMARY KEY,
        title TEXT,
        author TEXT,
        description TEXT,
        url TEXT
      )
    SQL
    DB[:conn].execute(sql)
  end

  def self.drop_table
    DB[:conn].execute("DROP TABLE IF EXISTS articles")
  end

  def insert
    sql = <<-SQL
      INSERT INTO articles (title, author, description, url)
      VALUES (?, ?, ?, ?)
    SQL
    DB[:conn].execute(sql, self.title, self.author, self.description, self.url)
    self.id = DB[:conn].execute("SELECT last_insert_rowid() FROM articles")[0][0]
    self
  end

end
