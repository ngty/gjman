require File.join(File.dirname(__FILE__), '..', 'spec_helper')

module Gjman::FileSystem
  class << self
    def trashable_tmp_files
      @trashable_tmp_files ||= []
    end
  end
end

describe 'Gjman::FileSystem (ensuring file exists)' do

  before do
    @missing_file = "#{__FILE__}.x"
    @check_test_passes_and_completes_in_n_secs = lambda do |seconds_to_wait, test_proc|
      started_at = Time.now
      test_proc.call
      (Time.now - started_at).to_i.should.equal seconds_to_wait
    end
  end

  describe '> when given N seconds to wait' do

    it 'should wait & raise Gjman::FileNotFoundError if file eventually does not exist' do
      @check_test_passes_and_completes_in_n_secs[
        seconds_to_wait = 2, lambda do
          lambda { Gjman::FileSystem.file_must_exist!(@missing_file, seconds_to_wait) }.
            should.raise(Gjman::FileNotFoundError).
            message.should.equal("File '#{@missing_file}' not found.")
        end
      ]
    end

    it 'should wait & not raise Gjman::FileNotFoundError if file eventually exists' do
      # Hmm ... don't really know how to test this yet.
      true.should.be.true
    end

  end

  describe '> when not given any seconds to wait' do

    it 'should immediately raise Gjman::FileNotFoundError if file does not exist' do
      @check_test_passes_and_completes_in_n_secs[
        seconds_to_wait = 0, lambda do
          lambda { Gjman::FileSystem.file_must_exist!(@missing_file) }.
            should.raise(Gjman::FileNotFoundError).
            message.should.equal("File '#{@missing_file}' not found.")
        end
      ]
    end

    it 'should not raise Gjman::FileNotFoundError if file exists' do
      @check_test_passes_and_completes_in_n_secs[
        seconds_to_wait = 0,
        lambda { Gjman::FileSystem.file_must_exist!(__FILE__) }
      ]
    end

  end

end

describe 'Gjman::FileSystem (trashable temp files)' do

  it 'should always return a new temp file upon request' do
    (file = Gjman::FileSystem.tmp_file).class.should.equal Tempfile
  end

  it 'should support customizing of name of requested temp file' do
    (file = Gjman::FileSystem.tmp_file('zzyyxx')).class.should.equal Tempfile
    file.path.should.match(/zzyyxx/)
  end

  it 'should cache newly requested temp file' do
    orig_count = Gjman::FileSystem.trashable_tmp_files.size
    file = Gjman::FileSystem.tmp_file
    Gjman::FileSystem.trashable_tmp_files.size.should.equal orig_count.succ
    file.path.should.equal Gjman::FileSystem.trashable_tmp_files[-1].path
  end

  it 'should support trashing/deleting all previously requested temp files' do
    (0..1).each {|_| Gjman::FileSystem.tmp_file }
    orig_count = Gjman::FileSystem.trashable_tmp_files.size
    Gjman::FileSystem.trash_tmp_files
    Gjman::FileSystem.trashable_tmp_files.should.be.empty
  end

end

describe 'Gjman::FileSystem (tmp dir)' do

  it 'should remove tmp dir after block execution' do
    tmp_dir = nil
    Gjman::FileSystem.tmp_dir{|dir| tmp_dir = dir }
    tmp_dir.should.not.be.nil
    File.exists?(tmp_dir).should.be.false
  end

end
