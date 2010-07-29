module Gjman
  module PDF
    class Matcher < Base
      class << self

        def test(pdf_x, pdf_y)
          begin
            tmp_x, tmp_y = uncompress(pdf_x, pdf_y)
            [
              same_fonts?(tmp_x, tmp_y),
              same_images?(tmp_x, tmp_y),
              same_contents?(tmp_x, tmp_y),
            ].all?
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
