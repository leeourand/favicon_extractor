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
  end
end
