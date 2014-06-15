module PatternViewHelper
  
  include PatternConstants
  
  def result_summary
    message = ""
    if not @existing_search_terms.empty? 
      if @has_results
        message = RESULTS_MESSAGE
      else
        message = NO_RESULTS_MESSAGE
      end
    else
      message = NO_SEARCH_TERMS_MESSAGE
    end
    render :partial => "/partials/results_summary.html.erb", :locals => {:message => message, :search_terms => @existing_search_terms } 
  end
  
end
