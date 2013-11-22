class PatternsController < ApplicationController
  
  def index
    if not cookies[:search].nil?
      @patterns = Pattern.where(['description LIKE ?', "%#{cookies[:search]}%"])
      if @patterns.empty?
        @no_results = true
        @patterns = Pattern.all
      end
    else
      @patterns = Pattern.all
    end
  end
  
  def create
    redirect_to patterns_path
    cookies[:search] = params[:search]
  end
  
end
