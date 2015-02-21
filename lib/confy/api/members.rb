module Confy

  module Api

    # Teams contain a list of users. The Authenticated user should be the owner of the organization.
    #
    # org - Name of the organization
    # team - Name of the team
    class Members

      def initialize(org, team, client)
        @org = org
        @team = team
        @client = client
      end

      # List all the members in the given team. Authenticated user should be a member of the team or the owner of the org.
      #
      # '/orgs/:org/teams/:team/member' GET
      def list(options = {})
        body = options.fetch(:query, {})

        @client.get("/orgs/#{@org}/teams/#{@team}/member", body, options)
      end

      # Add the user to the given team. The __user__ in the request needs to be a string and be the username of a valid user.  The Authenticated user should be the owner of the organization.
      #
      # '/orgs/:org/teams/:team/member' POST
      #
      # user - Username of the user
      def add(user, options = {})
        body = options.fetch(:body, {})
        body[:user] = user

        @client.post("/orgs/#{@org}/teams/#{@team}/member", body, options)
      end

      # Remove users from the given team. The __user__ in the request needs to be a string and be the username of a valid user. Cannot delete the default member in a team.  The Authenticated user should be the owner of the organization.
      #
      # '/orgs/:org/teams/:team/member' DELETE
      #
      # user - Username of the user
      def remove(user, options = {})
        body = options.fetch(:body, {})
        body[:user] = user

        @client.delete("/orgs/#{@org}/teams/#{@team}/member", body, options)
      end

    end

  end

end
