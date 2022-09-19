# frozen_string_literal: true

module FaviconExtractor
  RSpec.describe ChoosesLargestImage do
    describe "#choose" do
      context "image has no size data / doesn't exist" do
        let(:broken_image_url) { double }

        before do
          allow(FastImage).to receive(:size).with(broken_image_url) { nil }
        end

        it "filters out non-existent images" do
          expect(ChoosesLargestImage.choose([broken_image_url])).to eq(nil)
        end
      end

      context "given images of varying size" do
        let(:small_image) { double(:small_image) }
        let(:large_image) { double(:large_image) }

        before do
          allow(FastImage).to receive(:size).with(small_image) { [1, 1] }
          allow(FastImage).to receive(:size).with(large_image) { [2, 2] }
        end

        it "returns the largest image" do
          expect(ChoosesLargestImage.choose([small_image, large_image])).to eq(large_image)
        end
      end
    end
  end
end
