require_relative 'api_endpoint'
class ExpirementEndpoint < ApiEndpoint

  def self.use_defaults
    super
    use Goliath::Rack::Validation::RequestMethod, ['GET','POST']
  end

  def self.require_params *params
    params.each do |param|
      puts "adding param: #{param}"
      use Goliath::Rack::Validation::RequiredParam, { key: param.to_s }
    end
  end
end
