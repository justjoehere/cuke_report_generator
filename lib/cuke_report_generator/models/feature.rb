class Feature < Tableless
  attr_reader :name, :outcome, :description, :tags, :scenarios
  attr_reader :duration, :passing, :failing, :total, :other
  attr_reader :run_id

  def initialize(raw_result, run_id)
    set_uuid
    @name = raw_result['name']
    @description = raw_result['description']
    @tags = raw_result['tags'].map { |t| t['name'] }.join(',')
    @scenarios = get_scenarios(raw_result['elements'])
    @duration = @scenarios.map(&:duration).inject(:+)
    @passing = @scenarios.select { |s| s.outcome == 'passed' }.count
    @failing = @scenarios.select { |s| s.outcome == 'failed' }.count
    @total = @scenarios.count
    @other = @total - @passing - @failing
    @outcome = @scenarios.any? { |s| s.outcome == 'failed' } ? 'failed' : 'passed'
    @run_id = run_id
  end

  private

  def get_scenarios(scenariodata)
    sc = []
    scenariodata.each do |s|
      sc << Scenario.new(s, @uuid)
    end
    sc
  end
end
