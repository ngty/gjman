require 'gjman/pdf/base'
require 'gjman/pdf/merger'
require 'gjman/pdf/compressor'

module Gjman
  module PDF
    class << self

      def merge(*args)
        Merger.do(*args)
      end

      def compress(src, dest)
        Compressor.do(src, dest)
      end

      def uncompress(src, dest)
        Compressor.undo(src, dest)
      end

    end
  end
end
