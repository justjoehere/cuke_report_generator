class StepRow < Tableless
  attr_reader :steprow, :step_id

  def initialize(row_data, step_id)
    @steprow = row_data['cells'].join(', ')
    @step_id = step_id
    @uuid = SecureRandom.uuid
  end
end
