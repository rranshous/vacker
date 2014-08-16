require 'securerandom'
require_relative '../expirement.rb'

module Expirement::InMemory

  LOOKUP = {}

  attr_reader :id

  def initialize *args
    super
    set_id
    track
  end

  def to_hash
    super.merge('id' => id.to_s)
  end

  module ClassMethods
    def find id
      Expirement::InMemory::LOOKUP[id.to_s]
    end
  end

  private

  def set_id
    @id = SecureRandom.hex
  end

  def track
    Expirement::InMemory::LOOKUP[@id.to_s] = self
  end

  def self.prepended klass
    klass.instance_eval do
      extend Expirement::InMemory::ClassMethods
    end
  end

end
