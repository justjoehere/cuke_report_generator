class TestRun < Tableless
  attr_reader :runname, :features, :environment, :runtime, :duration

  def initialize(rundata, runname = nil, environment = nil )
    set_uuid
    @runname = runname
    @environment = environment
    @features = get_features(rundata)
    @duration = @features.map(&:duration).inject(:+)
    @runtime = DateTime.now
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
