class PatternsController < ApplicationController
  
include PatternSearchHelper
  
  def index
    @patterns = Pattern.all
    @existing_search_terms = get_search_terms cookies[:search]
    @has_results = true
    if not @existing_search_terms.empty?
      sql_query = []
      sql_query_terms = []
      @existing_search_terms.each do | term |
        downcase_term = term.downcase
        # it's not 
        
        sql_query << "description ILIKE ?"
        sql_query_terms << "% #{downcase_term} %"
      end
      sql_query = sql_query.join(" AND ")
      # need to put in a OR query as well to search pattern company, collection and pattern number
      # e.g. WHERE description ilike [terms] OR pattern_company (get the name ahead of time) ILIKE [terms] OR collection ilike [terms] OR pattern number ILIKE [terms]
      @patterns = Pattern.where(sql_query, *sql_query_terms)
      if @patterns.empty?
        @has_results = false
        @patterns = Pattern.all
      end
    end
  end
  
  def create    
    cookies[:search] = update_search_terms(params[:search],get_search_terms(cookies[:search]),params[:remove])
    redirect_to patterns_path
  end
  
end
