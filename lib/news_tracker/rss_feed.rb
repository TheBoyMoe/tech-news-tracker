class NewsTracker::RssFeed

  # initialize with url


  def fetch_feed
    rss = RSS::Parser.parse(open('http://rubyweekly.com/rss/16581bfg'), false)
    rss.items.map do |item|
      newsletter = {}
      newsletter[:title] = item.title
      newsletter[:link] = item.link
      newsletter[:content] = parse_html(item.description)
      newsletter[:pubDate] = item.pubDate
      newsletter
    end
  end

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

end
