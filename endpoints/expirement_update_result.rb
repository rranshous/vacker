require 'goliath'
require_relative '../lib/expirement'
require_relative '../lib/api_endpoint'

class ExpirementUpdateResult < ApiEndpoint

  use_defaults
  use Goliath::Rack::Validation::RequestMethod, ['GET','POST']
  use Goliath::Rack::Validation::RequiredParam, { key: 'id' }
  use Goliath::Rack::Validation::RequiredParam, { key: 'key' }
  use Goliath::Rack::Validation::RequiredParam, { key: 'value' }

  def response(env)
    expirement = Expirement.find self.class.id(env)
    expirement.update_result self.class.key(env), self.class.value(env)
    json_response(expirement)
  end

  private

  def self.key env
    env['params']['key']
  end

  def self.value env
    env['params']['value']
  end

  def self.id env
    env['params']['id']
  end
end
