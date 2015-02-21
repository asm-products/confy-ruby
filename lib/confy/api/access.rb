module Confy

  module Api

    # List of teams whic have access to the project. Default team __Owners__ will have access to every project. Authenticated user should be the owner of the organization for the below endpoints.
    #
    # org - Name of the organization
    # project - Name of the project
    class Access

      def initialize(org, project, client)
        @org = org
        @project = project
        @client = client
      end

      # Retrieve a list of teams which have access to the given project. Authenticated user should be a member of the team.
      #
      # '/orgs/:org/projects/:project/access' GET
      def list(options = {})
        body = options.fetch(:query, {})

        @client.get("/orgs/#{@org}/projects/#{@project}/access", body, options)
      end

      # Give the team access to the given project. The __team__ in the request needs to be a string and should be the name of a valid team. Authenticated user should be the owner of the organization.
      #
      # '/orgs/:org/projects/:project/access' POST
      #
      # team - Name of the team
      def add(team, options = {})
        body = options.fetch(:body, {})
        body[:team] = team

        @client.post("/orgs/#{@org}/projects/#{@project}/access", body, options)
      end

      # Remove project access for the given team. The __team__ in the request needs to be a string and should be the name of a valid team. Can't delete default team's access. Authenticated user should be the owner of the organization.
      #
      # '/orgs/:org/projects/:project/access' DELETE
      #
      # team - Name of the team
      def remove(team, options = {})
        body = options.fetch(:body, {})
        body[:team] = team

        @client.delete("/orgs/#{@org}/projects/#{@project}/access", body, options)
      end

    end

  end

end
