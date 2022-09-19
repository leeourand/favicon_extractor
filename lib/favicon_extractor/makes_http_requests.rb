module FaviconExtractor
  class MakesHttpRequests
    def self.request(location)
      new.request(location)
    end

    def initialize
      @redirect_limit = 10
      @redirects = 0
    end

    def request(location)
      raise ArgumentError, "too many redirects" if @redirects > redirect_limit

      begin
        response = Net::HTTP.get_response(URI(location))

        case response
        when Net::HTTPSuccess
          response.body
        when Net::HTTPRedirection
          @redirects += 1
          location = response["location"]
          request(location)
        else
          response.value
        end
      end
    end

    private

    attr_reader :redirect_limit
  end
end
