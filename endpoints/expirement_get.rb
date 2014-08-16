require 'goliath'
require_relative '../lib/expirement'
require_relative '../lib/api_endpoint'

class ExpirementGet < ApiEndpoint

  use_defaults
  use Goliath::Rack::Validation::RequestMethod, ['GET']
  use Goliath::Rack::Validation::RequiredParam, { key: 'id' }

  def response(env)
    puts "PARAMS: #{env['params']}"
    expirement = Expirement.find self.class.id(env)
    return json_response(expirement) if expirement
    return error_response(404)
  end

  private

  def self.id env
    env['params']['id']
  end

end

