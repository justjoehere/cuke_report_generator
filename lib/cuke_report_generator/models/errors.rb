require 'yaml'

class Errors < Tableless
  ERROR_LIST = './data/errors.yml'.freeze
  attr_reader :error_cats

  def initialize(run_data)
    load_categories
    failed_steps = strip_failures(run_data)
    categorize(failed_steps)
  end

  def load_categories
    @error_cats = YAML.load_file(ERROR_LIST)
  end

  def strip_failures(run_data)
    run_data.features.map(&:scenarios).flatten.reject { |sc| sc.outcome == 'passed' }.map { |st| st.steps.select { |stt| stt.outcome == 'failed' } }.flatten
  end

  def categorize(failed_steps)
    # match, if so delete
    @error_cats.each do |ec|
      ec[:failed_steps] = failed_steps.select { |e| Regexp.new(ec['regex'], Regexp::IGNORECASE) =~ e.error_message }.map { |st| { stepname: "#{st.keyword} #{st.name}", step_uuid: st.uuid, error: st.error_message, link_feature: st.feature_id, link_scenario: st.scenario_id } }
      failed_steps.delete_if { |e| Regexp.new(ec['regex'], Regexp::IGNORECASE) =~ e.error_message }
    end
    @error_cats.delete_if { |ec| ec[:failed_steps].empty? }
    @error_cats
  end
end
