require "faraday"
require "json"

require "confy/api/user"
require "confy/api/orgs"

module Confy

  class Client

    def initialize(auth = {}, options = {})
      @http_client = Confy::HttpClient::HttpClient.new(auth, options)
    end

    # User who is authenticated currently.
    def user()
      Confy::Api::User.new(@http_client)
    end

    # Organizations are owned by users and only (s)he can add/remove teams and projects for that organization. A default organization will be created for every user.
    def orgs()
      Confy::Api::Orgs.new(@http_client)
    end

  end

end
