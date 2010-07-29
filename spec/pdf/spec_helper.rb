require File.join(File.dirname(__FILE__), '..', 'spec_helper')
require 'gjman/pdf'

def data_file(name)
  File.join(File.expand_path(File.dirname(__FILE__)), 'data', "#{name}.pdf")
end

def having_same_content_as(file_or_id)
  expected_file = file_or_id.is_a?(Symbol) ? data_file(file_or_id) : file_or_id
  lambda do |subject_file|
    (File.readlines(subject_file).join <=> File.readlines(expected_file).join).zero?
  end
end
