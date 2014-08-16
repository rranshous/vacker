require 'json'
require 'goliath'
require_relative '../lib/expirement'
require_relative '../lib/api_endpoint'

class ExpirementCreate < ApiEndpoint

  use_defaults
  use Goliath::Rack::Validation::RequestMethod, ['GET','POST']

  def response(env)
    expirement = Expirement.new self.class.invarients(env),
                                self.class.varients(env)
    json_response(expirement)
  end

  private

  def self.invarients env
    JSON.parse(env['params']['invarients'] || '{}')
  end

  def self.varients env
    JSON.parse(env['params']['varients'] || '{}')
  end
end
