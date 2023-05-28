require "application_system_test_case"

class ArchivedEntriesTest < ApplicationSystemTestCase
  setup do
    @archived_entry = archived_entries(:one)
  end

  test "visiting the index" do
    visit archived_entries_url
    assert_selector "h1", text: "Archived entries"
  end

  test "should create archived entry" do
    visit archived_entries_url
    click_on "New archived entry"

    fill_in "Body", with: @archived_entry.body
    fill_in "Feed", with: @archived_entry.feed_id
    fill_in "Link", with: @archived_entry.link
    fill_in "Published at", with: @archived_entry.published_at
    fill_in "Title", with: @archived_entry.title
    click_on "Create Archived entry"

    assert_text "Archived entry was successfully created"
    click_on "Back"
  end

  test "should update Archived entry" do
    visit archived_entry_url(@archived_entry)
    click_on "Edit this archived entry", match: :first

    fill_in "Body", with: @archived_entry.body
    fill_in "Feed", with: @archived_entry.feed_id
    fill_in "Link", with: @archived_entry.link
    fill_in "Published at", with: @archived_entry.published_at
    fill_in "Title", with: @archived_entry.title
    click_on "Update Archived entry"

    assert_text "Archived entry was successfully updated"
    click_on "Back"
  end

  test "should destroy Archived entry" do
    visit archived_entry_url(@archived_entry)
    click_on "Destroy this archived entry", match: :first

    assert_text "Archived entry was successfully destroyed"
  end
end
