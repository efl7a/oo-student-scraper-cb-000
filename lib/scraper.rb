require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
#  name =  doc.css(".student-card")[0].css(".student-name").text
# location =  doc.css(".student-card")[0].css(".student-location").text
# website = doc.css(".student-card")[0].css("a").attribute("href").value
    students = []
    index = 0
    doc.css(".student-card").map do |card|
      students[index] = {
        name: card.css(".student-name").text,
        location: card.css(".student-location").text,
        profile_url: card.css("a").attribute("href").value
      }
      index +=1
    end
    students
  end

  def self.scrape_profile_page(profile_url)

  end

end
