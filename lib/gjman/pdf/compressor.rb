module Gjman
  module PDF
    class Compressor < Base
      class << self

        def do(src, dest)
          work(:Compress, src, dest, src.sub(/\.pdf$/, '-o.pdf'))
        end

        def undo(src, dest)
          work(:Uncompress, src, dest, src.sub(/\.pdf$/, '-u.pdf'))
        end

        private

         def work(mode, src, dest, tmp_dest)
           java(:multivalent, %W{tool.pdf.#{mode} #{src}})
           File.move(tmp_dest, dest)
           dest
         end

      end
    end
  end
end
