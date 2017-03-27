require 'test_helper'

class BookmarkTest < ActiveSupport::TestCase
  def setup
    @bookmark = bookmarks(:reddit_cats)
  end

  test "it should have a title" do
    assert @bookmark.has_attribute?(:title)
  end

  test "it should have an url" do
    assert @bookmark.has_attribute?(:url)
  end

  test "it should have a shortening" do
    assert @bookmark.has_attribute?(:shortening)
  end

  test "it belongs to a site" do
    assert @bookmark.has_attribute?(:site_id)
  end

  test "has the same toplevel url as its site" do
    assert (@bookmark.top_level_url == @bookmark.site.top_level_url ||
            @bookmark.top_level_url == "#{@bookmark.site.top_level_url}/")
  end

  test "title is mandatory" do
    @bookmark.title = nil
    assert_not @bookmark.save
  end
end
