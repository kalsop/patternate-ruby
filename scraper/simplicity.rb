#!/usr/bin/env ruby

require 'rubygems'
require 'selenium-webdriver'
require 'pg'

@browser = Selenium::WebDriver.for :chrome

# @con = PG::Connection.new( '127.0.0.1', 5432, nil, nil, 'patternate-dev', 'patternate_rails', 'password1', nil, nil )
@con = PG::Connection.new( 'ec2-54-247-175-11.eu-west-1.compute.amazonaws.com', 5432, nil, nil, 'da8vqtfkldatko', 'tqvemwyrhufsri', 'bxD2sR40u7g0cZM6prRpRz0HHA', nil, nil )
# @con = psql.new('127.0.0.1', 'patternate_rails', 'password1', 'patternate-dev', 5432)

# HERE BE METHODS

def pattern_number
  number = @browser.find_element(:css, '.product-info h1').text
  return number.split(" ").first
  #todo do something to get rid of extra spaces
end

def pattern_collection
  
  # if span.SectionTitleText a.SectionTitleText:second child = "Special Collections", get contents of span.SectionTitleText a.SectionTitleText:third child
  pattern_collection_id = "NULL"
  if @browser.find_element(:css, 'span.SectionTitleText a.SectionTitleText:nth-child(2)').text.include? 'Special Collections'
    pattern_collection_name = @browser.find_element(:css, 'span.SectionTitleText a.SectionTitleText:nth-child(3)').text
    rs = @con.exec("select id from pattern_collection where name = '#{pattern_collection_name}'")
    if rs.entries.size == 0
      @con.exec("INSERT INTO pattern_collection(name, pattern_company_id) VALUES('#{pattern_collection_name}', 3)")
      @con.exec("SELECT CURRVAL('pattern_collection_id_seq')").each do | row |
        pattern_collection_id = "'#{row['currval']}'"
        puts pattern_collection_id
      end
    else
      rs.each do | row |     
        pattern_collection_id = "'#{row['id']}'"
      end
    end
  end
  pattern_collection_id
end





def pattern_description
  description = @browser.find_element(:css, '.tabberlive p.main').text
  return description.gsub("\'", "\''")
end




def images 
  #images_list = ''
  #@browser.find_elements(:css, '.alt_image_replacement img').each do | image |
  # images_list << image.attribute('src') + ' '
  #end
  #images_list
  #
  @browser.find_element(:css, '#product-image a').attribute('href')
end

def line_art
  @browser.find_element(:css, '#front-back-info-content a#zoomle1').attribute('href')
end

def go_to_search_result_url(start)
  @browser.get "http://www.simplicity.com/c-148-tops-vests-jackets-coats.aspx?pagesize=99999999"
  # http://www.simplicity.com/c-149-skirts-pants.aspx?pagesize=99999999
  # http://www.simplicity.com/c-147-dresses.aspx?pagesize=99999999
end

def pattern_page_url
  @browser.current_url
end

# HERE BE EXECUTION


(1..10).each do |offset|

go_to_search_result_url offset*10

urls = []
@browser.find_elements(:css, '.item-number a').each do | result |
  urls << result.attribute('href')
end

urls.each do |url|  
  
  begin

  @browser.get url
#http://voguepatterns.mccall.com/v1350-products-46626.php?page_id=1112
#http://voguepatterns.mccall.com/v1174-products-11082.php?page_id=1107
#http://voguepatterns.mccall.com/v1358-products-47535.php?page_id=320
#http://voguepatterns.mccall.com/v1349-products-46625.php?page_id=313
#http://voguepatterns.mccall.com/v1362-products-47539.php?page_id=316
#http://mccallpattern.mccall.com/m6837-products-47784.php?page_id=96
#http://kwiksew.mccall.com/k4026-products-47754.php?page_id=3013
#http://voguepatterns.mccall.com/v8893-products-46634.php?page_id=4444
#http://voguepatterns.mccall.com/v8916-products-46657.php
#http://voguepatterns.mccall.com/v1357-products-46633.php?page_id=862
#http://voguepatterns.mccall.com/v8932-products-47559.php?page_id=174
#http://voguepatterns.mccall.com/v8902-products-46643.php?page_id=4515
#http://voguepatterns.mccall.com/v1084-products-9745.php?page_id=850
#http://voguepatterns.mccall.com/v1304-products-22878.php?page_id=3506
#http://voguepatterns.mccall.com/v1132-products-10466.php?page_id=863
#http://voguepatterns.mccall.com/v1325-products-27098.php?page_id=862
#http://voguepatterns.mccall.com/v8940-products-47567.php?page_id=174
#http://mccallpattern.mccall.com/m6846-products-47793.php?page_id=96
#http://butterick.mccall.com/b5953-products-47646.php?page_id=147
#http://shops.mccall.com/f2704-products-47666.php?page_id=3453
#http://voguepatterns.mccall.com/v1165-products-10765.php?page_id=852

patterns = {:pattern_number => pattern_number, :pattern_collection => pattern_collection, :pattern_description => pattern_description, :images => images, :line_art => line_art, :url => pattern_page_url}


query = "INSERT INTO patterns(pattern_company_id, pattern_number, pattern_collection_id, main_image, line_drawing, description, url) VALUES('3','#{patterns[:pattern_number]}',#{patterns[:pattern_collection]},'#{patterns[:images]}','#{patterns[:line_art]}','#{patterns[:pattern_description]}', '#{patterns[:url]}')"
puts query

query_two = "SELECT CURRVAL('patterns_id_seq')"

rs_already_exists = @con.exec("select pattern_number from patterns where pattern_number = '#{patterns[:pattern_number]}'")
if rs_already_exists.entries.size == 0
  @con.exec(query)
  rs_last_insert_id = @con.exec(query_two)

  last_insert_id = ''
  rs_last_insert_id.each do |row|
    last_insert_id = row['currval']
  end


end
 
  
# File.open('/Users/kalsop/Documents/Personal/Dev/patternate-scratch/patternate/webdriver/results', 'a+') do | file |
#   patterns.each_value do | value | 
#     file.write("#{value} || ")
#   end
#   file.write "\n\n" 
# end
  
rescue Exception => e
  puts "!! ERROR SCRAPING PAGE :"
  puts "URL:"
  puts url
  puts "TITLE"
  puts @browser.title
  puts "MESSAGE:"
  puts e.message
  puts e.backtrace
end
  
end

end




at_exit do
  @con.close
  @browser.quit
end
