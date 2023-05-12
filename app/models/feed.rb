require 'net/http'
require 'rss'

class Feed < ApplicationRecord
  has_many :entries

  def parsed_xml
    xml = Net::HTTP.get(URI.parse(endpoint))
    RSS::Parser.parse(xml)
  end
end
