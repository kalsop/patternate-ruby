require 'spec_helper'

describe PatternHelper do

  it "should display a message if there are no search results" do
    @no_results = true
    expect(helper.message_box).to include PatternConstants.const_get(:NO_RESULTS_MESSAGE)
  end

end 