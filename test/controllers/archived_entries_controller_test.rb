require "test_helper"

class ArchivedEntriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @archived_entry = archived_entries(:one)
  end

  test "should get index" do
    get archived_entries_url
    assert_response :success
  end

  test "should get new" do
    get new_archived_entry_url
    assert_response :success
  end

  test "should create archived_entry" do
    assert_difference("ArchivedEntry.count") do
      post archived_entries_url, params: { archived_entry: { body: @archived_entry.body, feed_id: @archived_entry.feed_id, link: @archived_entry.link, published_at: @archived_entry.published_at, title: @archived_entry.title } }
    end

    assert_redirected_to archived_entry_url(ArchivedEntry.last)
  end

  test "should show archived_entry" do
    get archived_entry_url(@archived_entry)
    assert_response :success
  end

  test "should get edit" do
    get edit_archived_entry_url(@archived_entry)
    assert_response :success
  end

  test "should update archived_entry" do
    patch archived_entry_url(@archived_entry), params: { archived_entry: { body: @archived_entry.body, feed_id: @archived_entry.feed_id, link: @archived_entry.link, published_at: @archived_entry.published_at, title: @archived_entry.title } }
    assert_redirected_to archived_entry_url(@archived_entry)
  end

  test "should destroy archived_entry" do
    assert_difference("ArchivedEntry.count", -1) do
      delete archived_entry_url(@archived_entry)
    end

    assert_redirected_to archived_entries_url
  end
end
