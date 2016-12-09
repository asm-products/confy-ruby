require 'confy/config'

RSpec.describe Confy::Config, '#match' do
  context 'with full url' do
    url = 'https://user:pass@api.confy.io/orgs/org/projects/project/envs/env/config'
    result = Confy::Config.match(url)

    it 'should return url object' do
      expect(result).to be_a(Hash)
      expect(result[:host]).to eq 'https://api.confy.io'
    end

    it 'should have auth info' do
      expect(result[:user]).to eq 'user'
      expect(result[:pass]).to eq 'pass'
    end

    it 'should have org info' do
      expect(result[:org]).to eq 'org'
    end

    it 'should have stage info' do
      expect(result[:project]).to eq 'project'
      expect(result[:env]).to eq 'env'
    end

    it 'should not have heroku' do
      expect(result[:heroku]).to eq false
    end

    it 'should not have token' do
      expect(result[:token]).to be_nil
    end

    it 'should have correct path' do
      expect(result[:path]).to eq '/orgs/org/projects/project/envs/env/config'
    end
  end

  context 'with token url' do
    url = 'https://api.confy.io/orgs/org/config/abcdefabcdefabcdefabcdefabcdef1234567890'
    result = Confy::Config.match(url)

    it 'should return url object' do
      expect(result).to be_a(Hash)
      expect(result[:host]).to eq 'https://api.confy.io'
    end

    it 'should not have auth info' do
      expect(result[:user]).to be_nil
      expect(result[:pass]).to be_nil
    end

    it 'should have org info' do
      expect(result[:org]).to eq 'org'
    end

    it 'should not have stage info' do
      expect(result[:project]).to be_nil
      expect(result[:env]).to be_nil
    end

    it 'should not have heroku' do
      expect(result[:heroku]).to eq false
    end

    it 'should have token' do
      expect(result[:token]).to eq 'abcdefabcdefabcdefabcdefabcdef1234567890'
    end

    it 'should have correct path' do
      expect(result[:path]).to eq '/orgs/org/config/abcdefabcdefabcdefabcdefabcdef1234567890'
    end
  end

  context 'with heroku url' do
    url = 'https://user:pass@api.confy.io/heroku/config'
    result = Confy::Config.match(url)

    it 'should return url object' do
      expect(result).to be_a(Hash)
      expect(result[:host]).to eq 'https://api.confy.io'
    end

    it 'should have auth info' do
      expect(result[:user]).to eq 'user'
      expect(result[:pass]).to eq 'pass'
    end

    it 'should not have org info' do
      expect(result[:org]).to be_nil
    end

    it 'should not have stage info' do
      expect(result[:project]).to be_nil
      expect(result[:env]).to be_nil
    end

    it 'should have heroku' do
      expect(result[:heroku]).to eq true
    end

    it 'should not have token' do
      expect(result[:token]).to be_nil
    end

    it 'should have correct path' do
      expect(result[:path]).to eq '/heroku/config'
    end
  end

  context 'with non-string and non-object url' do
    it 'should raise error' do
      expect { Confy::Config.match(8) }.to raise_error(RuntimeError, 'Invalid URL')
    end
  end

  context 'with bad url' do
    it 'should raise error' do
      expect { Confy::Config.match('http://api.confy.io/projects/config') }.to raise_error(RuntimeError, 'Invalid URL')
    end
  end

  context 'with empty object' do
    it 'should raise error' do
      expect { Confy::Config.match({ user: 'user', pass: 'pass', heroku: true }) }.to raise_error(RuntimeError, 'Invalid URL')
    end
  end
end
