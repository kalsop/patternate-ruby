module PatternSearchHelper

def get_search_terms search_cookie_value
  search_cookie_value.nil? ? [] : search_cookie_value.split("&")
end



end