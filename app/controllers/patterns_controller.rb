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
        sql_query << "description LIKE ?"
        sql_query_terms << "%#{downcase_term}%"
      end
      sql_query = sql_query.join(" AND ")
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
      cookies[:search] = @existing_terms << @additional_term
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
