require 'net/http'
require 'rss'

class Feed < ApplicationRecord
  has_many :entries

  def parsed_xml
    xml = Net::HTTP.get(URI.parse(endpoint))
    RSS::Parser.parse(xml)
  end

  def execute
    parsed_xml.items.map do |item|
      Entry.create(
        feed: self,
        title: item.title,
        body: strip_tags(item.description).truncate(200),
        published_at: item.pubDate,
        link: item.link
      )
    end
  end

  def strip_tags(text)
    ActionController::Base.helpers.strip_tags(text)
  end
end
