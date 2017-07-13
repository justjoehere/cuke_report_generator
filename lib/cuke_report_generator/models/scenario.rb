class Scenario < Tableless
  attr_reader :name, :outcome, :steps, :tags, :keyword, :name, :description, :rows, :embeddings
  attr_reader :duration, :passing, :failing, :total, :other, :before_hooks, :after_hooks
  attr_reader :feature_id

  def initialize(scenariodata, feature_id)
    set_uuid
    @feature_id = feature_id
    @name = scenariodata['name']
    @description = scenariodata['description']
    @tags = scenariodata['tags'].map { |t| t['name'] }.join(',')
    @keyword = scenariodata['keyword']
    @steps = get_steps(scenariodata['steps'])
    @duration = @steps.map(&:duration).inject(:+)
    @passing = @steps.select { |s| s.outcome == 'passed' }.count
    @failing = @steps.select { |s| s.outcome == 'failed' }.count
    @total = @steps.count
    @other = @total - @passing - @failing
    @outcome = @steps.any? { |s| s.outcome == 'failed' } ? 'failed' : 'passed'
    @embeddings = get_embeddings(scenariodata['after'].reject { |sd| sd['embeddings'].nil? })
    @before_hooks = get_hook(scenariodata['before'])
    @after_hooks = get_hook(scenariodata['after'])
  end

  private

  def get_hook(hook_data)
    hooks = []
    return if hook_data.empty?
    hook_data.each do |h|
      hooks << Hook.new(h, @uuid)
    end
    hooks
  end

  def get_steps(stepdata)
    steps = []
    stepdata.each do |stp|
      steps << Step.new(stp, @uuid, @feature_id)
    end
    steps
  end

  def get_embeddings(embedding_data)
    embeddings = []
    return if embedding_data.empty?
    embedding_data.map { |e| e['embeddings'] }.flatten.each do |embedding|
      embeddings << Embedding.new(embedding, @uuid)
    end
    embeddings
  end
end
