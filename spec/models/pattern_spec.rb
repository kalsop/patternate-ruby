require 'spec_helper'

describe Pattern do
  
  it "should display the company and number when present" do
    pattern_company = PatternCompany.create(name: "Vogue")
    pattern = Pattern.create(pattern_company: pattern_company, pattern_number: '1234')
    expect(pattern.display_name).to eq "Vogue 1234"
  end
  
end