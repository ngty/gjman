module Gjman
  module PDF
    class Compressor < Base
      class << self

        def do(src, dest)
          #pdftk(:compress, src, dest)
          multivalent(:Compress, src, dest, src.sub(/\.pdf$/, '-o.pdf'))
        end

        def undo(src, dest)
          #pdftk(:uncompress, src, dest)
          multivalent(:Uncompress, src, dest, src.sub(/\.pdf$/, '-u.pdf'))
        end

        private

         def pdftk(mode, src, dest)
           shell(:pdftk, [src, :output, dest, mode, :verbose])
           dest
         end

         def multivalent(mode, src, dest, tmp_dest)
           case java(:multivalent, %W{tool.pdf.#{mode} #{src}})
           when /Already compressed\.  \(Force recompression with \-force\.\)/,
             /java\.lang\.ArrayIndexOutOfBoundsException/
             File.copy(src, dest)
           else
             File.move(tmp_dest, dest)
           end
           dest
         end

      end
    end
  end
end
