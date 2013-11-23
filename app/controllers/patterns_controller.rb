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
    if cookies[:search].present? && params[:search].present?
      updated_cookies = []
      updated_cookies.concat cookies[:search].split("&") 
      updated_cookies << params[:search]
      cookies[:search] = updated_cookies
    elsif params[:remove].present?
      puts "** in the second if block"
      term_to_remove = params[:remove]
      all_terms = cookies[:search].split("&")
      puts all_terms
      puts term_to_remove.class
      # all_terms - %w{term_to_remove}
      # puts all_terms
      # cookies[:search] = all_terms
      all_terms.delete(term_to_remove)
      puts all_terms
      cookies[:search] = all_terms
      puts cookies[:search]
    elsif params[:clear].present?
      cookies[:search] = []
    else
      cookies[:search] = [params[:search]]
    end
    redirect_to patterns_path
  end
  
end
