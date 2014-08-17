require_relative '../lib/expirement'
require_relative '../lib/expirement_endpoint'

class ExpirementCreate < ExpirementEndpoint

  use_defaults

  def response(env)
    params = params_for env
    expirement = Expirement.create params.invarients, params.varients
    json_response(expirement)
  end
end
