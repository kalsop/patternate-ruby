class Pattern < ActiveRecord::Base
  belongs_to :pattern_company
  belongs_to :pattern_collection
  belongs_to :garment_type
  has_and_belongs_to_many :style
  
    scope :my_search, lambda { |terms|

    return self.order('id DESC') if terms.empty?

number_of_styles = terms.count
patterns_matching_at_least_one_style = []

terms.each do |style|
  
  find_patterns_matching_at_least_one_style_query = "SELECT patterns.* FROM patterns INNER JOIN patterns_styles ON (patterns_styles.pattern_id = patterns.id) WHERE (style_id = '#{style}')"
  find_patterns_matching_at_least_one_style = ActiveRecord::Base.connection.execute(find_patterns_matching_at_least_one_style_query)
  find_patterns_matching_at_least_one_style.each do |row|
    patterns_matching_at_least_one_style << "#{row['id']}"
  end
end

items = patterns_matching_at_least_one_style.each_with_object(Hash.new(0)) { |word,counts| counts[word] += 1 }

hash_of_patterns_matching_all_styles = items.select {|k,v| v==number_of_styles }.sort

patterns_matching_all_styles = []
hash_of_patterns_matching_all_styles.each do |match|
  patterns_matching_all_styles << match.first
end

self.find(patterns_matching_all_styles)
# all_the_patterns = []
# patterns_matching_all_styles.each do | pattern | 
#   single_pattern = self.where(patterns: {id: pattern})
#   # this creates an array
#   all_the_patterns << single_pattern
#   # then this is an array of arrays
# end
# 
# all_the_patterns.each do |kkk|
#   puts kkk
# end


}

# File.open('/Users/kalsop/Documents/Personal/Dev/patternate/patternate-ruby/scraper/results', 'a+') do | file |
#   patterns_matching_all_styles.each do | value | 
#     file.write("#{value} || ")
#   end
#   file.write "\n\n" 
# end

# 
#     number_of_terms = terms.count
#     composed_scope = self.scoped.joins(:style)
# 
#     terms.each do |term|
# 
# 
#       composed_scope = composed_scope.where(styles: {id: term})
# # this only work with one query. it tries to do 'where style_id = 3 and style_id = 2'
#     
# 
#     end
# 
#     composed_scope


  



# old functioning search
# 
# 
  # scope :fuzzy_search, lambda { |terms|
  #   return self.order('id DESC') if terms.empty?
  #  
  #   composed_scope = self.scoped.joins(:pattern_company).order('id DESC')
  #      
  #   terms.each do |term|
  #     term_in_description = '% ' << term << '%'
  #     term = '%' << term << '%'
  #     composed_scope = composed_scope.where(
  #     'description ILIKE :term_in_description 
  #     OR pattern_number ILIKE :term 
  #     OR pattern_name ILIKE :term 
  #     OR pattern_company.name ILIKE :term', {:term => term, :term_in_description => term_in_description})
  #   end
  #  
  #   composed_scope
  # }


  def display_name
    if self.pattern_company.name =='BurdaStyle'
      self.pattern_company.name + ' ' + self.pattern_name + ' - ' + self.pattern_collection.name
    elsif self.pattern_number.nil?
      self.pattern_company.name + ' ' + self.pattern_name
    elsif self.pattern_collection.nil?
      self.pattern_company.name + ' ' + self.pattern_number
    else
      self.pattern_company.name + ' ' + self.pattern_number + ' - ' + self.pattern_collection.name
    end
  end
  
end