// get value of search terms cookie and split it out

var search_terms = $.cookie("search")
var search_terms_array = search_terms.split('&');
ga('set', 'dimension1', search_terms_array);
      