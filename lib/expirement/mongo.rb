require_relative '../expirement.rb'
require 'pry'

# invarients - hash
# varients - hash
# result - hash
# log - array
# artifacts - array

module Expirement::Mongo

  @@collection = nil

  def initialize id
    @id = id
  end

  def update_result key, value
    self.class.set_sub_key @id, key, value
    self
  end

  def append_log msg
    self.class.push @id, :log, msg
    self
  end

  def append_artifact data
    self.class.push @id, :artifacts, data
    self
  end

  def invarients
    self.class.value_for_key(@id, :invarients) || {}
  end

  def varients
    self.class.value_for_key(@id, :varients) || {}
  end

  def result
    self.class.value_for_key(@id, :result) || {}
  end

  def log
    self.class.value_for_key(@id, :log) || []
  end

  def artifacts
    self.class.value_for_key(@id, :artifacts) || []
  end

  def to_hash
    doc = self.class.doc_for @id
    { 'invarients' => doc['invarients'] || {},
      'varients' => doc['varients'] || {},
      'result' => doc['result'] || {},
      'log' => doc['log'] || [],
      'artifacts' => doc['artifacts'] || [] }
  end

  module ClassMethods
    def bind mongo
      @@collection = mongo.collection 'expirement'
    end

    def find id
      doc = doc_for id
      unless doc.nil?
        return self.new(doc['_id'])
      end
      nil
    end

    def create invarients={}, varients={}
      id = @@collection.insert({ 'invarients' => invarients,
                                 'varients' => varients })
      self.new id
    end

    def value_for_key id, key
      @@collection.find_one({ _id: id })[key.to_s]
    end

    def set_sub_key id, top_key, sub_key, value
      @@collection.update({"_id" => id},
                          { "$set" =>
                            { top_key => { sub_key => value }}})
    end

    def push id, key, value
      @@collection.update({ _id: id}, { "$push" => { key => value }})
    end

    def doc_for id
      @@collection.find_one({ _id: id })
    end

  end

  def update_result key, value
    @@collection.update({ _id: id}, {"$set" => {key => value}})
  end

  private

  def self.prepended klass
    klass.instance_eval do
      extend Expirement::Mongo::ClassMethods
    end
  end
end

