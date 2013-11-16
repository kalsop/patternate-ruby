class PatternCollection < ActiveRecord::Base
  self.table_name = "pattern_collection"
  belongs_to :pattern_company
end
