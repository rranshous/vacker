require_relative '../lib/expirement'
require_relative '../lib/expirement_endpoint'

class ExpirementAppendLog < ExpirementEndpoint

  use_defaults
  require_params 'id', 'msg'

  def response(env)
    params = params_for env
    expirement = Expirement.find params.id
    expirement.append_log params.msg
    json_response(expirement)
  end
end

