require 'rubygems'
require 'bacon'

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
# require 'gjman'

Bacon.summary_on_exit

def trash_tmp_files
  ($trashable_tmp_files || []).select {|f| f.path }.map(&:unlink)
  $trashable_tmp_files = nil
end

def tmp_file(file_name)
  (($trashable_tmp_files ||= []) << Tempfile.new(file_name))[-1]
end

def equal_in_size_as(expected_file)
  lambda do |subject_file|
    subject_file_size = File.size(subject_file).to_f
    expected_file_size = File.size(expected_file).to_f
    ((subject_file_size - expected_file_size).abs / subject_file_size) < 0.0001
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

