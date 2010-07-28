module Gjman
  module PDF
    class Matcher < Base
      class << self

        def test(pdf_x, pdf_y)
          begin
            tmp_x, tmp_y = [pdf_x, pdf_y].map{|pdf| uncompress(pdf) }
            java(:pdfc, [tmp_x, tmp_y]) !~ %r{\| # of Differences.*\-+.*(\| [1-9]+)}m
          ensure
            FileSystem.trash_tmp_files
          end
        end

        private

          def uncompress(pdf)
            Gjman::PDF.uncompress(
              pdf, :to => FileSystem.tmp_file([Digest::MD5.hexdigest(pdf),'.pdf']).path
            )
          end

      end
    end
  end
end
