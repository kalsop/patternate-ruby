class PatternsController < ApplicationController
  
  def index
    @patterns = Pattern.all
    @search_terms = cookies[:search].nil? ? [] : cookies[:search].split("&")
    @has_results = true
    if not @search_terms.empty?
      sql_query = []
      sql_query_terms = []
      @search_terms.each do | term |
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
    @additional_term = params[:search]
    @existing_terms = cookies[:search].nil? ? [] : cookies[:search].split("&")
    @term_to_remove = params[:remove]
    @clear_all_terms = params[:clear]
    
    if (not @existing_terms.empty?) && @additional_term.present?
      # does new term already exist in search terms? If so, don't add it to search terms - each do
      if not @existing_terms.include? @additional_term
        cookies[:search] = @existing_terms << @additional_term
      end
    elsif @term_to_remove.present?
      @existing_terms.delete(@term_to_remove)
      cookies[:search] = @existing_terms
    elsif @clear_all_terms.present?
      cookies[:search] = []
    else
      cookies[:search] = [@additional_term]
    end
    redirect_to patterns_path
  end
  
end
