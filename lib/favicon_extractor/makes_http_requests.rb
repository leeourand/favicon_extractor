module FaviconExtractor
  class MakesHttpRequests
    def self.request(location)
      new(location).request
    end

    def initialize(url)
      @redirect_limit = 10
      @redirects = 0
      @url = url
    end

    def request
      raise ArgumentError, 'too many redirects' if @redirects > redirect_limit

      begin
        uri = URI(url)
        response = Net::HTTP.start(uri.host,
                                   uri.port,
                                   read_timeout: 10,
                                   open_timeout: 10,
                                   ssl_timeout: 10,
                                   use_ssl: uri.scheme == 'https') do |http|
          http.request(Net::HTTP::Get.new(uri))
        end

        case response
        when Net::HTTPSuccess
          response.body
        when Net::HTTPRedirection
          @redirects += 1
          @url = response['location']
          request
        else
          response.value
        end
      end
    end

    private

    attr_reader :redirect_limit, :url
  end
end
