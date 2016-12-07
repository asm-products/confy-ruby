require "json"
require "openssl"
require "digest/md5"
require "base64"

module Confy

  class Config

    def self.load(url = {})
      if url.is_a?(String)
        name_regex = '([a-z0-9][a-z0-9-]*[a-z0-9])'
        token_regex = '([a-f0-9]{40})'
        path_regex = 'orgs\\/' + name_regex + '(\\/projects\\/' + name_regex + '\\/envs\\/' + name_regex + '\\/config|config\\/' + token_regex + ')'
        url_regex = Regexp.new('(https?:\\/\\/)((.*):(.*)@)?(.*)\\/(' + path_regex + '|heroku\\/config)', true)

        matches = url_regex.match(url)

        raise 'Invalid url' if matches.nil?

        url = {
          :host => matches[1] + matches[5],
          :user => matches[3], :pass => matches[4],
          :org => matches[7], :project => matches[9], :env => matches[10],
          :token => matches[11],
          :heroku => (matches[6] == 'heroku/config')
        }
      end

      raise 'Invalid url' if !url.is_a?(Hash)

      if url[:user] and url[:pass] and url[:heroku]
        url[:path] = '/heroku/config'
      elsif url[:token] and url[:org]
        url[:path] = '/orgs/' + url[:org] + '/config/' + url[:token]
      elsif url[:user] and url[:pass] and url[:org] and url[:project] and url[:env]:
        url[:path] = '/orgs/' + url[:org] + '/projects/' + url[:project] + '/envs/' + url[:env]
      else
        raise 'Invalid configuration to generate URL'
      end

      auth = {}

      if url[:user] and url[:pass]
        auth[:username] = url[:user]
        auth[:password] = url[:pass]
      end

      client = Confy::Client.new(auth, { :base => url[:host] })

      body = client.instance_variable_get(:@http_client).get(url[:path]).body

      return body if body.is_a?(Hash)

      decryptPass = ENV['CONFY_DECRYPT_PASS']

      raise 'Invalid credential document' if !body.is_a?(String)
      raise 'No decryption password found. Fill env var CONFY_DECRYPT_PASS' if decryptPass.nil?

      # Strip quotes
      body = body[1..-2] if body[0] == '"' and body[-1] == '"'

      cipher = OpenSSL::Cipher::Cipher.new('aes-256-cbc')
      cipher.decrypt
      cipher.iv = Base64.decode64(body[0..23])
      cipher.key = Digest::MD5.hexdigest(decryptPass)

      decrypted = cipher.update(Base64.decode64(body[24..-1])) + cipher.final

      begin
        body = JSON.parse(decrypted)
      rescue JSON::ParserError
        raise 'Decryption password is wrong'
      end
    end

    def self.env(url = {})
      self.path(self.load(url))
    end

    def self.path(config, str = '')
      type = config.class

      if type == Array
        config.each_with_index do |value, key|
          self.path(value, "#{str}_#{key}")
        end
      elsif type == Hash
        config.each do |key, value|
          self.path(value, "#{str}_#{key.upcase}")
        end
      elsif type == TrueClass
        ENV[str.slice(1, str.length)] = '1'
      elsif type == FalseClass
        ENV[str.slice(1, str.length)] = '0'
      else
        ENV[str.slice(1, str.length)] = config.to_s
      end
    end
  end

end
