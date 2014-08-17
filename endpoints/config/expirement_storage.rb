require 'pry'

environment :development do
  require_relative '../../lib/expirement/mongo'
  import('mongo')
  class ::Expirement
    puts "BINDING MONGO"
    prepend ::Expirement::Mongo
  end
  ::Expirement.bind config['mongo']
end

environment :production do
  require_relative '../../lib/expirement/mongo'
  import('mongo')
  class ::Expirement
    puts "BINDING MONGO"
    prepend ::Expirement::Mongo
  end
  ::Expirement.bind config['mongo']
end
