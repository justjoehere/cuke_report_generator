require 'pry'
require 'pry-byebug'

class Reporter
  include CukeReportGenerator
  attr_reader :run
  MAIN_TEMPLATE = File.join(File.dirname(__FILE__), 'templates/main.html.erb').freeze
  FEATURE_TEMPLATE = File.join(File.dirname(__FILE__), 'templates/feature.html.erb').freeze
  ERROR_TEMPLATE = File.join(File.dirname(__FILE__), 'templates/errors.html.erb').freeze

  def initialize(input, output='./output', name = nil, environment = nil)
    # save and ensure output folder exists
    @output = output
    create_filepath(@output)

    # load data into models
    @run = TestRun.new(load_data(input), name, environment)

    # generate html reports
    generate
  end

  def load_data(filename)
    JSON.parse(File.read(filename))
  end

  def generate
    # output main html file
    main_file = create_new_file("#{@output}/#{File.basename(MAIN_TEMPLATE, '.erb')}")
    render_files(File.read(MAIN_TEMPLATE), main_file)

    # render each feature html file
    @run.features.each do |feature|
      @temp_feature = feature
      temp = create_new_file("#{@output}/#{feature.uuid}.html")
      render_files(File.read(FEATURE_TEMPLATE), temp)
    end

    # render error categorization html file
    @errors = Errors.new(@run)
    render_files(File.read(ERROR_TEMPLATE), "#{@output}/errors.html")
  end
end
