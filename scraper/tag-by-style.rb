#!/usr/bin/env ruby

require 'rubygems'
require 'selenium-webdriver'
require 'pg'


@con = PG::Connection.new( '127.0.0.1', 5432, nil, nil, 'patternate-dev', 'patternate_rails', 'password1', nil, nil )
# @con = PG::Connection.new( 'ec2-54-247-175-11.eu-west-1.compute.amazonaws.com', 5432, nil, nil, 'da8vqtfkldatko', 'tqvemwyrhufsri', 'bxD2sR40u7g0cZM6prRpRz0HHA', nil, nil )
# @con = psql.new('127.0.0.1', 'patternate_rails', 'password1', 'patternate-dev', 5432)

# HERE BE METHODS



# this is it!!

styles_id = 9
matched_words = 'drape'

matching_patterns_query = "select id from patterns where description like '%#{matched_words}%'"
matching_patterns = @con.exec(matching_patterns_query)

if matching_patterns.entries.size == 0
  puts "nothing returned"
end

matching_patterns.each do |row|
  patterns_id = "#{row['id']}"

  patterns_styles = {:patterns_id => patterns_id, :styles_id => styles_id}
  
  # could check to see if this combination exists already...
  query = "INSERT INTO patterns_styles(pattern_id, style_id) VALUES(#{patterns_id},#{styles_id})"
  puts query
  @con.exec(query)
  
end

File.open('/Users/kalsop/Documents/Personal/Dev/patternate/patternate-ruby/scraper/results', 'a+') do | file |
  matching_patterns.each do | value | 
    file.write("#{value} || ")
  end
  file.write "\n\n" 
end














