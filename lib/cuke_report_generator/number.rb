class Numeric
  def percent_of(n)
    raise "total can't be 0" if n.to_f == 0.0
    to_f / n.to_f * 100.0
  end
end
