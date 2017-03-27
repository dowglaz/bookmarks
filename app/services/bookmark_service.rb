class BookmarkService
  attr_reader :bookmark

  def initialize(bookmark)
    @bookmark = bookmark
  end

  def find_or_create_site
    unless @bookmark.site.present?
      site = Site.find_or_initialize_by(top_level_url: @bookmark.top_level_url)
      @bookmark.site = site
    end
    self
  end

  def update_site
    if @bookmark.site.top_level_url != @bookmark.top_level_url
      site = Site.find_or_initialize_by(top_level_url: @bookmark.top_level_url)
      @bookmark.site = site
    end
    self
  end

  def save
    @bookmark.save
  end
end
