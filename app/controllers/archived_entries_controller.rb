class ArchivedEntriesController < ApplicationController
  # GET /archived_entries or /archived_entries.json
  def index
    @archived_entries = ArchivedEntry.order(published_at: :desc).page(params[:page])
  end
end
