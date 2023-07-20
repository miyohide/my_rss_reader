class FeedsController < ApplicationController
  before_action :set_feed, only: %i[ show edit update destroy entry_update]

  # GET /feeds
  def index
    @feeds = Feed.includes(:entries).all
    @feed_with_entries = Feed.by_id_latest_entries
  end

  # GET /feeds/1
  def show
    @entries = @feed.entries.page(params[:page])
  end

  # GET /feeds/new
  def new
    @feed = Feed.new
  end

  # GET /feeds/1/edit
  def edit
  end

  # POST /feeds
  def create
    @feed = Feed.new(feed_params)
    # last_updated_atに初期値を入れる。あまり昔のデータをいれないために仮に1年前を設定する
    @feed.last_updated_at = Time.now - 1.year

    respond_to do |format|
      if @feed.save
        format.html { redirect_to feed_url(@feed), notice: "Feed was successfully created." }
        format.json { render :show, status: :created, location: @feed }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @feed.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /feeds/1
  def update
    respond_to do |format|
      if @feed.update(feed_params)
        format.html { redirect_to feed_url(@feed), notice: "Feed was successfully updated." }
        format.json { render :show, status: :ok, location: @feed }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @feed.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /feeds/1
  def destroy
    @feed.destroy

    respond_to do |format|
      format.html { redirect_to feeds_url, notice: "Feed was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def entry_update
    @feed.execute
    redirect_to feed_url(@feed), notice: "Execute entry update"
  end

  def archived
    begin
      ActiveRecord::Base.transaction do
        f = Feed.find(params[:feed_id])
        e = Entry.find(params[:entry_id])
        ArchivedEntry.create(feed_id: f.id, title: e.title, body: e.body, link: e.link, published_at: e.published_at)
        e.destroy

        redirect_to feed_url(f), notice: "Entry was successfully archived."
      end
    rescue ActiveRecord::RecordInvalid => exception
      redirect_to entries_url, notice: "Entry was failed archived."
    end
  end

  def archivedall
    f = Feed.find(params[:feed_id])
    begin
      ActiveRecord::Base.transaction do
        params[:target_ids].each do |entity_id|
          e = Entry.find(entity_id)
          ArchivedEntry.create(feed_id: f.id, title: e.title, body: e.body, link: e.link, published_at: e.published_at)
          e.destroy
        end
        redirect_to feed_url(f), notice: "All entries archived."
      end
    rescue => exception
      redirect_to feeds_url, notice: "Entry was failed archived."
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_feed
      @feed = Feed.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def feed_params
      params.require(:feed).permit(:title, :endpoint)
    end
end
