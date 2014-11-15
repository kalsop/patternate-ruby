#!/usr/bin/env ruby

require 'rubygems'
require 'selenium-webdriver'
require 'pg'

@browser = Selenium::WebDriver.for :chrome

@con = PG::Connection.new( '127.0.0.1', 5432, nil, nil, 'patternate-dev', 'patternate_rails', 'password1', nil, nil )
# @con = PG::Connection.new( 'ec2-54-247-175-11.eu-west-1.compute.amazonaws.com', 5432, nil, nil, 'da8vqtfkldatko', 'tqvemwyrhufsri', 'bxD2sR40u7g0cZM6prRpRz0HHA', nil, nil )
# @con = psql.new('127.0.0.1', 'patternate_rails', 'password1', 'patternate-dev', 5432)

# HERE BE METHODS

def pattern_number
  number = @browser.find_element(:css, '#product_name h1').text
  return number.gsub("V", "")
  #todo do something to get rid of extra spaces
end

def pattern_collection
  pattern_collection_id = "NULL"
  if !@browser.find_elements(:id, 'brand_image').empty?
    pattern_collection_name = @browser.find_element(:id, 'brand_image').find_element(:tag_name, 'img').attribute('title')
    rs = @con.exec("select id from pattern_collection where name = '#{pattern_collection_name}'")
    if rs.entries.size == 0
      @con.exec("INSERT INTO pattern_collection(name, pattern_company_id) VALUES('#{pattern_collection_name}', 1)")
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

def garment_type
  garment_type_string = @browser.find_element(:id, 'product_name_new').text
  matched_words = []
  ["jacket", "dress", "top", "shorts", "pants", "petite", "blouse", "shirt", "tunic", "coat", "cape", "jumpsuit", "skirt", "vest", "robe", "gown", "corset", "maternity", "jeans", "fitting shell"].each do |fancy_word|
    case_insensitive_garment_type = garment_type_string.downcase
    if case_insensitive_garment_type.include? fancy_word
      rs = @con.exec("select id from garment_type where lower(name) = '#{fancy_word}'")
      rs.each do |row|
        row.each do | row_value |
          matched_words << row_value
        end
      end
    end
  end
  matched_words
end

def pattern_for
  pattern_for_string = @browser.find_element(:id, 'product_name_new').text.downcase
  {"men" => 1,"misses" => 2}.each_pair do |gender, id |
    return id if pattern_for_string.include? gender
  end
end



def pattern_description
  description = proc { @browser.find_element(:css, '#product_vertical_bottom #included_content table tbody tr:nth-of-type(1) td') }
  fluent_wait_until_element_visible description
  first, *rest = description.call.text.split(/: /)
  rest.join("\s")
end

def pattern_fabric
  @browser.find_elements(:css, '#included_content table td').each do | description_cell |
    if description_cell.text.include? 'FABRICS' 
      return description_cell.text.gsub("FABRICS: ", "")
    end
  end
end

def sizes 
  if @browser.find_element(:css, '.options option').text == "All Sizes in One Envelope "
    sizes_list = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J"]
  else
    sizes_list = []
    @browser.find_element(:css, '.options').find_elements(:tag_name, 'option').each do | option |
      sizes_list.concat option.text.split('(').last.tr(')A-Za-z ','').split('-')
    end
    sizes_list.uniq
  end
end

def images 
  #images_list = ''
  #@browser.find_elements(:css, '.alt_image_replacement img').each do | image |
  # images_list << image.attribute('src') + ' '
  #end
  #images_list
  #
  @browser.find_element(:css, '#image_original img').attribute('src')
end

def line_art
  @browser.find_element(:css, '#included_content img:first-child').attribute('src')
end

def go_to_search_result_url(start)
  #@browser.get "https://www.google.co.uk/search?q=site:voguepatterns.mccall.com+misses&start=#{start}"
  @browser.get "http://voguepatterns.mccall.com/new-sewing-patterns-pages-174.php?list=0"

end

def pattern_page_url
  @browser.current_url
end

def fluent_wait_until_element_visible(block)
  wait = Selenium::WebDriver::Wait.new(:timeout => 10)
  wait.until { block.call.displayed? }
end

# HERE BE EXECUTION


(2..10).each do |offset|

go_to_search_result_url offset*10

urls = []
#@browser.find_elements(:css, 'h3.r a').each do | result |
@browser.find_elements(:css, '.productIndImage td a').each do | result |
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

patterns = {:pattern_number => pattern_number, :pattern_collection => pattern_collection, :pattern_description => pattern_description, :pattern_for => pattern_for, :pattern_fabric => pattern_fabric, :garment_type => garment_type, :sizes => sizes, :images => images, :line_art => line_art, :url => pattern_page_url}


query = "INSERT INTO patterns(pattern_company_id, 
                              pattern_number,
                              pattern_collection_id,
                              main_image,
                              line_drawing,
                              description,
                              url) VALUES('1','#{patterns[:pattern_number]}',#{patterns[:pattern_collection]},'#{patterns[:images]}','#{patterns[:line_art]}','#{patterns[:pattern_description]}', '#{patterns[:url]}')"
puts query

query_two = "SELECT CURRVAL('patterns_id_seq')"
puts query_two


rs_already_exists = @con.exec("select pattern_number from patterns where pattern_number = '#{patterns[:pattern_number]}'")
if rs_already_exists.entries.size == 0
  @con.exec(query)
  rs_last_insert_id = @con.exec(query_two)

  last_insert_id = ''
  rs_last_insert_id.each do |row|
    last_insert_id = row['currval']
  end

end
 

    
File.open('/Users/kalsop/Documents/Personal/Dev/patternate-scratch/patternate/webdriver/results', 'a+') do | file |
  patterns.each_value do | value | 
    file.write("#{value} || ")
  end
  file.write "\n\n" 
end
  
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
