# frozen_string_literal: true

require 'net/http'
require 'uri'
require 'rexml/document'
require_relative 'method.rb'

choice = nil
until [1, 2, 3].include?(choice)
  puts 'Для какого города хотите знать погоду?'
  puts '1 - Минск'
  puts '2 - Молодечно'
  puts '3 - Москва'
  choice = gets.to_i
end

case choice
when 1
  id = 34
when 2
  id = 9160
when 3
  id = 37
end

uri = URI.parse("https://xml.meteoservice.ru/export/gismeteo/point/#{id}.xml")
response = Net::HTTP.get_response(uri)
doc = REXML::Document.new(response.body)
city_name = URI.decode_www_form(doc.root.elements['REPORT/TOWN'].attributes['sname'])[0][0]

puts city_name
doc.root.elements['REPORT/TOWN'].elements.to_a.each do |forecast|
  forecast_output(forecast, doc)
end
