def data_file(name)
  File.join(File.expand_path(File.dirname(__FILE__)), 'data', "#{name}.pdf")
end

def equal_in_size_as(expected_file)
  lambda do |subject_file|
    subject_file_size = File.size(subject_file)
    expected_file_size = File.size(expected_file)
    (subject_file_size - expected_file_size).zero?
  end
end

def smaller_in_size_than(expected_file)
  lambda do |subject_file|
    subject_file_size = File.size(subject_file)
    expected_file_size = File.size(expected_file)
    (subject_file_size - expected_file_size) < 0
  end
end

def bigger_in_size_than(expected_file)
  lambda do |subject_file|
    subject_file_size = File.size(subject_file)
    expected_file_size = File.size(expected_file)
    (subject_file_size - expected_file_size) > 0
  end
end

def having_same_content_as(file_or_id)
  expected_file = file_or_id.is_a?(Symbol) ? data_file(file_or_id) : file_or_id
  lambda do |subject_file|
    (File.readlines(subject_file).join <=> File.readlines(expected_file).join).zero?
  end
end
