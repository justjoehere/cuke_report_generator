module CukeReportGenerator
  def delete_html(directory)
    raise "Relative directory path was not provided" if directory.nil?
    Dir.glob("#{directory}/*.html").each { |f| File.delete(f) }
  end

  def create_filepath(dirname)
    unless File.directory?(dirname)
      FileUtils.mkdir_p(dirname)
    end
  end

  def create_new_file(file_path)
    File.new(file_path, 'w+')
  end

  def render_files(erb, html)
    # binding allows the erb to look up class variables
    b = binding
    renderer = ERB.new(erb)
    result = renderer.result(b)

    File.open(html, 'w') do |f|
      f.write(result)
    end
  end
end