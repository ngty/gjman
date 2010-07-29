require File.join(File.dirname(__FILE__), 'spec_helper')

describe "Gjman::PDF as compressor" do

  after do
    trash_tmp_files
  end

  shared 'uncompressing' do

    should 'not uncompress when pdf is uncompressed' do
      @should_reflect_uncompressed_size[:uncompressed]
    end

    should 'uncompress when pdf is compressed' do
      @should_reflect_uncompressed_size[:uncompressed]
    end

    should 'return uncompressed file path' do
      @should_return_uncompressed_file_path[:uncompressed]
    end

  end

  describe '>> uncompressing (w specified dest file)' do

    before do
      @should_reflect_uncompressed_size = lambda do |name|
        uncompressed_file = Gjman::PDF.uncompress(data_file(name), :to => tmp_file('uncompressed').path)
        uncompressed_file.should.be equal_in_size_as(data_file(:uncompressed))
        uncompressed_file.should.be bigger_in_size_than(data_file(:compressed))
      end
      @should_return_uncompressed_file_path = lambda do |name|
        expected_return_file = tmp_file('uncompressed').path
        Gjman::PDF.uncompress(data_file(name), :to => expected_return_file).
          should.equal(expected_return_file)
      end
    end

    behaves_like 'uncompressing'

  end

  describe '>> uncompressing (wo specified dest file)' do

    before do
      @should_reflect_uncompressed_size = lambda do |name|
        uncompressed_file = Gjman::PDF.uncompress(data_file(name))
        uncompressed_file.should.be equal_in_size_as(data_file(:uncompressed))
        uncompressed_file.should.be bigger_in_size_than(data_file(:compressed))
      end
      @should_return_uncompressed_file_path = lambda do |name|
        expected_return_file = data_file(name).sub(/\.pdf$/,'-u.pdf')
        Gjman::PDF.uncompress(data_file(name)).should.equal(expected_return_file)
      end
    end

    behaves_like 'uncompressing'

  end

  shared 'compressing' do

    should 'not compress when pdf is compressed' do
      @should_reflect_compressed_size[:compressed]
    end

    should 'compress when pdf is uncompressed' do
      @should_reflect_compressed_size[:uncompressed]
    end

    should 'return compressed file path' do
      @should_return_compressed_file_path[:compressed]
    end

  end

  describe '>> compressing (w specified dest file)' do

    before do
      @should_reflect_compressed_size = lambda do |name|
        compressed_file = Gjman::PDF.compress(data_file(name), :to => tmp_file('compressed').path)
        compressed_file.should.be equal_in_size_as(data_file(:compressed))
        compressed_file.should.be smaller_in_size_than(data_file(:uncompressed))
      end
      @should_return_compressed_file_path = lambda do |name|
        expected_return_file = tmp_file('compressed').path
        Gjman::PDF.compress(data_file(name), :to => expected_return_file).should.equal(expected_return_file)
      end
    end

    behaves_like 'compressing'

  end

  describe '>> compressing (wo specified dest file)' do

    before do
      @should_reflect_compressed_size = lambda do |name|
        compressed_file = Gjman::PDF.compress(data_file(name))
        compressed_file.should.be equal_in_size_as(data_file(:compressed))
        compressed_file.should.be smaller_in_size_than(data_file(:uncompressed))
      end
      @should_return_compressed_file_path = lambda do |name|
        expected_return_file = data_file(name).sub(/\.pdf$/,'-o.pdf')
        Gjman::PDF.compress(data_file(name)).should.equal(expected_return_file)
      end
    end

    behaves_like 'compressing'

  end

end
