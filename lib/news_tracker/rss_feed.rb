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
      if (self.newsletter_url == "http://javascriptweekly.com/rss/221bj275")
        newsletter[:content] = self.parse_js_html_content(item.description)
      elsif (self.newsletter_url == 'https://nodeweekly.com/rss/')
        newsletter[:content] = self.parse_node_html_content(item.description)
      else
        newsletter[:content] = self.parse_html(item.description)
      end
      newsletter[:pubDate] = item.pubDate
      newsletter
    end
  end

  # return an array of srticle instances and save each article to NewsTracker::Article.all
  def create_article_instances_from_hashes
    newsletters = self.fetch_feed
    newsletters.each do |newsletter|
      newsletter[:content].each do |article_hash|
        article = NewsTracker::Article.new
        article.title = article_hash[:title]
        article.author = article_hash[:author]
        article.description = article_hash[:description]
        article.url = article_hash[:url]
        article.save
      end
    end
  end

  # returns an array of article hashes (works with ruby newsletter)
  def parse_html(content)
    doc = Nokogiri::HTML(content)
    articles = []
    doc.search("td[align='left'] table.gowide")[2..-1].each do |article_table|
      a = {}
      a[:author] = article_table.search('div:first').text.strip
      a[:title] = article_table.search('a:first').text.strip
      a[:url] = article_table.search('a:first').attr('href').text.strip
      a[:description]= article_table.search('div:last').text.strip
      articles << a
    end
    articles
  end

  # parse html content for js newsletter
  def parse_js_html_content(content)
    doc = Nokogiri::HTML(content)
    result = []
    doc.search("td[align='left'] div").each do |div|
      result << div
    end
    articles = []
    result.each_slice(3).to_a.each do |array|
      article = {}
      array.each.with_index(1) do |div, i|
        if i == 1
          article[:title] = div.text.strip
          article[:url] = div.search('a').attr('href').text.strip
        elsif i == 2
          article[:description] = div.text.strip
        else
          article[:author] = div.text.strip
        end
      end
      articles << article
    end
    articles
  end

  def parse_node_html_content(content)
      doc = Nokogiri::HTML(content)
      elements = []
      doc.css("td[align='left'] div").each do |div|
        elements << div
      end
      articles = []
      elements.each_slice(3).to_a.each do |array|
        article = {}
        array.each.with_index(1) do |div, i|
          if i == 1
            article[:author] = div.text.strip
          elsif i == 2
            article[:url] = div.css('a').attr('href').text.strip
            article[:title] = div.css('a').text.strip
          else
            article[:description] = div.text.strip
          end
        end
        articles << article
      end
      articles
  end

end
