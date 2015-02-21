module Confy

  module Api

    # User who is authenticated currently.
    class User

      def initialize(client)
        @client = client
      end

      # Get the authenticated user's profile.
      #
      # '/user' GET
      def retrieve(options = {})
        body = options.fetch(:query, {})

        @client.get("/user", body, options)
      end

      # Update the authenticated user's profile. Should use basic authentication.
      #
      # '/user' PATCH
      #
      def update(options = {})
        body = options.fetch(:body, {})

        @client.patch("/user", body, options)
      end

    end

  end

end
