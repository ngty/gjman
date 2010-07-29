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
          fonts(pdf_x).split("\n")[1..-1] == fonts(pdf_y).split("\n")[1..-1]
        end

        def same_images?(pdf_x, pdf_y)
          puts '', pdf_x, images(pdf_x)
          puts '', pdf_y, images(pdf_y)

          images(pdf_x).split("\n")[1..-1] == images(pdf_y).split("\n")[1..-1]
        end

      end
    end
  end
end

