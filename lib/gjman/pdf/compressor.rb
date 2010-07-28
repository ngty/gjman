module Gjman
  module PDF
    class Compressor < Base
      class << self

        def do(src, dest)
          multivalent(:Compress, src, dest, src.sub(/\.pdf$/, '-o.pdf'))
        end

        def undo(src, dest)
          multivalent(:Uncompress, src, dest, src.sub(/\.pdf$/, '-u.pdf'))
        end

        private

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

          # NOTE: Since pdftk is almost as dead as multivalent (last updated in 2006),
          # there is really no good reason to choose it over multivalent. Moreover,
          # since pdf comparison requires java solution, it makes sense to be consistent,
          # which is essentially sticking to java.
          #
          # def do(src, dest)
          #   pdftk(:compress, src, dest)
          # end
          #
          # def undo(src, dest)
          #   pdftk(:uncompress, src, dest)
          # end
          #
          # def pdftk(mode, src, dest)
          #   shell(:pdftk, [src, :output, dest, mode, :verbose])
          #   dest
          # end

      end
    end
  end
end
