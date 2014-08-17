require_relative '../lib/expirement'
require_relative '../lib/expirement_endpoint'

class ExpirementGet < ExpirementEndpoint

  use_defaults
  require_params 'id'

  def response(env)
    params = params_for env
    expirement = Expirement.find params.id
    return json_response(expirement) if expirement
    return error_response(404)
  end
end

