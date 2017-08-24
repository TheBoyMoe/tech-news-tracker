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

  def self.find_or_insert(title:, author:, description:, url:)
    sql = <<-SQL
      SELECT * FROM articles
      WHERE title = ? AND author = ?
    SQL
    array = DB[:conn].execute(sql, title, author)
    if array.empty?
      article = NewsTracker::Article.new
      article.title = title
      article.author = author
      article.description = description
      article.url = url
      article.insert
    else
      row = array.first
      self.new_from_db(row)
    end
  end

  def self.new_from_db(row)
    article = NewsTracker::Article.new
    article.id = row[0]
    article.title = row[1]
    article.author = row[2]
    article.description = row[3]
    article.url = row[4]
    article
  end

end
