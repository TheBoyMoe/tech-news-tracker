class NewsTracker::RssFeed
  attr_reader :newsletter_url

  def initialize(url)
    @newsletter_url = url
  end

  # returns an array of newsletter hashes
  def fetch_feed
    rss = RSS::Parser.parse(open(self.newsletter_url), false)
    rss.items.map do |item|
      newsletter = {}
      newsletter[:title] = item.title
      newsletter[:link] = item.link
      newsletter[:content] = self.parse_html(item.description)
      newsletter[:pubDate] = item.pubDate
      newsletter
    end
  end

  # returns an array of article hashes
  def parse_html(content)
    doc = Nokogiri::HTML(content)
    result = []
    doc.search("td[align='left'] table.gowide")[2..-1].each do |article_table|
      a = {}
      a[:author] = article_table.search('div:first').text.strip
      a[:title] = article_table.search('a:first').text.strip
      a[:url] = article_table.search('a:first').attr('href').text.strip
      a[:description]= article_table.search('div:last').text.strip
      result << a
    end
    result
  end

  # return an array of srticle instances and save each article to NewsTracker::Article.all
  def create_article_instances_from_hashes
    newsletters = self.fetch_feed
    newsletters.map do |newsletter|
      newsletter[:content].map do |article_hash|
        article = NewsTracker::Article.new
        article.title = article_hash[:title]
        article.author = article_hash[:author]
        article.description = article_hash[:description]
        article.url = article_hash[:url]
        article.save
      end
    end.flatten
  end

end
