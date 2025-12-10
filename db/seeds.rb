require 'httparty'

puts '>> CONTINENTS'
Continent.create!(name: { ru: 'Африка', en: 'Africa' })
Continent.create!(name: { ru: 'Азия', en: 'Asia' })
Continent.create!(name: { ru: 'Европа', en: 'Europe' })
Continent.create!(name: { ru: 'Южная Америка', en: 'South America' })
Continent.create!(name: { ru: 'Северная Америка', en: 'North America' })
Continent.create!(name: { ru: 'Австралия и Океания', en: 'Australia and Oceania' })
puts 'Done'

puts '>> REGIONS'
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

Region.create!(name: { ru: 'Восточная Европа', en: 'East Europe' }, continent: Continent.third)
Region.create!(name: { ru: 'Западная Европа', en: 'West Europe' }, continent: Continent.third)
Region.create!(name: { ru: 'Южная Европа', en: 'South Europe' }, continent: Continent.third)
Region.create!(name: { ru: 'Северная Европа', en: 'North Europe' }, continent: Continent.third)

Region.create!(name: { ru: 'Южная Америка', en: 'South America' }, continent: Continent.fourth)

Region.create!(name: { ru: 'Центральная Америка', en: 'Central America' }, continent: Continent.fifth)
Region.create!(name: { ru: 'Северная Америка', en: 'North America' }, continent: Continent.fifth)
Region.create!(name: { ru: 'Карибские острова', en: 'Caribbean' }, continent: Continent.fifth)

Region.create!(name: { ru: 'Австралия и Новая Зеландия', en: 'Australia and New Zealand' }, continent: Continent.last)
Region.create!(name: { ru: 'Меланезия', en: 'Melanesia' }, continent: Continent.last)
Region.create!(name: { ru: 'Микронезия', en: 'Micronesia' }, continent: Continent.last)
Region.create!(name: { ru: 'Полинезия', en: 'Polynesia' }, continent: Continent.last)
puts 'Done!'

puts '>> COUNTRIES'
puts '> EAST AFRICA'
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
fsal_url = 'https://restcountries.com/v3.1/region/Antarctic'
fsal_res = HTTParty.get(fsal_url)
fsal_data = fsal_res.parsed_response
fsal = fsal_data[0]
fsal_ru = fsal['translations']['rus']['common']
fsal_en = fsal['name']['common']
fsal_code = fsal['cca2']
fsal_flag = fsal['flags']['svg']
puts "#{fsal_ru} - #{fsal_en} - #{fsal_code}"
Country.create!(name: { ru: fsal_ru, en: fsal_en }, code: fsal_code, flag_url: fsal_flag, region: Region.find(1))
south_sudan_url = 'https://restcountries.com/v3.1/subregion/Middle%20Africa'
south_sudan_res = HTTParty.get(south_sudan_url)
south_sudan_data = south_sudan_res.parsed_response
south_sudan = south_sudan_data[5]
south_sudan_ru = south_sudan['translations']['rus']['common']
south_sudan_en = south_sudan['name']['common']
south_sudan_code = south_sudan['cca2']
south_sudan_flag = south_sudan['flags']['svg']
puts "#{south_sudan_ru} - #{south_sudan_en} - #{south_sudan_code}"
Country.create!(name: { ru: south_sudan_ru, en: south_sudan_en }, code: south_sudan_code, flag_url: south_sudan_flag, region: Region.find(1))
zimbabwe_url = 'https://restcountries.com/v3.1/subregion/Southern%20Africa'
zimbabwe_res = HTTParty.get(zimbabwe_url)
zimbabwe_data = zimbabwe_res.parsed_response
zimbabwe = zimbabwe_data[0]
zimbabwe_ru = zimbabwe['translations']['rus']['common']
zimbabwe_en = zimbabwe['name']['common']
zimbabwe_code = zimbabwe['cca2']
zimbabwe_flag = zimbabwe['flags']['svg']
puts "#{zimbabwe_ru} - #{zimbabwe_en} - #{zimbabwe_code}"
Country.create!(name: { ru: zimbabwe_ru, en: zimbabwe_en }, code: zimbabwe_code, flag_url: zimbabwe_flag, region: Region.find(1))

puts '> WEST AFRICA'
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

puts '> CENTRAL AFRICA'
url = 'https://restcountries.com/v3.1/subregion/Middle%20Africa'
res = HTTParty.get(url)
data = res.parsed_response
central_africa_countries = [ data[0], data[1], data[2], data[3], data[4], data[6], data[7], data[8], data[9] ]
central_africa_countries.each do |country|
  ru_name = country['translations']['rus']['common']
  en_name = country['name']['common']
  code = country['cca2']
  flag_url = country['flags']['svg']
  puts "#{ru_name} - #{en_name} - #{code}"
  Country.create!(name: { ru: ru_name, en: en_name }, code: code, flag_url: flag_url, region: Region.find(3))
end

puts '> SOUTH AFRICA'
url = 'https://restcountries.com/v3.1/subregion/Southern%20Africa'
res = HTTParty.get(url)
data = res.parsed_response
south_africa_countries = [ data[1], data[2], data[3], data[4], data[5] ]
south_africa_countries.each do |country|
  ru_name = country['translations']['rus']['common']
  en_name = country['name']['common']
  code = country['cca2']
  flag_url = country['flags']['svg']
  puts "#{ru_name} - #{en_name} - #{code}"
  Country.create!(name: { ru: ru_name, en: en_name }, code: code, flag_url: flag_url, region: Region.find(4))
end
eswatini = Country.last
eswatini.update!(name: { ru: 'Эсватини', en: 'Eswatini' })
eswatini.save
puts "#{eswatini.name['ru']} - #{eswatini.name['en']} - #{eswatini.code}"

puts '> NORTH AFRICA'
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

puts '> EAST ASIA'
url = 'https://restcountries.com/v3.1/subregion/Eastern%20Asia'
res = HTTParty.get(url)
data = res.parsed_response
east_asia_countries = [ data[2], data[4], data[7], data[8], data[13], data[14], data[15], data[16] ]
east_asia_countries.each do |country|
  ru_name = country['translations']['rus']['common']
  en_name = country['name']['common']
  code = country['cca2']
  flag_url = country['flags']['svg']
  puts "#{ru_name} - #{en_name} - #{code}"
  Country.create!(name: { ru: ru_name, en: en_name }, code: code, flag_url: flag_url, region: Region.find(6))
end

puts '> WEST ASIA'
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
cyprus_url = 'https://restcountries.com/v3.1/subregion/Southern%20Europe'
cyprus_res = HTTParty.get(cyprus_url)
cyprus_data = cyprus_res.parsed_response
cyprus = cyprus_data[9]
cyprus_ru = cyprus['translations']['rus']['common']
cyprus_en = cyprus['name']['common']
cyprus_code = cyprus['cca2']
cyprus_flag = cyprus['flags']['svg']
puts "#{cyprus_ru} - #{cyprus_en} - #{cyprus_code}"
Country.create!(name: { ru: cyprus_ru, en: cyprus_en }, code: cyprus_code, flag_url: cyprus_flag, region: Region.find(7))

puts '> CENTRAL ASIA'
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

puts '> SOUTH ASIA'
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

puts '> SOUTHEAST ASIA'
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

puts '> EAST EUROPE'
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
pol_hun_slv_cz_url = 'https://restcountries.com/v3.1/subregion/Central%20Europe'
pol_hun_slv_cz_res = HTTParty.get(pol_hun_slv_cz_url)
pol_hun_slv_cz_data = pol_hun_slv_cz_res.parsed_response
pol_hun_slv_cz = [ pol_hun_slv_cz_data[1], pol_hun_slv_cz_data[2], pol_hun_slv_cz_data[3], pol_hun_slv_cz_data[4] ]
pol_hun_slv_cz.each do |country|
  ru_name = country['translations']['rus']['common']
  en_name = country['name']['common']
  code = country['cca2']
  flag_url = country['flags']['svg']
  puts "#{ru_name} - #{en_name} - #{code}"
  Country.create!(name: { ru: ru_name, en: en_name }, code: code, flag_url: flag_url, region: Region.find(11))
end
bul_rom_url = 'https://restcountries.com/v3.1/subregion/Southeast%20Europe'
bul_rom_res = HTTParty.get(bul_rom_url)
bul_rom_data = bul_rom_res.parsed_response
bul_rom = [ bul_rom_data[1], bul_rom_data[2] ]
bul_rom.each do |country|
  ru_name = country['translations']['rus']['common']
  en_name = country['name']['common']
  code = country['cca2']
  flag_url = country['flags']['svg']
  puts "#{ru_name} - #{en_name} - #{code}"
  Country.create!(name: { ru: ru_name, en: en_name }, code: code, flag_url: flag_url, region: Region.find(11))
end

puts '> WEST EUROPE'
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
austria_url = 'https://restcountries.com/v3.1/subregion/Central%20Europe'
austria_res = HTTParty.get(austria_url)
austria_data = austria_res.parsed_response
austria = austria_data[5]
austria_ru = austria['translations']['rus']['common']
austria_en = austria['name']['common']
austria_code = austria['cca2']
austria_flag = austria['flags']['svg']
puts "#{austria_ru} - #{austria_en} - #{austria_code}"
Country.create!(name: { ru: austria_ru, en: austria_en }, code: austria_code, flag_url: austria_flag, region: Region.find(12))

puts '> SOUTH EUROPE'
url = 'https://restcountries.com/v3.1/subregion/Southern%20Europe'
res = HTTParty.get(url)
data = res.parsed_response
south_europe_countries = [ data[0], data[1], data[2], data[3], data[4], data[5], data[6], data[7], data[8] ]
south_europe_countries.each do |country|
  ru_name = country['translations']['rus']['common']
  en_name = country['name']['common']
  code = country['cca2']
  flag_url = country['flags']['svg']
  puts "#{ru_name} - #{en_name} - #{code}"
  Country.create!(name: { ru: ru_name, en: en_name }, code: code, flag_url: flag_url, region: Region.find(13))
end
se_url = 'https://restcountries.com/v3.1/subregion/Southeast%20Europe'
se_res = HTTParty.get(se_url)
se_data = se_res.parsed_response
se_countries = [ se_data[0], se_data[3], se_data[4], se_data[5], se_data[6], se_data[7], se_data[8] ]
se_countries.each do |country|
  ru_name = country['translations']['rus']['common']
  en_name = country['name']['common']
  code = country['cca2']
  flag_url = country['flags']['svg']
  puts "#{ru_name} - #{en_name} - #{code}"
  Country.create!(name: { ru: ru_name, en: en_name }, code: code, flag_url: flag_url, region: Region.find(13))
end
slovenia_url = 'https://restcountries.com/v3.1/subregion/Central%20Europe'
slovenia_res = HTTParty.get(slovenia_url)
slovenia_data = slovenia_res.parsed_response
slovenia = slovenia_data[0]
slovenia_ru = slovenia['translations']['rus']['common']
slovenia_en = slovenia['name']['common']
slovenia_code = slovenia['cca2']
slovenia_flag = slovenia['flags']['svg']
puts "#{slovenia_ru} - #{slovenia_en} - #{slovenia_code}"
Country.create!(name: { ru: slovenia_ru, en: slovenia_en }, code: slovenia_code, flag_url: slovenia_flag, region: Region.find(13))

puts '> NORTH EUROPE'
url = 'https://restcountries.com/v3.1/subregion/Northern%20Europe'
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

puts '> SOUTH AMERICA'
url = 'https://restcountries.com/v3.1/subregion/South%20America'
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
sa_islands_url = 'https://restcountries.com/v3.1/region/Antarctic'
sa_islands_res = HTTParty.get(sa_islands_url)
sa_islands_data = sa_islands_res.parsed_response
sa_islands = [ sa_islands_data[2], sa_islands_data[4] ]
sa_islands.each do |country|
  ru_name = country['translations']['rus']['common']
  en_name = country['name']['common']
  code = country['cca2']
  flag_url = country['flags']['svg']
  puts "#{ru_name} - #{en_name} - #{code}"
  Country.create!(name: { ru: ru_name, en: en_name }, code: code, flag_url: flag_url, region: Region.find(15))
end

puts '> CENTRAL AMERICA'
url = 'https://restcountries.com/v3.1/subregion/Central%20America'
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
mexico_url = 'https://restcountries.com/v3.1/subregion/North%20America'
mexico_res = HTTParty.get(mexico_url)
mexico_data = mexico_res.parsed_response
mexico = mexico_data[3]
mexico_ru = mexico['translations']['rus']['common']
mexico_en = mexico['name']['common']
mexico_code = mexico['cca2']
mexico_flag = mexico['flags']['svg']
puts "#{mexico_ru} - #{mexico_en} - #{mexico_code}"
Country.create!(name: { ru: mexico_ru, en: mexico_en }, code: mexico_code, flag_url: mexico_flag, region: Region.find(16))

puts '> NORTH AMERICA'
url = 'https://restcountries.com/v3.1/subregion/North%20America'
res = HTTParty.get(url)
data = res.parsed_response
north_america_countries = [ data[1], data[2], data[4], data[5], data[6] ]
north_america_countries.each do |country|
  ru_name = country['translations']['rus']['common']
  en_name = country['name']['common']
  code = country['cca2']
  flag_url = country['flags']['svg']
  puts "#{ru_name} - #{en_name} - #{code}"
  Country.create!(name: { ru: ru_name, en: en_name }, code: code, flag_url: flag_url, region: Region.find(17))
end

puts '> CARIBBEAN'
url = 'https://restcountries.com/v3.1/subregion/Caribbean'
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

puts '> AUSTRALIA AND NEW ZEALAND'
url = 'https://restcountries.com/v3.1/subregion/Australia%20and%20New%20Zealand'
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
herd_url = 'https://restcountries.com/v3.1/region/Antarctic'
herd_res = HTTParty.get(herd_url)
herd_data = herd_res.parsed_response
herd = herd_data[1]
herd_ru = herd['translations']['rus']['common']
herd_en = herd['name']['common']
herd_code = herd['cca2']
herd_flag = herd['flags']['svg']
puts "#{herd_ru} - #{herd_en} - #{herd_code}"
Country.create!(name: { ru: herd_ru, en: herd_en }, code: herd_code, flag_url: herd_flag, region: Region.find(19))

puts '> MELANESIA'
url = 'https://restcountries.com/v3.1/subregion/Melanesia'
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

puts '> MICRONESIA'
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
minor_url = 'https://restcountries.com/v3.1/subregion/North%20America'
minor_res = HTTParty.get(minor_url)
minor_data = minor_res.parsed_response
minor = minor_data[0]
minor_ru = minor['translations']['rus']['common']
minor_en = minor['name']['common']
minor_code = minor['cca2']
minor_flag = minor['flags']['svg']
puts "#{minor_ru} - #{minor_en} - #{minor_code}"
Country.create!(name: { ru: minor_ru, en: minor_en }, code: minor_code, flag_url: minor_flag, region: Region.find(21))

puts '> POLYNESIA'
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

puts '>> DONE'
