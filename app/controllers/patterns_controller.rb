class PatternsController < ApplicationController
  
include PatternSearchHelper
include AnalyticsHelper

  def index
  
    cookies.permanent[:date_of_first_visit] = assign_date_of_first_visit(cookies.permanent[:date_of_first_visit])
    
    @existing_search_terms = get_search_terms cookies[:search]
    @has_results = true
    @patterns = Pattern.my_search(@existing_search_terms)
    if @patterns.empty?
      @has_results = false
    end
    @styles = Style.all.map { |style| style.name }
  end

  
  def create
    if (not cookies[:search].nil?) 
      cookies_squeezed = cookies[:search].tr_s(',', '&').gsub(/\W$/, "")
      puts cookies_squeezed
    end    
    cookies[:search] = update_search_terms(params[:search],get_search_terms(cookies_squeezed),params[:remove])
    redirect_to patterns_path
  end
  
end
