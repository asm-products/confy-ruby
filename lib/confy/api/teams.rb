module Confy

  module Api

    # Every organization will have a default team named Owners. Owner of the organization will be a default member for every team.
    #
    # org - Name of the organization
    class Teams

      def initialize(org, client)
        @org = org
        @client = client
      end

      # List teams of the given organization authenticated user is a member of.
      #
      # '/orgs/:org/teams' GET
      def list(options = {})
        body = options.fetch(:query, {})

        @client.get("/orgs/#{@org}/teams", body, options)
      end

      # Create a team for the given organization. Authenticated user should be the owner of the organization.
      #
      # '/orgs/:org/teams' POST
      #
      # name - Name of the team
      # description - Description of the team
      def create(name, description, options = {})
        body = options.fetch(:body, {})
        body[:name] = name
        body[:description] = description

        @client.post("/orgs/#{@org}/teams", body, options)
      end

      # Get a team the user is member of.
      #
      # '/orgs/:org/teams/:team' GET
      #
      # team - Name of the team
      def retrieve(team, options = {})
        body = options.fetch(:query, {})

        @client.get("/orgs/#{@org}/teams/#{team}", body, options)
      end

      # Update a team. Authenticated user should be the owner of the organization.
      #
      # '/orgs/:org/teams/:team' PATCH
      #
      # team - Name of the team
      # description - Description of the team
      def update(team, description, options = {})
        body = options.fetch(:body, {})
        body[:description] = description

        @client.patch("/orgs/#{@org}/teams/#{team}", body, options)
      end

      # Delete the given team. Cannot delete the default team in the organization. Authenticated user should be the owner of the organization.
      #
      # '/orgs/:org/teams/:team' DELETE
      #
      # team - Name of the team
      def destroy(team, options = {})
        body = options.fetch(:body, {})

        @client.delete("/orgs/#{@org}/teams/#{team}", body, options)
      end

    end

  end

end
