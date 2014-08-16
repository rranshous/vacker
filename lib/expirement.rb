class Expirement
  attr_reader :invarients, :varients, :result, :log, :artifacts

  def initialize invarients={}, varients={}
    @invarients = invarients
    @varients = varients
    @result = {}
    @log = []
    @artifacts = []
  end

  def update_result key, value
    @result[key] = value
    self
  end

  def append_log msg
    @log << msg
  end

  def append_artifact data
    @artifacts << data
  end

  def to_hash
    {
      'invarients' => invarients,
      'varients' => varients,
      'result' => result,
      'log' => log,
      'artifacts' => artifacts
    }
  end
end
