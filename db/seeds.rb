# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

pattern_companies = PatternCompany.create([{name: 'Vogue Patterns'},{name: 'New Look'}])
pattern_collections = PatternCollection.create([{name: 'Anne Klein', pattern_company: pattern_companies.first},{name: 'Badgely Mishka', pattern_company: pattern_companies.second}])
Pattern.create([

{pattern_company: pattern_companies.first, 
pattern_number: '8372', 
pattern_collection: pattern_collections.first, 
url: 'http://voguepatterns.mccall.com/v8766-products-15146.php?page_id=174', 
main_image: 'http://voguepatterns.mccall.com/filebin/images/product_images/Full/V8766.jpg', 
line_drawing: 'http://voguepatterns.mccall.com/newsletters/img.sewingtoday.com/cat/20000/add_img/V8766.gif', description: 'this is my description'},

{pattern_company: pattern_companies.second, 
pattern_number: '1111', 
pattern_collection: pattern_collections.second, 
url: 'http://voguepatterns.mccall.com/v8766-products-15146.php?page_id=174', 
main_image: 'http://voguepatterns.mccall.com/filebin/images/product_images/Full/V8766.jpg', 
line_drawing: 'http://voguepatterns.mccall.com/newsletters/img.sewingtoday.com/cat/20000/add_img/V8766.gif', description: 'pattern 2'}
])