# frozen_string_literal: true

module FaviconExtractor
  RSpec.describe FaviconExtractor do
    describe "#extract" do
      let(:url) { double(:url) }
      let(:html) { double(:html) }
      let(:favicons) { double(:favicons) }
      let(:largest_favicon) { double(:largest_favicon) }

      before do
        allow(FaviconExtractor::MakesHttpRequests).to receive(:request).with(url) { html }
        allow(ExtractsFaviconsFromHtml).to receive(:extract).with(html, url) { favicons }
        allow(ChoosesLargestImage).to receive(:choose).with(favicons) { largest_favicon }
      end

      it "extracts the largest favicon" do
        expect(FaviconExtractor.extract(url)).to eq(largest_favicon)
      end
    end

    describe "#extract for real" do
      # Not ideal to test w/ live requests, but this does provide some nice confidence things are working
      it "extracts the largest favicon" do
        expect(FaviconExtractor.extract("http://google.com")).to eq("http://google.com/favicon.ico")
        expect(FaviconExtractor.extract("http://vts.com")).to eq("https://www.vts.com/wp-content/uploads/2018/02/favicon-96x96-new.png")
        expect(FaviconExtractor.extract("http://starbucks.com")).to eq("http://starbucks.com/next_static/icons/pwa-icon-192.png")
      end
    end
  end
end
