module Confy

  module Api

    # Every project has a default environment named Production. Each environment has one configuration document which can have many keys and values.
    #
    # org - Name of the organization
    # project - Name of the project
    class Envs

      def initialize(org, project, client)
        @org = org
        @project = project
        @client = client
      end

      # List all the environmens of the project which can be seen by the authenticated user.
      #
      # '/orgs/:org/projects/:project/envs' GET
      def list(options = {})
        body = options.fetch(:query, {})

        @client.get("/orgs/#{@org}/projects/#{@project}/envs", body, options)
      end

      # Create an environment for the given project. Authenticated user should have access to the project.
      #
      # '/orgs/:org/projects/:project/envs' POST
      #
      # name - Name of the environment
      # description - Description of the environment
      def create(name, description, options = {})
        body = options.fetch(:body, {})
        body[:name] = name
        body[:description] = description

        @client.post("/orgs/#{@org}/projects/#{@project}/envs", body, options)
      end

      # Get an environment of the project the user has access to.
      #
      # '/orgs/:org/projects/:project/envs/:env' GET
      #
      # env - Name of the environment
      def retrieve(env, options = {})
        body = options.fetch(:query, {})

        @client.get("/orgs/#{@org}/projects/#{@project}/envs/#{env}", body, options)
      end

      # Update an environment. Authenticated user should have access to the project.
      #
      # '/orgs/:org/projects/:project/envs/:env' PATCH
      #
      # env - Name of the environment
      # description - Description of the environment
      def update(env, description, options = {})
        body = options.fetch(:body, {})
        body[:description] = description

        @client.patch("/orgs/#{@org}/projects/#{@project}/envs/#{env}", body, options)
      end

      # Delete the given environment of the project. Authenticated user should have access to the project. Cannot delete the default environment.
      #
      # '/orgs/:org/projects/:project/envs/:env' DELETE
      #
      # env - Name of the environment
      def destroy(env, options = {})
        body = options.fetch(:body, {})

        @client.delete("/orgs/#{@org}/projects/#{@project}/envs/#{env}", body, options)
      end

    end

  end

end
