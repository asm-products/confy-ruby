module Confy

  module Api

    # Organizations are owned by users and only (s)he can add/remove teams and projects for that organization. A default organization will be created for every user.
    class Orgs

      def initialize(client)
        @client = client
      end

      # List all organizations the authenticated user is a member of.
      #
      # '/orgs' GET
      def list(options = {})
        body = options.fetch(:query, {})

        @client.get("/orgs", body, options)
      end

      # Create an organization with a name and the email for billing.
      #
      # '/orgs' POST
      #
      # name - Name of the organization
      # email - Billing email of the organization
      def create(name, email, options = {})
        body = options.fetch(:body, {})
        body[:name] = name
        body[:email] = email

        @client.post("/orgs", body, options)
      end

      # Get the given organization if the authenticated user is a member.
      #
      # '/orgs/:org' GET
      #
      # org - Name of the organization
      def retrieve(org, options = {})
        body = options.fetch(:query, {})

        @client.get("/orgs/#{org}", body, options)
      end

      # Update the given organization if the authenticated user is the owner. __Email__ is the only thing which can be updated.
      #
      # '/orgs/:org' PATCH
      #
      # org - Name of the organization
      # email - Billing email of the organization
      def update(org, email, options = {})
        body = options.fetch(:body, {})
        body[:email] = email

        @client.patch("/orgs/#{org}", body, options)
      end

    end

  end

end
