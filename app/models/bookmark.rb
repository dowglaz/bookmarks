class Bookmark < ApplicationRecord
  belongs_to :site

  validates :title, :url, :site, presence: true
  validate :valid_uri

  def top_level_url
    uri = URI.parse(self.url)
    uri.path = '/'
    uri.to_s
  end

  private

  def valid_uri
    uri = URI.parse(self.url)
    if uri.nil? || uri.host.nil? || uri.scheme.nil?
      errors.add(:url, "is not a valid URI")
    end
  end
end
