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
    doc.css(".student-card").each do |card|
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
      student = Hash.new
      doc = Nokogiri::HTML(open(profile_url))
      #twitter - doc.css(".social-icon-container a")[0].attribute("href").value
      links = doc.css(".social-icon-container a").map do |link|
        link.attribute("href").value
      end
      links.each do |link|
        if link.include?("twitter")
          student[:twitter] = link
        elsif link.include?("linkedin")
          student[:linkedin] = link
        elsif link.include?("github")
          student[:github] = link
        else
          student[:blog] = link
        end
      end
      student[:profile_quote] = doc.css(".profile-quote").text unless nil
      student[:bio] = doc.css(".description-holder p").text unless nil
      student
  end

end
