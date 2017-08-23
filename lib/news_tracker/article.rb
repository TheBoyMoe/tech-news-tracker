class NewsTracker::Article
  attr_accessor :title, :author, :description, :url
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

end
