class EntriesController < ApplicationController
  before_action :set_entry, only: %i[ show edit update destroy save_to_archive]

  # GET /entries
  def index
    page = params[:page] || 1
    @entries = Entry.includes(:feed).all.order(id: "DESC").page(page)
    @entries_with_feed_key = @entries.group_by { |entry| entry.feed }
  end

  # GET /entries/1
  def show
  end

  # GET /entries/new
  def new
    @entry = Entry.new
  end

  # GET /entries/1/edit
  def edit
  end

  # POST /entries
  def create
    @entry = Entry.new(entry_params)

    if @entry.save
      redirect_to entry_url(@entry), notice: "Entry was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /entries/1
  def update
    if @entry.update(entry_params)
      redirect_to entry_url(@entry), notice: "Entry was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /entries/1
  def destroy
    @entry.destroy

    redirect_to entries_url, notice: "Entry was successfully destroyed."
  end

  # PUT /entries/1/save_to_archive
  def save_to_archive
    begin
      ActiveRecord::Base.transaction do
        ae = ArchivedEntry.create(feed_id: @entry.feed.id, title: @entry.title, body: @entry.body, link: @entry.link, published_at: @entry.published_at)
        @entry.destroy
        raise ActiveRecord::RecordInvalid unless ae.persisted?
        redirect_to entries_url, alert: "Entry was successfully archived."
      end
    rescue ActiveRecord::RecordInvalid => exception
      redirect_to entries_url, notice: "Entry was failed archived."
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_entry
      @entry = Entry.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def entry_params
      params.require(:entry).permit(:feed_id, :title, :link, :body, :published_at)
    end
end
