require File.join(File.dirname(__FILE__), '..', 'spec_helper')
require File.join(File.dirname(__FILE__), 'helpers')

describe "Gjman::PDF as compressor" do

  after do
    trash_tmp_files
  end

  describe '>> uncompressing' do

    before do
      @should_reflect_uncompressed_size = lambda do |name|
        uncompressed_file = Gjman::PDF.uncompress(data_file(name), tmp_file('uncompressed').path)
        uncompressed_file.should.be equal_in_size_as(data_file(:uncompressed))
        uncompressed_file.should.be bigger_in_size_than(data_file(:compressed))
      end
    end

    should 'not uncompress when pdf is uncompressed' do
      @should_reflect_uncompressed_size[:uncompressed]
    end

    should 'uncompress when pdf is compressed' do
      @should_reflect_uncompressed_size[:uncompressed]
    end

  end

  describe '>> compressing' do

    before do
      @should_reflect_compressed_size = lambda do |name|
        compressed_file = Gjman::PDF.compress(data_file(name), tmp_file('compressed').path)
        compressed_file.should.be equal_in_size_as(data_file(:compressed))
        compressed_file.should.be smaller_in_size_than(data_file(:uncompressed))
      end
    end

    should 'not compress when pdf is compressed' do
      @should_reflect_compressed_size[:compressed]
    end

    should 'compress when pdf is uncompressed' do
      @should_reflect_compressed_size[:uncompressed]
    end

  end

end
