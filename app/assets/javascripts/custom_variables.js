// get value of search terms cookie and split it out

var search_terms = $.cookie("search")
var search_terms_array = search_terms.split('&');


search_terms_array.forEach(function(entry) {
  ga('send', 'event', 'Search term', entry);
});


      