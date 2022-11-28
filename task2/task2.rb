require 'nokogiri'
require 'net/http'
require 'time'
require 'json'

URL = 'https://www.nasa.gov/api/2/ubernode/479003'

uri = URI.parse(URL)
response = Net::HTTP.get_response(uri)

body = JSON.parse(response.body)

title = body['_source']['title']

date = Time.parse(body['_source']['promo-date-time'],'%F')
date = date.strftime("%F")

release_no = body['_source']['release-id']

data = Nokogiri::HTML(body['_source']['body'])
data.search('div').remove

article_lines = data.text.squeeze("\n").split("\n").select { |item| item.length>0 and item!='-end-'}
article_text = article_lines.join("\n\n")

target_obj = {
    ":title" => title, ":date" => date , ":release_no" => release_no, ":article"=> article_text
}

puts target_obj