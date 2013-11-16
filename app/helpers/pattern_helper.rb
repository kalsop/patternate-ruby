module PatternHelper
  
  include PatternConstants
  
  def message_box
    if @no_results
      render :partial => "/partials/no_results.html.erb", :locals => {:message => NO_RESULTS_MESSAGE}
    end
  end
  
end
