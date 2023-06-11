module FeedsHelper
  def taget_entry_ids(entries)
    entries.map(&:id)
  end
end
