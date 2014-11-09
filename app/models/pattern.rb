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
        find_patterns_matching_at_least_one_style_query = "
          SELECT p.* FROM patterns p
          INNER JOIN patterns_styles ps ON (ps.pattern_id = p.id) 
          INNER JOIN styles s ON (ps.style_id = s.id)
          WHERE (s.name = '#{style}')"
        
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
    
    }



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