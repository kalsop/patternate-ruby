#!/usr/bin/env ruby

require 'rubygems'
require 'selenium-webdriver'
require 'pg'


@con = PG::Connection.new( '127.0.0.1', 5432, nil, nil, 'patternate-dev', 'patternate_rails', 'password1', nil, nil )
# @con = PG::Connection.new( 'ec2-54-247-175-11.eu-west-1.compute.amazonaws.com', 5432, nil, nil, 'da8vqtfkldatko', 'tqvemwyrhufsri', 'bxD2sR40u7g0cZM6prRpRz0HHA', nil, nil )
# @con = psql.new('127.0.0.1', 'patternate_rails', 'password1', 'patternate-dev', 5432)

# HERE BE METHODS



# this is it!!

styles_id = 25
matched_words = 'pleated skirt'

# needs to be able to check for every case - e.g. sentence case as well
matching_patterns_query = "select id from patterns where description like '%#{matched_words}%'"
matching_patterns = @con.exec(matching_patterns_query)

matching_patterns.each do |row|
  patterns_id = "#{row['id']}"

  patterns_styles = {:patterns_id => patterns_id, :styles_id => styles_id}
  
  check_existing = "SELECT * FROM patterns_styles WHERE pattern_id = #{patterns_id} and style_id = #{styles_id}"
  results = @con.exec(check_existing)
  
  if results.count == 0
    query = "INSERT INTO patterns_styles(pattern_id, style_id) VALUES(#{patterns_id},#{styles_id})"
    puts query
    @con.exec(query)
  end
  
end




# As each pattern is added to the database
# tag it with
# pattern company.name
# pattern collection.name
# styles
#
# put it in 'review' status
# review it, and publish it








