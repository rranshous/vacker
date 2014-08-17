require_relative '../lib/expirement'
require_relative '../lib/expirement_endpoint'

class ExpirementUpdateResult < ExpirementEndpoint

  use_defaults
  require_params 'id', 'artifact'

  def response(env)
    params = params_for env
    expirement = Expirement.find params.id
    expirement.append_artifact params.artifact
    json_response(expirement)
  end
end

