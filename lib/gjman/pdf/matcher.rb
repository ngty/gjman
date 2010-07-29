module Gjman
  module PDF
    class Matcher < Base
      class << self

        def test(pdf_x, pdf_y)
          begin
            tmp_x, tmp_y = uncompress(pdf_x, pdf_y)
            ! [:same_fonts?, :same_images?, :same_contents?].
              any?{|test| !send(test, tmp_x, tmp_y) }
          ensure
            FileSystem.trash_tmp_files
          end
        end

        private

          def uncompress(*pdfs)
            [pdfs].flatten.map do |pdf|
              tmp = FileSystem.tmp_file([Digest::MD5.hexdigest(pdf),'.pdf']).path
              PDF.uncompress(pdf, :to => tmp)
            end
          end

      end
    end
  end
end
