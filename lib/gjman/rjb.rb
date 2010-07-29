module Gjman
  module Rjb
    class << self

      def initialize
        @initialized ||= (
          Rjb::load(Gjman::JARS.join(':'))
          true
        )
      end

      def classify(klass)
        ::Rjb.import(klass)
      end

      def sandbox(&block)
        initialize
        # TODO: outstanding
      end

    end
  end
end
