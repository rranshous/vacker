require_relative '../lib/expirement'
require_relative '../lib/expirement_endpoint'

class ExpirementUpdateResult < ExpirementEndpoint

  use_defaults
  require_params 'id', 'key', 'value'

  def response(env)
    params = params_for env
    expirement = Expirement.find params.id
    expirement.update_result params.key, params.value
    json_response(expirement)
  end
end
