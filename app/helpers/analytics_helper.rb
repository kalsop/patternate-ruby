module AnalyticsHelper    
  
  def assign_date_of_first_visit first_visit_cookie
   if first_visit_cookie.nil?
     return Date.today.to_s
   end 
   first_visit_cookie   
  end
  
end