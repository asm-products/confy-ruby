require "faraday"
require "json"

require "confy/api/user"
require "confy/api/orgs"
require "confy/api/teams"
require "confy/api/members"
require "confy/api/projects"
require "confy/api/access"
require "confy/api/envs"
require "confy/api/config"

module Confy

  class Client

    def initialize(auth = {}, options = {})
      @http_client = Confy::HttpClient::HttpClient.new(auth, options)
    end

    # User who is authenticated currently.
    def user()
      Confy::Api::User.new(@http_client)
    end

    # Organizations are owned by users and only (s)he can add/remove teams and projects for that organization. A default organization will be created for every user.
    def orgs()
      Confy::Api::Orgs.new(@http_client)
    end

    # Every organization will have a default team named Owners. Owner of the organization will be a default member for every team.
    #
    # org - Name of the organization
    def teams(org)
      Confy::Api::Teams.new(org, @http_client)
    end

    # Teams contain a list of users. The Authenticated user should be the owner of the organization.
    #
    # org - Name of the organization
    # team - Name of the team
    def members(org, team)
      Confy::Api::Members.new(org, team, @http_client)
    end

    # An organization can contain any number of projects.
    #
    # org - Name of the organization
    def projects(org)
      Confy::Api::Projects.new(org, @http_client)
    end

    # List of teams who has access to the project. Default team __Owners__ will have access to every project. Authenticated user should be the owner of the organization for the below endpoints.
    #
    # org - Name of the organization
    # project - Name of the project
    def access(org, project)
      Confy::Api::Access.new(org, project, @http_client)
    end

    # Every project has a default environment named Production. Each environment has one configuration document which can have many keys and values.
    #
    # org - Name of the organization
    # project - Name of the project
    def envs(org, project)
      Confy::Api::Envs.new(org, project, @http_client)
    end

    # Any member of the team which has access to the project can retrieve any of it's environment's configuration document or edit it.
    #
    # org - Name of the organization
    # project - Name of the project
    # env - Name of the environment
    def config(org, project, env)
      Confy::Api::Config.new(org, project, env, @http_client)
    end

  end

end
