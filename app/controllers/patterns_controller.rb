class PatternsController < ApplicationController
  
include PatternSearchHelper
include AnalyticsHelper
  
  def index
    cookies.permanent[:date_of_first_visit] = assign_date_of_first_visit(cookies.permanent[:date_of_first_visit])
    
    @existing_search_terms = get_search_terms cookies[:search]
    @has_results = true
    @patterns = Pattern.fuzzy_search(@existing_search_terms).all
    if @patterns.empty?
      @has_results = false
    end
  end
  
  def create    
    cookies[:search] = update_search_terms(params[:search],get_search_terms(cookies[:search]),params[:remove])
    redirect_to patterns_path
  end
  
end
