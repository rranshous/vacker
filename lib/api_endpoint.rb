require 'goliath'
class ApiEndpoint < Goliath::API

  def self.use_defaults
    use Goliath::Rack::Params
    use Goliath::Rack::DefaultMimeType
    use Goliath::Rack::Formatters::JSON
    use Goliath::Rack::Render
    use Goliath::Rack::Heartbeat
    use Goliath::Rack::Validation::RequiredParam, { key: 'v' }
  end

  def json_response data
    data = data.to_hash if data.respond_to? :to_hash
    [200, {'Content-Type' => 'application/json'}, data]
  end

  def error_response code
    [code.to_s, {'Content-Type' => 'application/json'}, {}]
  end
end
