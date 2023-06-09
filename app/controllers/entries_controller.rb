class EntriesController < ApplicationController
  before_action :set_entry, only: %i[ show edit update destroy save_to_archive]

  # GET /entries or /entries.json
  def index
    @entries_with_feed_key = Entry.includes(:feed).all.group_by { |e| e.feed }
  end

  # GET /entries/1 or /entries/1.json
  def show
  end

  # GET /entries/new
  def new
    @entry = Entry.new
  end

  # GET /entries/1/edit
  def edit
  end

  # POST /entries or /entries.json
  def create
    @entry = Entry.new(entry_params)

    respond_to do |format|
      if @entry.save
        format.html { redirect_to entry_url(@entry), notice: "Entry was successfully created." }
        format.json { render :show, status: :created, location: @entry }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /entries/1 or /entries/1.json
  def update
    respond_to do |format|
      if @entry.update(entry_params)
        format.html { redirect_to entry_url(@entry), notice: "Entry was successfully updated." }
        format.json { render :show, status: :ok, location: @entry }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /entries/1 or /entries/1.json
  def destroy
    @entry.destroy

    respond_to do |format|
      format.html { redirect_to entries_url, notice: "Entry was successfully destroyed." }
      format.json { head :no_content }
    end
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
