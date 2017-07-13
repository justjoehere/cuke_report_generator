class TestRun < Tableless
  attr_reader :runname, :filename, :features, :environment, :runtime, :duration

  def initialize(rundata, name = 'N/A', filename = nil, environment = nil, runtime = now)
    set_uuid
    @runname = name
    @filename = filename
    @environment = environment
    @features = get_features(rundata)
    @duration = @features.map(&:duration).inject(:+)
    @runtime = runtime
  end

  def get_features(featuredata)
    f = []
    featuredata.each do |feature|
      # puts feature
      f << Feature.new(feature, @uuid)
    end
    f
  end
end
