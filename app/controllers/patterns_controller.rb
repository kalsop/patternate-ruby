class PatternsController < ApplicationController
  
  def index
    @patterns = Pattern.all
    if not cookies[:search].nil?
      all_terms = cookies[:search].split("&")
      sql_query = []
      sql_query_terms = []
      all_terms.each do | term |
        sql_query << "description LIKE ?"
        sql_query_terms << "%#{term}%"
      end
      sql_query = sql_query.join(" AND ")
      @patterns = Pattern.where(sql_query, *sql_query_terms)
      if @patterns.empty?
        @no_results = true
        @patterns = Pattern.all
      end
    end
  end
  
  def create
    redirect_to patterns_path
    if not cookies[:search].nil?
      updated_cookies = []
      updated_cookies.concat cookies[:search].split("&") 
      
      updated_cookies << params[:search]
      cookies[:search] = updated_cookies
    else
      cookies[:search] = [params[:search]]
    end
  end
  
end
