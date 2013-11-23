require 'spec_helper'

describe PatternsController do
  
  it "should set the search cookie to the search term when no prior filters exist" do
    search_term = "dress"
    post :create, :search => search_term
    expect(response.cookies['search']).to eq(search_term)
  end
  
  it "should append the search term to the cookie when prior filters exist" do
    # given
    prior_filter = "dress"
    search_term = "pleat"
    request.cookies[:search] = prior_filter
    
    # when
    post :create, :search => search_term
    
    # then
    expect(response.cookies['search']).to eq(prior_filter + "&" + search_term)
  end
  
  it "should redirect to the pattern page" do
    post :create
    response_uri = URI.parse response.location
    expect(response_uri.path).to eq(patterns_path)
  end
  
  

end