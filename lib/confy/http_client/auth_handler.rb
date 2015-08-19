require "base64"

module Confy

  module HttpClient

    # AuthHandler takes care of devising the auth type and using it
    class AuthHandler < Faraday::Middleware

      HTTP_PASSWORD = 0

      def initialize(app, auth = {}, options = {})
        @auth = auth
        super(app)
      end

      def call(env)
        if !@auth.empty?
          auth = get_auth_type
          flag = false

          if auth == HTTP_PASSWORD
            env = http_password(env)
            flag = true
          end

          if !flag
            raise StandardError.new "Unable to calculate authorization method. Please check"
          end
        else
          raise StandardError.new "Server requires authentication to proceed further. Please check"
        end

        @app.call(env)
      end

      # Calculating the Authentication Type
      def get_auth_type()

        if @auth.has_key?(:username) and @auth.has_key?(:password)
          return HTTP_PASSWORD
        end

        return -1
      end

      # Basic Authorization with username and password
      def http_password(env)
        code = Base64.strict_encode64 "#{@auth[:username]}:#{@auth[:password]}"

        env[:request_headers]["Authorization"] = "Basic #{code}"

        return env
      end

      def query_params(url)
        if url.query.nil? or url.query.empty?
          {}
        else
          Faraday::Utils.parse_query(url.query)
        end
      end

      def merge_query(env, query)
        query = query.update query_params(env[:url])

        env[:url].query = Faraday::Utils.build_query(query)

        return env
      end
    end

  end

end
