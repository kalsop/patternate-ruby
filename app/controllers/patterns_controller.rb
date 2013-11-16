class PatternsController < ApplicationController
  
  def index
    if not params[:search].nil?
      @patterns = Pattern.where(['description LIKE ?', "%#{params[:search]}%"])
      if @patterns.empty?
        @no_results = true
        @patterns = Pattern.all
      end
    else
      @patterns = Pattern.all
    end
  end
  
end
