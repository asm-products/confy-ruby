module Confy

  module HttpClient

    # ResponseHandler takes care of decoding the response body into suitable type
    class ResponseHandler

      def self.get_body(response)
        type = response.headers["content-type"]
        body = response.body

        # Response body is in JSON
        if type and type.include?("json")
          begin
            body = JSON.parse body
          rescue JSON::ParserError
            return body
          end
        end

        return body
      end

    end

  end

end
