require 'httparty'

puts 'Creating countries...'
puts 'East Africa countries'
url = 'https://restcountries.com/v3.1/subregion/Eastern%20Africa'
res = HTTParty.get(url)
data = res.parsed_response
data.each do |country|
  ru_name = country['translations']['rus']['common']
  en_name = country['name']['common']
  code = country['cca2']
  flag_url = country['flags']['svg']
  puts "#{ru_name} - #{en_name} - #{code}"
end

puts 'West Africa countries'
url = 'https://restcountries.com/v3.1/subregion/Western%20Africa'
res = HTTParty.get(url)
data = res.parsed_response
data.each do |country|
  ru_name = country['translations']['rus']['common']
  en_name = country['name']['common']
  code = country['cca2']
  flag_url = country['flags']['svg']
  puts "#{ru_name} - #{en_name} - #{code}"
end

puts 'Central Africa countries'
url = 'https://restcountries.com/v3.1/subregion/Middle%20Africa'
res = HTTParty.get(url)
data = res.parsed_response
data.each do |country|
  ru_name = country['translations']['rus']['common']
  en_name = country['name']['common']
  code = country['cca2']
  flag_url = country['flags']['svg']
  puts "#{ru_name} - #{en_name} - #{code}"
end

puts 'South Africa countries'
url = 'https://restcountries.com/v3.1/subregion/Southern%20Africa'
res = HTTParty.get(url)
data = res.parsed_response
data.each do |country|
  ru_name = country['translations']['rus']['common']
  en_name = country['name']['common']
  code = country['cca2']
  flag_url = country['flags']['svg']
  puts "#{ru_name} - #{en_name} - #{code}"
end

puts 'North Africa countries'
url = 'https://restcountries.com/v3.1/subregion/Northern%20Africa'
res = HTTParty.get(url)
data = res.parsed_response
data.each do |country|
  ru_name = country['translations']['rus']['common']
  en_name = country['name']['common']
  code = country['cca2']
  flag_url = country['flags']['svg']
  puts "#{ru_name} - #{en_name} - #{code}"
end

puts '==================================='

puts 'East Asia countries'
url = 'https://restcountries.com/v3.1/subregion/Eastern%20Asia'
res = HTTParty.get(url)
data = res.parsed_response
ea_countries = [ data[0], data[2], data[3], data[4], data[9], data[10], data[13], data[16] ]
ea_countries.each do |country|
  ru_name = country['translations']['rus']['common']
  en_name = country['name']['common']
  code = country['cca2']
  flag_url = country['flags']['svg']
  puts "#{ru_name} - #{en_name} - #{code}"
end

puts 'West Asia countries'
url = 'https://restcountries.com/v3.1/subregion/Western%20Asia'
res = HTTParty.get(url)
data = res.parsed_response
data.each do |country|
  ru_name = country['translations']['rus']['common']
  en_name = country['name']['common']
  code = country['cca2']
  flag_url = country['flags']['svg']
  puts "#{ru_name} - #{en_name} - #{code}"
end

puts 'Central Asia countries'
url = 'https://restcountries.com/v3.1/subregion/Central%20Asia'
res = HTTParty.get(url)
data = res.parsed_response
data.each do |country|
  ru_name = country['translations']['rus']['common']
  en_name = country['name']['common']
  code = country['cca2']
  flag_url = country['flags']['svg']
  puts "#{ru_name} - #{en_name} - #{code}"
end

puts 'South Asia countries'
url = 'https://restcountries.com/v3.1/subregion/Southern%20Asia'
res = HTTParty.get(url)
data = res.parsed_response
data.each do |country|
  ru_name = country['translations']['rus']['common']
  en_name = country['name']['common']
  code = country['cca2']
  flag_url = country['flags']['svg']
  puts "#{ru_name} - #{en_name} - #{code}"
end

puts 'Southeast Asia countries'
url = 'https://restcountries.com/v3.1/subregion/South-eastern%20Asia'
res = HTTParty.get(url)
data = res.parsed_response
data.each do |country|
  ru_name = country['translations']['rus']['common']
  en_name = country['name']['common']
  code = country['cca2']
  flag_url = country['flags']['svg']
  puts "#{ru_name} - #{en_name} - #{code}"
end

puts '==================================='

puts 'Eastern Europe countries'
url = 'https://restcountries.com/v3.1/subregion/Eastern%20Europe'
res = HTTParty.get(url)
data = res.parsed_response
data.each do |country|
  ru_name = country['translations']['rus']['common']
  en_name = country['name']['common']
  code = country['cca2']
  flag_url = country['flags']['svg']
  puts "#{ru_name} - #{en_name} - #{code}"
end

puts 'Western Europe countries'
url = 'https://restcountries.com/v3.1/subregion/Western%20Europe'
res = HTTParty.get(url)
data = res.parsed_response
data.each do |country|
  ru_name = country['translations']['rus']['common']
  en_name = country['name']['common']
  code = country['cca2']
  flag_url = country['flags']['svg']
  puts "#{ru_name} - #{en_name} - #{code}"
end

puts 'Central Europe countries'
url = 'https://restcountries.com/v3.1/subregion/Central%20Europe'
res = HTTParty.get(url)
data = res.parsed_response
data.each do |country|
  ru_name = country['translations']['rus']['common']
  en_name = country['name']['common']
  code = country['cca2']
  flag_url = country['flags']['svg']
  puts "#{ru_name} - #{en_name} - #{code}"
end

puts 'Southern Europe countries'
url = 'https://restcountries.com/v3.1/subregion/Southern%20Europe'
res = HTTParty.get(url)
data = res.parsed_response
data.each do |country|
  ru_name = country['translations']['rus']['common']
  en_name = country['name']['common']
  code = country['cca2']
  flag_url = country['flags']['svg']
  puts "#{ru_name} - #{en_name} - #{code}"
end

puts 'Southeast Europe countries'
url = 'https://restcountries.com/v3.1/subregion/Southeast%20Europe'
res = HTTParty.get(url)
data = res.parsed_response
data.each do |country|
  ru_name = country['translations']['rus']['common']
  en_name = country['name']['common']
  code = country['cca2']
  flag_url = country['flags']['svg']
  puts "#{ru_name} - #{en_name} - #{code}"
end

puts 'Northern Europe countries'
url = 'https://restcountries.com/v3.1/subregion/Northern%20Europe'
res = HTTParty.get(url)
data = res.parsed_response
data.each do |country|
  ru_name = country['translations']['rus']['common']
  en_name = country['name']['common']
  code = country['cca2']
  flag_url = country['flags']['svg']
  puts "#{ru_name} - #{en_name} - #{code}"
end

puts '==================================='

puts 'South America countries'
url = 'https://restcountries.com/v3.1/subregion/South%20America'
res = HTTParty.get(url)
data = res.parsed_response
data.each do |country|
  ru_name = country['translations']['rus']['common']
  en_name = country['name']['common']
  code = country['cca2']
  flag_url = country['flags']['svg']
  puts "#{ru_name} - #{en_name} - #{code}"
end

puts 'Central America countries'
url = 'https://restcountries.com/v3.1/subregion/Central%20America'
res = HTTParty.get(url)
data = res.parsed_response
data.each do |country|
  ru_name = country['translations']['rus']['common']
  en_name = country['name']['common']
  code = country['cca2']
  flag_url = country['flags']['svg']
  puts "#{ru_name} - #{en_name} - #{code}"
end

puts 'North America countries'
url = 'https://restcountries.com/v3.1/subregion/North%20America'
res = HTTParty.get(url)
data = res.parsed_response
data.each do |country|
  ru_name = country['translations']['rus']['common']
  en_name = country['name']['common']
  code = country['cca2']
  flag_url = country['flags']['svg']
  puts "#{ru_name} - #{en_name} - #{code}"
end

puts 'Caribbean countries'
url = 'https://restcountries.com/v3.1/subregion/Caribbean'
res = HTTParty.get(url)
data = res.parsed_response
data.each do |country|
  ru_name = country['translations']['rus']['common']
  en_name = country['name']['common']
  code = country['cca2']
  flag_url = country['flags']['svg']
  puts "#{ru_name} - #{en_name} - #{code}"
end

puts '==================================='

puts 'Micronesia countries'
url = 'https://restcountries.com/v3.1/subregion/Micronesia'
res = HTTParty.get(url)
data = res.parsed_response
data.each do |country|
  ru_name = country['translations']['rus']['common']
  en_name = country['name']['common']
  code = country['cca2']
  flag_url = country['flags']['svg']
  puts "#{ru_name} - #{en_name} - #{code}"
end

puts 'Polynesia countries'
url = 'https://restcountries.com/v3.1/subregion/Polynesia'
res = HTTParty.get(url)
data = res.parsed_response
data.each do |country|
  ru_name = country['translations']['rus']['common']
  en_name = country['name']['common']
  code = country['cca2']
  flag_url = country['flags']['svg']
  puts "#{ru_name} - #{en_name} - #{code}"
end

puts 'Australia and New Zealand countries'
url = 'https://restcountries.com/v3.1/subregion/Australia%20and%20New%20Zealand'
res = HTTParty.get(url)
data = res.parsed_response
data.each do |country|
  ru_name = country['translations']['rus']['common']
  en_name = country['name']['common']
  code = country['cca2']
  flag_url = country['flags']['svg']
  puts "#{ru_name} - #{en_name} - #{code}"
end

puts 'Melanesia countries'
url = 'https://restcountries.com/v3.1/subregion/Melanesia'
res = HTTParty.get(url)
data = res.parsed_response
data.each do |country|
  ru_name = country['translations']['rus']['common']
  en_name = country['name']['common']
  code = country['cca2']
  flag_url = country['flags']['svg']
  puts "#{ru_name} - #{en_name} - #{code}"
end

puts 'Antarctica countries'
url = 'https://restcountries.com/v3.1/region/Antarctic'
res = HTTParty.get(url)
data = res.parsed_response
data.each do |country|
  ru_name = country['translations']['rus']['common']
  en_name = country['name']['common']
  code = country['cca2']
  flag_url = country['flags']['svg']
  puts "#{ru_name} - #{en_name} - #{code}"
end

puts 'Done!'
