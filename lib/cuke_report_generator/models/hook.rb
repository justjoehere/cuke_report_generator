class Hook < Tableless
  attr_reader :output, :outcome, :duration, :scenario_id

  def initialize(hook_data, scenario_id)
    @output = hook_data['output'].nil? || hook_data['output'].empty? ? "" : HTMLEntities.new.encode(hook_data['output'].join(', '))
    @outcome = hook_data['result']['status']
    @duration = hook_data['result']['duration']
    @uuid = SecureRandom.uuid
    @scenario_id = scenario_id
  end
end
