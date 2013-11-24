require 'spec_helper'

describe PatternHelper do

  it "should display correct message if there are search terms but no results" do
    @has_results = false
    @search_terms = ["dress"]
    expect(helper.result_summary).to include PatternConstants.const_get(:NO_RESULTS_MESSAGE)
  end
  
  it "should display correct message if there are search terms and results" do
    @has_results = true
    @search_terms = ["dress"]
    expect(helper.result_summary).to include PatternConstants.const_get(:RESULTS_MESSAGE)
  end
  
  it "should display correct message if there are no search terms" do
    @search_terms = []
    expect(helper.result_summary).to include PatternConstants.const_get(:NO_SEARCH_TERMS_MESSAGE)
  end

end 