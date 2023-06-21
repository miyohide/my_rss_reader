class ArchivedEntriesController < ApplicationController
  before_action :set_archived_entry, only: %i[ show edit update destroy ]

  # GET /archived_entries or /archived_entries.json
  def index
    @archived_entries = ArchivedEntry.order(published_at: :desc).page(params[:page])
  end

  # GET /archived_entries/1 or /archived_entries/1.json
  def show
  end

  # GET /archived_entries/new
  def new
    @archived_entry = ArchivedEntry.new
  end

  # GET /archived_entries/1/edit
  def edit
  end

  # POST /archived_entries or /archived_entries.json
  def create
    @archived_entry = ArchivedEntry.new(archived_entry_params)

    respond_to do |format|
      if @archived_entry.save
        format.html { redirect_to archived_entry_url(@archived_entry), notice: "Archived entry was successfully created." }
        format.json { render :show, status: :created, location: @archived_entry }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @archived_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /archived_entries/1 or /archived_entries/1.json
  def update
    respond_to do |format|
      if @archived_entry.update(archived_entry_params)
        format.html { redirect_to archived_entry_url(@archived_entry), notice: "Archived entry was successfully updated." }
        format.json { render :show, status: :ok, location: @archived_entry }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @archived_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /archived_entries/1 or /archived_entries/1.json
  def destroy
    @archived_entry.destroy

    respond_to do |format|
      format.html { redirect_to archived_entries_url, notice: "Archived entry was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_archived_entry
      @archived_entry = ArchivedEntry.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def archived_entry_params
      params.require(:archived_entry).permit(:feed_id, :title, :link, :body, :published_at)
    end
end
