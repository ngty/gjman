module Gjman
  module PDF
    class Compressor < Base
      class << self

        def do(src, dest)
          pdftk(:compress, src, dest)
          # multivalent(:Compress, src, dest, src.sub(/\.pdf$/, '-o.pdf'))
        end

        def undo(src, dest)
          pdftk(:uncompress, src, dest)
          # multivalent(:Uncompress, src, dest, src.sub(/\.pdf$/, '-u.pdf'))
        end

        private

         def pdftk(mode, src, dest)
           shell(:pdftk, [src, :output, dest, mode])
           dest
         end

         def multivalent(mode, src, dest, tmp_dest)
           java(:multivalent, %W{tool.pdf.#{mode} #{src}})
           File.move(tmp_dest, dest)
           dest
         end

      end
    end
  end
end
