require File.join(File.dirname(__FILE__), '..', 'spec_helper')
require File.join(File.dirname(__FILE__), 'helpers')

describe "Gjman::PDF as merger" do

  after do
    trash_tmp_files
  end

  describe '>> merging' do

    before do
      @src_files = %w{page1 page2 page3}.map{|name| data_file(name) }
    end

    should 'merge pdfs to specified file when given {:to => FILE}' do
      merged_file = Gjman::PDF.merge(*[@src_files, {:to => tmp_file('merged').path}].flatten)
      merged_file.should.be equal_in_size_as(data_file(:merged_pages))
    end

    should 'merge pdfs to default *-m.pdf when not given {:to => FILE}' do
      merged_file = Gjman::PDF.merge(*@src_files)
      merged_file.should.be equal_in_size_as(data_file(:merged_pages))
    end

  end

end
