require 'spec_helper'

describe Pattern do
    
  it "should display the company, collection and number when present" do
    pattern_company = PatternCompany.create(name: "Vogue")
    pattern_collection = PatternCollection.create(pattern_company: pattern_company, name: "Anne Klein")
    pattern = Pattern.create(pattern_company: pattern_company, pattern_collection: pattern_collection, pattern_number: '1234')
    expect(pattern.display_name).to eq "Vogue 1234 - Anne Klein"
  end
  
  it "should display the company and number when pattern is not part of a collection" do
    pattern_company = PatternCompany.create(name: "Vogue")
    pattern = Pattern.create(pattern_company: pattern_company, pattern_number: '1234')
    expect(pattern.display_name).to eq "Vogue 1234"
  end
  
end