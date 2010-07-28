require 'gjman/pdf/base'
require 'gjman/pdf/compressor'

module Gjman
  module PDF
    class << self

      def compress(src, dest)
        Compressor.do(src, dest)
      end

      def uncompress(src, dest)
        Compressor.undo(src, dest)
      end

    end
  end
end
