module Confy

  module Api

    # An organization can contain any number of projects.
    #
    # org - Name of the organization
    class Projects

      def initialize(org, client)
        @org = org
        @client = client
      end

      # List all the projects of the organization which can be seen by the authenticated user.
      #
      # '/orgs/:org/projects' GET
      def list(options = {})
        body = options.fetch(:query, {})

        @client.get("/orgs/#{@org}/projects", body, options)
      end

      # Create a project for the given organization. Authenticated user should be the owner of the organization.
      #
      # '/orgs/:org/projects' POST
      #
      # name - Name of the project
      # description - Description of the project
      def create(name, description, options = {})
        body = options.fetch(:body, {})
        body[:name] = name
        body[:description] = description

        @client.post("/orgs/#{@org}/projects", body, options)
      end

      # Get a project the user has access to.
      #
      # '/orgs/:org/projects/:project' GET
      #
      # project - Name of the project
      def retrieve(project, options = {})
        body = options.fetch(:query, {})

        @client.get("/orgs/#{@org}/projects/#{project}", body, options)
      end

      # Update a project. Authenticated user should be the owner of the organization.
      #
      # '/orgs/:org/projects/:project' PATCH
      #
      # project - Name of the project
      # description - Description of the project
      def update(project, description, options = {})
        body = options.fetch(:body, {})
        body[:description] = description

        @client.patch("/orgs/#{@org}/projects/#{project}", body, options)
      end

      # Delete the given project. Cannot delete the default project in the organization. Authenticated user should be the owner of the organization.
      #
      # '/orgs/:org/projects/:project' DELETE
      #
      # project - Name of the project
      def destroy(project, options = {})
        body = options.fetch(:body, {})

        @client.delete("/orgs/#{@org}/projects/#{project}", body, options)
      end

    end

  end

end
