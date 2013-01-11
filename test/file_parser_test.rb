require_relative('../lib/dudas/assignment')
require 'pp'
require 'nokogiri'
require 'open-uri'
require 'json'

FILE = './fixtures/ad20120622.xml'

xml = Nokogiri::XML(open(FILE))

xml.css('patent-assignment').each do |record|
  data = Dudas::Assignment.new(record)
  File.open("/Users/george/Desktop/json/" + data.id + ".json", 'w') {|f| f.write(data.to_hash.to_json) }
end