require "net/http"
require "fastimage"
require_relative "favicon_extractor/version"
require_relative "favicon_extractor/makes_http_requests"
require_relative "favicon_extractor/extracts_favicons_from_html"
require_relative "favicon_extractor/chooses_largest_image"

module FaviconExtractor
  module_function

  def extract(url)
    html = MakesHttpRequests.request(url)
    favicons = ExtractsFaviconsFromHtml.extract(html, url)
    ChoosesLargestImage.choose(favicons)
  end
end
