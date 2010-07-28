require File.join(File.dirname(__FILE__), '..', 'spec_helper')
require File.join(File.dirname(__FILE__), 'helpers')

describe "Gjman::PDF as compressor" do

  after do
    trash_tmp_files
  end

  describe '>> uncompressing' do

    before do
      @uncompress = lambda do |name|
        Gjman::PDF.uncompress(data_file(name), tmp_file('uncompressed').path)
      end
    end

    should 'not uncompress when pdf is uncompressed' do
      @uncompress[:uncompressed].should.be having_same_content_as(:uncompressed)
    end

    should 'uncompress when pdf is compressed' do
      @uncompress[:compressed].should.be having_same_content_as(:uncompressed)
    end

  end

  describe '>> compressing' do

    before do
      @compress = lambda do |name|
        Gjman::PDF.compress(data_file(name), tmp_file('compressed').path)
      end
    end

    should 'not compress when pdf is compressed' do
      @compress[:compressed].should.be having_same_content_as(:compressed)
    end

    should 'compress when pdf is uncompressed' do
      @compress[:uncompressed].should.be having_same_content_as(:compressed)
    end

  end

end
