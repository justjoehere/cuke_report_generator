class Embedding < Tableless
  attr_accessor :mime_type, :data, :scenario_id

  def initialize(embedding, scenario_id)
    @mime_type = embedding['mime_type']
    @data = embedding['data']
    @uuid = SecureRandom.uuid
    @scenario_id = scenario_id
  end
end
