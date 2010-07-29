require 'gjman/pdf/utils'
require 'gjman/pdf/base'
require 'gjman/pdf/matcher'
require 'gjman/pdf/merger'
require 'gjman/pdf/compressor'

module Gjman
  module PDF
    class << self

      def match?(x, y)
        Matcher.test(x, y)
      end

      def merge(*args)
        Merger.do(*args)
      end

      def compress(src, opts={})
        Compressor.do(src, opts)
      end

      def uncompress(src, opts={})
        Compressor.undo(src, opts)
      end

    end
  end
end
