require 'test_helper'

class SiteTest < ActiveSupport::TestCase
  def setup
    @site = sites(:google)
  end

  test "it has a top level url" do
    assert @site.has_attribute?(:top_level_url)
  end

  test "it has many bookmarks" do
    assert @site.bookmarks.count >= 0
  end
end
