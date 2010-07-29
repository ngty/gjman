require 'forwardable'

module Gjman
  module PDF
    class Base
      class << self

        extend Forwardable

        def_delegators Utils::PDFC, :diff
        def_delegators Utils::Multivalent, :merge, :compress, :uncompress, :fonts, :images

        def same_contents?(pdf_x, pdf_y)
          diff(pdf_x, pdf_y) !~ %r{\| # of Differences.*\-+.*(\| [1-9]+)}m
        end

        def same_fonts?(pdf_x, pdf_y)
          # The last line shows processing stats (which we don't need)
          fonts(pdf_x).split("\n")[0..-2] == fonts(pdf_y).split("\n")[0..-2]
        end

        def same_images?(pdf_x, pdf_y)
          # The fist line shows file name (which we don't need)
          images(pdf_x).split("\n")[1..-1] == images(pdf_y).split("\n")[1..-1]
        end

      end
    end
  end
end

