class Pattern < ActiveRecord::Base
  belongs_to :pattern_company
  belongs_to :pattern_collection
  
  scope :fuzzy_search, lambda { |terms|
    return self.all if terms.empty?
 
    composed_scope = self.scoped.joins(:pattern_company)
 
    terms.each do |term|
      term = '%' << term << '%'
      composed_scope = composed_scope.where(
      'description ILIKE :term 
      OR pattern_number ILIKE :term 
      OR pattern_name ILIKE :term 
      OR pattern_company.name ILIKE :term', {:term => term})
    end
 
    composed_scope
  }
  
  def display_name
    if self.pattern_company.name =='Burda'
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