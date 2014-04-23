class Pattern < ActiveRecord::Base
  belongs_to :pattern_company
  belongs_to :pattern_collection
  
  def display_name
    if self.pattern_company.name =='Burda'
      # self.pattern_company.name + ' ' + self.pattern_number + ' ' + self.pattern_name + ' - ' + self.pattern_collection.name
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


# def display_name
#   self.pattern_company_name + lookup_display_name(self)
# end
# 
# def lookup_display_name pattern_company_name
#     display_names["vogue"] 
# end
# 
# 
# ["vogue" => pattern pattern_number + (pattern_collection or nothing) + 