class Feature < Tableless
  attr_reader :name, :outcome, :description, :tags, :scenarios
  attr_reader :duration, :passing, :failing, :total, :other
  attr_reader :run_id

  def initialize(raw_result, run_id)
    set_uuid
    @name = raw_result['name']
    @description = raw_result['description']
    @tags = raw_result['tags'].map { |t| t['name'] }.join(',') unless raw_result['tags'].nil?
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
    background_exists = false
    background_steps = []
    scenariodata.each do |s|
      # TODO: If scenario = background, need to join w/next scenario
      if s['keyword'] == 'Background'
        background_exists = true
        background_steps = s['steps']
        next
      elsif s['keyword'] != 'Background' && background_exists
        background_steps.reverse_each { |x| s['steps'].unshift x }
        background_exists = false
        background_steps = []
      elsif s['keyword'] != 'Background'
        # normal step, no prior background steps
      else
        raise "I did something wrong"
      end
      sc << Scenario.new(s, @uuid)
    end
    sc
  end
end
