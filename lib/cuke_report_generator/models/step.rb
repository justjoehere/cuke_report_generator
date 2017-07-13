class Step < Tableless
  attr_reader :name, :outcome, :keyword, :description, :name, :error_message
  attr_reader :rows, :output, :status, :duration, :scenario_id, :feature_id

  def initialize(stepdata, scenario_id, feature_id)
    set_uuid
    @scenario_id = scenario_id
    @feature_id = feature_id
    @keyword = stepdata['keyword']
    @name = stepdata['name']
    @description = stepdata['description']
    @outcome = stepdata['result']['status']
    @duration = stepdata['result']['duration'].nil? ? 0 : stepdata['result']['duration']
    @output = HTMLEntities.new.encode(stepdata['output'].join(', ')) unless stepdata['output'].nil?
    @error_message = stepdata['result']['error_message']
    @rows = get_steprows(stepdata['rows'])
  end

  def get_steprows(row_data)
    rows = []
    return if row_data.nil?
    row_data.each do |r|
      rows << StepRow.new(r, @uuid)
    end
    rows
  end
end
