class PatternsController < ApplicationController
  
include PatternSearchHelper
include AnalyticsHelper

  def index
    
    
    cookies.permanent[:date_of_first_visit] = assign_date_of_first_visit(cookies.permanent[:date_of_first_visit])
    
    # the following if statement removes the space and comma in the search cookie inserted by the jquery ui autocomplete widget
    if (not cookies[:search].nil?) 
      cookies_trimmed = cookies[:search]
      if (not params[:remove].nil?)
        cookies_trimmed = cookies[:search].chop.chop
      end
      cookies_squeezed = cookies_trimmed.tr(", ","&").squeeze("&")
    end
    
    @existing_search_terms = get_search_terms cookies_squeezed
    @has_results = true
    @patterns = Pattern.my_search(@existing_search_terms)
    if @patterns.empty?
      @has_results = false
    end
  end

  
  def create
    if (not cookies[:search].nil?) 
      cookies_trimmed = cookies[:search].tr(", ","&")
      cookies_squeezed = cookies_trimmed.squeeze("&")
    end    
    cookies[:search] = update_search_terms(params[:search],get_search_terms(cookies_squeezed),params[:remove])
    redirect_to patterns_path
  end
  
end
