require 'httparty'

puts 'Create continents...'
Continent.create!(name: { ru: 'Африка', en: 'Africa' })
Continent.create!(name: { ru: 'Азия', en: 'Asia' })
Continent.create!(name: { ru: 'Европа', en: 'Europe' })
Continent.create!(name: { ru: 'Южная Америка', en: 'South America' })
Continent.create!(name: { ru: 'Северная Америка', en: 'North America' })
Continent.create!(name: { ru: 'Австралия и Океания', en: 'Australia and Oceania' })
Continent.create!(name: { ru: 'Антарктида', en: 'Antarctica' })
puts 'Done'

puts 'Create regions...'
Region.create!(name: { ru: 'Восточная Африка', en: 'East Africa' }, continent: Continent.first)
Region.create!(name: { ru: 'Западная Африка', en: 'West Africa' }, continent: Continent.first)
Region.create!(name: { ru: 'Центральная Африка', en: 'Central Africa' }, continent: Continent.first)
Region.create!(name: { ru: 'Южная Африка', en: 'South Africa' }, continent: Continent.first)
Region.create!(name: { ru: 'Северная Африка', en: 'North Africa' }, continent: Continent.first)
Region.create!(name: { ru: 'Восточная Азия', en: 'East Asia' }, continent: Continent.second)
Region.create!(name: { ru: 'Западная Азия', en: 'West Asia' }, continent: Continent.second)
Region.create!(name: { ru: 'Центральная Азия', en: 'Central Asia' }, continent: Continent.second)
Region.create!(name: { ru: 'Южная Азия', en: 'South Asia' }, continent: Continent.second)
Region.create!(name: { ru: 'Юго-Восточная Азия', en: 'Southeast Asia' }, continent: Continent.second)
Region.create!(name: { ru: 'Восточная Европа', en: 'Eastern Europe' }, continent: Continent.third)
Region.create!(name: { ru: 'Западная Европа', en: 'Western Europe' }, continent: Continent.third)
Region.create!(name: { ru: 'Центральная Европа', en: 'Central Europe' }, continent: Continent.third)
Region.create!(name: { ru: 'Южная Европа', en: 'Southern Europe' }, continent: Continent.third)
Region.create!(name: { ru: 'Юго-Восточная Европа', en: 'Southeast Europe' }, continent: Continent.third)
Region.create!(name: { ru: 'Северная Европа', en: 'Northern Europe' }, continent: Continent.third)
Region.create!(name: { ru: 'Южная Америка', en: 'South America' }, continent: Continent.fourth)
Region.create!(name: { ru: 'Центральная Америка', en: 'Central America' }, continent: Continent.fifth)
Region.create!(name: { ru: 'Северная Америка', en: 'North America' }, continent: Continent.fifth)
Region.create!(name: { ru: 'Карибские острова', en: 'Caribbean' }, continent: Continent.fifth)
Region.create!(name: { ru: 'Микронезия', en: 'Micronesia' }, continent: Continent.find(6))
Region.create!(name: { ru: 'Полинезия', en: 'Polynesia' }, continent: Continent.find(6))
Region.create!(name: { ru: 'Австралия и Новая Зеландия', en: 'Australia and New Zealand' }, continent: Continent.find(6))
Region.create!(name: { ru: 'Меланезия', en: 'Melanesia' }, continent: Continent.find(6))
Region.create!(name: { ru: 'Антарктида', en: 'Antarctica' }, continent: Continent.last)
puts 'Done!'

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
  Country.create!(name: { ru: ru_name, en: en_name }, code: code, flag_url: flag_url, region: Region.find(1))
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
  Country.create!(name: { ru: ru_name, en: en_name }, code: code, flag_url: flag_url, region: Region.find(2))
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
  Country.create!(name: { ru: ru_name, en: en_name }, code: code, flag_url: flag_url, region: Region.find(3))
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
  Country.create!(name: { ru: ru_name, en: en_name }, code: code, flag_url: flag_url, region: Region.find(4))
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
  Country.create!(name: { ru: ru_name, en: en_name }, code: code, flag_url: flag_url, region: Region.find(5))
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
  Country.create!(name: { ru: ru_name, en: en_name }, code: code, flag_url: flag_url, region: Region.find(6))
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
  Country.create!(name: { ru: ru_name, en: en_name }, code: code, flag_url: flag_url, region: Region.find(7))
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
  Country.create!(name: { ru: ru_name, en: en_name }, code: code, flag_url: flag_url, region: Region.find(8))
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
  Country.create!(name: { ru: ru_name, en: en_name }, code: code, flag_url: flag_url, region: Region.find(9))
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
  Country.create!(name: { ru: ru_name, en: en_name }, code: code, flag_url: flag_url, region: Region.find(10))
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
  Country.create!(name: { ru: ru_name, en: en_name }, code: code, flag_url: flag_url, region: Region.find(11))
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
  Country.create!(name: { ru: ru_name, en: en_name }, code: code, flag_url: flag_url, region: Region.find(12))
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
  Country.create!(name: { ru: ru_name, en: en_name }, code: code, flag_url: flag_url, region: Region.find(13))
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
  Country.create!(name: { ru: ru_name, en: en_name }, code: code, flag_url: flag_url, region: Region.find(14))
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
  Country.create!(name: { ru: ru_name, en: en_name }, code: code, flag_url: flag_url, region: Region.find(15))
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
  Country.create!(name: { ru: ru_name, en: en_name }, code: code, flag_url: flag_url, region: Region.find(16))
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
  Country.create!(name: { ru: ru_name, en: en_name }, code: code, flag_url: flag_url, region: Region.find(17))
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
  Country.create!(name: { ru: ru_name, en: en_name }, code: code, flag_url: flag_url, region: Region.find(18))
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
  Country.create!(name: { ru: ru_name, en: en_name }, code: code, flag_url: flag_url, region: Region.find(19))
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
  Country.create!(name: { ru: ru_name, en: en_name }, code: code, flag_url: flag_url, region: Region.find(20))
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
  Country.create!(name: { ru: ru_name, en: en_name }, code: code, flag_url: flag_url, region: Region.find(21))
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
  Country.create!(name: { ru: ru_name, en: en_name }, code: code, flag_url: flag_url, region: Region.find(22))
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
  Country.create!(name: { ru: ru_name, en: en_name }, code: code, flag_url: flag_url, region: Region.find(23))
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
  Country.create!(name: { ru: ru_name, en: en_name }, code: code, flag_url: flag_url, region: Region.find(24))
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
  Country.create!(name: { ru: ru_name, en: en_name }, code: code, flag_url: flag_url, region: Region.find(25))
end

puts 'Done!'
