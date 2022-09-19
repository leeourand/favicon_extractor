module FaviconExtractor
  class ChoosesLargestImage
    def self.choose(images)
      return nil unless images.any?

      images.map do |icon|
        {source: icon, size: FastImage.size(icon)}
      end
        .select { |h| h[:size] }
        .max_by { |h| h[:size][0] * h[:size][1] }&.fetch(:source)
    end
  end
end
