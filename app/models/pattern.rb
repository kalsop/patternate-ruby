class Pattern < ActiveRecord::Base
  belongs_to :pattern_company
  belongs_to :pattern_collection
  
  def display_name
    if self.pattern_collection.nil?
      self.pattern_company.name + ' ' + self.pattern_number
    else
      self.pattern_company.name + ' (' + self.pattern_collection.name + ') ' + self.pattern_number
    end
  end
  
end
