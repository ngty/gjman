require 'rubygems'
require 'bacon'

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'gjman'

Bacon.summary_on_exit

def trash_tmp_files
  ($trashable_tmp_files || []).select {|f| f.path }.map(&:unlink)
  $trashable_tmp_files = nil
end

def tmp_file(file_name)
  (($trashable_tmp_files ||= []) << Tempfile.new(file_name))[-1]
end

