module PatternHelper
  
  include PatternConstants
  
  def result_summary
    message = ""
    if not @search_terms.empty? 
      if @has_results
        message = RESULTS_MESSAGE
      else
        message = NO_RESULTS_MESSAGE
      end
    else
      message = NO_SEARCH_TERMS_MESSAGE
    end
    render :partial => "/partials/results_summary.html.erb", :locals => {:message => message, :search_terms => @search_terms } 
  end
  
end
