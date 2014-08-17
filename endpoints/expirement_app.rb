require_relative '../lib/expirement'
require_relative '../lib/expirement_endpoint'

class ExpirementApp < ExpirementEndpoint
  def response env
    action = path.split('/')[1]
    endpoint = load_endpoint action
    app = Goliath::Rack::Builder.build(endpoint, endpoint.new)
    app.call(env)
  end

  private

  def load_endpoint action
    require_relative "expirement_#{action}"
    const = "Expirement#{action.split('_').map{|v|v.capitalize}.join()}"
    Object.const_get(const)
  end
end
