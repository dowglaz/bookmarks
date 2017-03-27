class BookmarksController < ApplicationController
  def new
    @bookmark = Bookmark.new
    @bookmark.build_site
  end

  def create
    @bookmark = Bookmark.new(bookmark_params)
    service = BookmarkService.new(@bookmark)
    service.find_or_create_site
    if service.save
      flash[:info] = 'Saved successfully'
      redirect_to bookmarks_path
    else
      flash[:error] = @bookmark.errors.full_messages.join('<br>').html_safe
      render 'new'
    end
  end

  def update
    @bookmark = Bookmark.find(params["id"])
    @bookmark.attributes = bookmark_params
    service = BookmarkService.new(@bookmark)
    service.update_site
    if service.save
      flash[:info] = 'Saved successfully'
      redirect_to bookmarks_path
    else
      flash[:error] = @bookmark.errors.full_messages.join('<br>').html_safe
      render 'new'
    end
  end

  def edit
    @bookmark = Bookmark.find(params["id"])
  end

  def index
    query = params["q"]
    if query.present?
      @bookmarks = Bookmark.where("lower(title) like '%#{query.downcase}%'")
      if @bookmarks.empty?
        @bookmarks = Bookmark.all
        flash[:info] = 'Nothing found with this title'
      else
        @filtered = true
      end
    else
      @bookmarks = Bookmark.all
    end
  end

  def destroy
    Bookmark.destroy(params["id"])
    flash[:info] = 'Destroyed successfully'
    redirect_to bookmarks_path
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:title, :url, :shortening)
  end
end
