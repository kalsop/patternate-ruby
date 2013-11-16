class PatternsController < ApplicationController
  
  def index
    @patterns = Pattern.all
  end
  
end
