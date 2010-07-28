require File.join(File.dirname(__FILE__), '..', 'spec_helper')
require File.join(File.dirname(__FILE__), 'helpers')

describe "Gjman::PDF as matcher" do

  have_matching_content = lambda do |name1, name2|
    Gjman::PDF.match?(data_file(name1), data_file(name2))
  end

  describe "> matching pdfs (with text content)" do

    should 'return false if pdfs have different texts' do
      have_matching_content[:text_x1, :text_y1].should.be.false
    end

    should 'return true if pdfs have identical texts' do
      have_matching_content[:text_x1, :text_x2].should.be.true
    end

    should 'return false if pdfs have identical texts, but positioned differently' do
      have_matching_content[:text_y1, :text_y2_diff_pos].should.be.false
    end

    should 'return false if pdfs have identical texts, but sized differently' do
      have_matching_content[:text_y1, :text_y3_diff_size].should.be.false
    end

    should 'return false if pdfs have identical texts, but with different fonts' do
      have_matching_content[:text_y1, :text_y4_diff_font].should.be.false
    end

    should 'return false if pdfs have identical texts, but with different styles' do
      have_matching_content[:text_y1, :text_y5_diff_style].should.be.false
    end

    should 'return false if pdfs have identical texts, but with different colors' do
      have_matching_content[:text_y1, :text_y6_diff_color].should.be.false
    end

    should 'return false if pdfs have identical texts, but with different backgrounds' do
      have_matching_content[:text_y1, :text_y7_diff_bg].should.be.false
    end

  end

  describe '> matching pdfs (with picture content)' do

    should 'return false if pdfs have different images' do
      have_matching_content[:picture_x1, :picture_y1].should.be.false
    end

    should 'return true if pdfs have identical images' do
      have_matching_content[:picture_x1, :picture_x2].should.be.true
    end

    should 'return false if pdfs have identical images, but positioned differently' do
      have_matching_content[:picture_x1, :picture_x3_diff_pos].should.be.false
    end

    should 'return false if pdfs have identical images, but sized differently' do
      have_matching_content[:picture_x1, :picture_x4_diff_size].should.be.false
    end

  end

end
