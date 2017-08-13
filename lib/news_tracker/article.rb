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

  # works in ubuntu
  def open_in_browser
    system("gnome-open '#{self.url}'")
  end

end
