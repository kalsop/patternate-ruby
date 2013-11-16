class Pattern < ActiveRecord::Base
  belongs_to :pattern_company
  belongs_to :pattern_collection
  
  def display_name
    self.pattern_company.name + ' ' + self.pattern_number
  end
end
