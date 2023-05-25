require 'net/http'
require 'rss'

class Feed < ApplicationRecord
  has_many :entries, -> { order(published_at: :desc) }

  def parsed_xml
    xml = Net::HTTP.get(URI.parse(endpoint))
    RSS::Parser.parse(xml)
  end

  def execute
    parsed_xml.items.map do |item|
      if last_updated_at.present? && item.pubDate > last_updated_at
        Entry.create(
          feed: self,
          title: item.title,
          body: strip_tags(item.description).truncate(200),
          published_at: item.pubDate,
          link: item.link
        )
      end
    end
    update_column(:last_updated_at, Time.now)
  end

  def strip_tags(text)
    ActionController::Base.helpers.strip_tags(text)
  end

  def latest10_entries
    entries.take(10)
  end

  def self.by_id_latest_entries
    all.reduce({}) { |h, f| h[f.id] = f.latest10_entries; h}
  end

end
