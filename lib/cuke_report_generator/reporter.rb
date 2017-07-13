require 'pry'
require 'pry-byebug'

class Reporter
  MAIN_TEMPLATE = 'templates/main.html.erb'.freeze
  FEATURE_TEMPLATE = 'templates/feature.html.erb'.freeze
  ERROR_TEMPLATE = 'templates/errors.html.erb'.freeze

  def initialize(input, output='./output')
    @output = output

  end

end