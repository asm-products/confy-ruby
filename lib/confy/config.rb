module Confy

  class Config

    def self.load(url = {})
      if url.is_a?(String)
        regex = Regexp.new('(https?:\/\/)(.*):(.*)@(.*)\/orgs\/([a-z0-9]*)\/projects\/([a-z0-9]*)\/envs\/([a-z0-9]*)\/config', true)
        matches = regex.match(url)

        raise 'Invalid url' if matches.nil?

        url = {
          :host => matches[1] + matches[4], :user => matches[2], :pass => matches[3],
          :org => matches[5], :project => matches[6], :env => matches[7]
        }
      end

      client = Confy::Client.new({
        :username => url[:user], :password => url[:pass]
      }, { :base => url[:host] })

      client.config(url[:org], url[:project], url[:env]).retrieve().body
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
