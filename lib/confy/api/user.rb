module Confy

  module Api

    # User who is authenticated currently.
    class User

      def initialize(client)
        @client = client
      end

      # Get the authenticated user's info.
      #
      # '/user' GET
      def retrieve(options = {})
        body = options.fetch(:query, {})

        @client.get("/user", body, options)
      end

      # Update the authenticated user's profile
      #
      # '/user' PATCH
      #
      # email - Profile email of the user
      def update(email, options = {})
        body = options.fetch(:body, {})
        body[:email] = email

        @client.patch("/user", body, options)
      end

    end

  end

end
