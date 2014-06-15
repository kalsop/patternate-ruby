module PatternSearchHelper

def get_search_terms search_cookie_value
  search_cookie_value.nil? ? [] : search_cookie_value.split("&")
end

def update_search_terms additional_term, existing_search_terms, term_to_remove
    if (not existing_search_terms.empty?) && additional_term.present?
      if not existing_search_terms.include? additional_term
        existing_search_terms << additional_term.downcase
      end
    elsif term_to_remove.present?
      existing_search_terms.delete(term_to_remove)
      existing_search_terms
    else
      [additional_term]
    end
end

end