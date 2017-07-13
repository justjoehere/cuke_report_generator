module CukeReportGenerator
  def delete_html(directory)
    raise "Relative directory path was not provided" if directory.nil?
    Dir.glob("#{directory}/*.html").each { |f| File.delete(f) }
  end
end