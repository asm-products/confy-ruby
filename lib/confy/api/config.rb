module Confy

  module Api

    # Any member of the team which has access to the project can retrieve any of it's environment's configuration document or edit it.
    #
    # org - Name of the organization
    # project - Name of the project
    # env - Name of the environment
    class Config

      def initialize(org, project, env, client)
        @org = org
        @project = project
        @env = env
        @client = client
      end

      # Get an environment configuration
      #
      # '/orgs/:org/projects/:project/envs/:env/config' GET
      def retrieve(options = {})
        body = options.fetch(:query, {})

        @client.get("/orgs/#{@org}/projects/#{@project}/envs/#{@env}/config", body, options)
      end

      # Update the configuration document for the given environment of the project. We will patch the document recursively.
      #
      # '/orgs/:org/projects/:project/envs/:env/config' PATCH
      #
      # config - Configuration to update
      def update(config, options = {})
        body = options.fetch(:body, {})
        body[:config] = config

        @client.patch("/orgs/#{@org}/projects/#{@project}/envs/#{@env}/config", body, options)
      end

      # List the last 10 versions of the environment configuration
      #
      # '/orgs/:org/projects/:project/envs/:env/versions' GET
      def versions(options = {})
        body = options.fetch(:query, {})

        @client.get("/orgs/#{@org}/projects/#{@project}/envs/#{@env}/versions", body, options)
      end

    end

  end

end
