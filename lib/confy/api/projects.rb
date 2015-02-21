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

      # List all the projects of the given organization which can be accessed by the authenticated user.
      #
      # '/orgs/:org/projects' GET
      def list(options = {})
        body = options.fetch(:query, {})

        @client.get("/orgs/#{@org}/projects", body, options)
      end

      # Create a project if the authenticated user is the owner of the given organization. Only the __owners__ team will be able to see the project initially.
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

      # Get the given project in the given organization. Works only if the authenticated user has access to the project.
      #
      # '/orgs/:org/projects/:project' GET
      #
      # project - Name of the project
      def retrieve(project, options = {})
        body = options.fetch(:query, {})

        @client.get("/orgs/#{@org}/projects/#{project}", body, options)
      end

      # Update the given project. __Description__ is the only thing which can be updated. Authenticated user should be the owner of the organization.
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

      # Delete the given project. Authenticated user should be the owner of the organization.
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
